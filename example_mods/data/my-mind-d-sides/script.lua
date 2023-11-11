local bfcamX = 0;
local bfcamY = 0;
local camX = 0;
local camY = 0;

function onCreate()
	makeLuaSprite('blackbg', 'mymind', 0, 0);

    makeLuaSprite('circle', 'invisible', 777, 0);

    makeLuaSprite('text', 'invisible', -1200, 0);

    setObjectCamera('blackbg', 'hud');

    setObjectCamera('circle', 'hud');

    setObjectCamera('text', 'hud');

    makeLuaSprite('vg', 'invisible');

    setObjectCamera('vg', 'hud');

    addLuaSprite('blackbg', true);
    addLuaSprite('circle', true);
    addLuaSprite('text', true);


end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'notfuckedanymore' then
        removeLuaSprite('theshitassthatdistractsyou', false);
    end
    if tag == 'bye1' then
        removeLuaSprite('wowa', false);
    end
    if tag == 'bye2' then
        removeLuaSprite('wowa2', false);
    end
end

function onTweenCompleted(tag)
    if tag == 'circleTweenX' then
        doTweenAlpha('removecircle', 'circle', 0, 1, 'linear');
    end
    if tag == 'textTweenX' then
        doTweenAlpha('removetext', 'text', 0, 1, 'linear');
    end
    if tag == 'removetext' then 
        removeLuaSprite('text');
        doTweenAlpha('removebg', 'blackbg', 0, 0.5, 'linear');
    end
    if tag == 'removecircle' then 
        removeLuaSprite('circle');
    end
    if tag == 'removebg' then 
        removeLuaSprite('blackbg');
    end
    if tag == 'dothetweenvg' then
        doTweenAlpha('dothetweenvgagain', 'vg', 1, 1, 'quadInOut');
    end
end

function onEvent(name, value1, value2)
    if name == 'YOU MISSED THE STATIC NOTE NOW GET FUCKED' then
        makeAnimatedLuaSprite('theshitassthatdistractsyou', 'hitStatic', 0, 0);

        addAnimationByPrefix('FUCKYOU', 'static', 'staticANIMATION', 24, false);
        
        objectPlayAnimation('FUCKYOU', true);

        setObjectCamera('theshitassthatdistractsyou', 'hud');

        addLuaSprite('theshitassthatdistractsyou', true);

        runTimer('notfuckedanymore', 0.2, 1);
    end
end


function onStepHit()
    if curStep == 1 then 
        doTweenX('circleTweenX', 'circle', 0, 1, 'linear');
        doTweenX('textTweenX', 'text', 0, 1, 'linear');
        
        setProperty('vg.visible', false);

        addLuaSprite('vg', true);
    end 
    if curStep == 80 then 
        setProperty('vg.visible', true);
    end 
    if curStep == 528 then
        setProperty('vg.visible', false);

        playSound('staticBUZZ', 1);

        makeAnimatedLuaSprite('wowa', '', 0, 0);

        addAnimationByPrefix('flashyboi', '', '', 24, false);
        
        objectPlayAnimation('flashyboi', true);

        setGraphicSize('wowa', 1280, 720);

        setObjectCamera('wowa', 'hud');

        addLuaSprite('wowa', true);

        runTimer('bye1', 0.3, 1);

    end
    if curStep == 784 then
        setProperty('vg.visible', true);

        playSound('staticBUZZ', 1);

        makeAnimatedLuaSprite('wowa2', '', 0, 0);

        addAnimationByPrefix('flashyboi', '', '', 24, false);
        
        objectPlayAnimation('flashyboi', true);

        setGraphicSize('wowa2', 1280, 720);

        setObjectCamera('wowa2', 'hud');

        addLuaSprite('wowa2', true);

        runTimer('bye2', 0.3, 1);
    end
end 




