package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	public var runtimeShaders:Map<String, Array<String>> = new Map<String, Array<String>>();
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var episodes:FlxSprite;
	var episodes1:FlxSprite;

	var extras:FlxSprite;
	var extras2:FlxSprite;

	var configuracion:FlxSprite;
	var creditos:FlxSprite;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/menu'));
		bg.scrollFactor.set(0, 0);
		bg.updateHitbox();
		bg.screenCenter();
		bg.scale.x = 0.5;
		bg.scale.y = 0.51;
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		episodes = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/episodes'));
		episodes.scrollFactor.set(0, 0);
		episodes.updateHitbox();
		episodes.screenCenter();
		episodes.scale.x = 0.5;
		episodes.scale.y = 0.51;
		episodes.antialiasing = ClientPrefs.globalAntialiasing;
		add(episodes);

		episodes1 = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/episodes1'));
		episodes1.scrollFactor.set(0, 0);
		episodes1.updateHitbox();
		episodes1.screenCenter();
		episodes1.scale.x = 0.5;
		episodes1.scale.y = 0.51;
		episodes1.antialiasing = ClientPrefs.globalAntialiasing;
		add(episodes1);

		extras = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/extras'));
		extras.scrollFactor.set(0, 0);
		extras.updateHitbox();
		extras.screenCenter();
		extras.scale.x = 0.5;
		extras.scale.y = 0.51;
		extras.antialiasing = ClientPrefs.globalAntialiasing;
		add(extras);

		extras2 = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/extras2'));
		extras2.scrollFactor.set(0, 0);
		extras2.updateHitbox();
		extras2.screenCenter();
		extras2.scale.x = 0.5;
		extras2.scale.y = 0.51;
		extras2.antialiasing = ClientPrefs.globalAntialiasing;
		add(extras2);

		configuracion = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/configuracion'));
		configuracion.scrollFactor.set(0, 0);
		configuracion.updateHitbox();
		configuracion.screenCenter();
		configuracion.scale.x = 0.5;
		configuracion.scale.y = 0.51;
		configuracion.antialiasing = ClientPrefs.globalAntialiasing;
		add(configuracion);

		creditos = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/nuevomenu/creditos'));
		creditos.scrollFactor.set(0, 0);
		creditos.updateHitbox();
		creditos.screenCenter();
		creditos.scale.x = 0.5;
		creditos.scale.y = 0.51;
		creditos.antialiasing = ClientPrefs.globalAntialiasing;
		add(creditos);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			//menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	//	add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	//	add(versionShit);
    

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		/*if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}*/
		#if desktop
		if (FlxG.keys.anyJustPressed(debugKeys))
		{
			selectedSomethin = true;
			MusicBeatState.switchState(new MasterEditorMenu());
		}
		#end

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
	
	#if (!flash && sys)
    public function createRuntimeShader(name:String):FlxRuntimeShader
    {
        if(!ClientPrefs.shaders) return new FlxRuntimeShader();

        #if (!flash && MODS_ALLOWED && sys)
        if(!runtimeShaders.exists(name) && !initLuaShader(name))
        {
            FlxG.log.warn('Shader $name is missing!');
            return new FlxRuntimeShader();
        }

        var arr:Array<String> = runtimeShaders.get(name);
        return new FlxRuntimeShader(arr[0], arr[1]);
        #else
        FlxG.log.warn("Platform unsupported for Runtime Shaders!");
        return null;
        #end
    }

    public function initLuaShader(name:String, ?glslVersion:Int = 120)
    {
        if(!ClientPrefs.shaders) return false;

        if(runtimeShaders.exists(name))
        {
            FlxG.log.warn('Shader $name was already initialized!');
            return true;
        }

        var foldersToCheck:Array<String> = [Paths.mods('shaders/')];
        if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
            foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/shaders/'));

        for(mod in Paths.getGlobalMods())
            foldersToCheck.insert(0, Paths.mods(mod + '/shaders/'));
        
        for (folder in foldersToCheck)
        {
            if(FileSystem.exists(folder))
            {
                var frag:String = folder + name + '.frag';
                var vert:String = folder + name + '.vert';
                var found:Bool = false;
                if(FileSystem.exists(frag))
                {
                    frag = File.getContent(frag);
                    found = true;
                }
                else frag = null;

                if (FileSystem.exists(vert))
                {
                    vert = File.getContent(vert);
                    found = true;
                }
                else vert = null;

                if(found)
                {
                    runtimeShaders.set(name, [frag, vert]);
                    //trace('Found shader $name!');
                    return true;
                }
            }
        }
        FlxG.log.warn('Missing shader $name .frag AND .vert files!');
        return false;
    }
    #end
}
