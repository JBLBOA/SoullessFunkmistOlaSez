function onCreate()
	-- background shit
	makeLuaSprite('yummer', 'yummer', 0, 0);
	setLuaSpriteScrollFactor('yummer', 1.0, 1.0);
	scaleObject('yummer', 1.0, 1.0);

        makeLuaSprite('yummerfront', 'yummerfront', 0, 0);
	setLuaSpriteScrollFactor('yummerfront', 1.0, 1.0);
	scaleObject('yummerfront', 1.0, 1.0);

        makeLuaSprite('Yummerpage','Yummerpage', -290, -160);
        setScrollFactor('Yummerpage', 0.0, 0.0);
        scaleObject('Yummerpage', 1.3, 1.3);



	addLuaSprite('yummer', false);
        addLuaSprite('yummerfront', true);
        addLuaSprite('Yummerpage', true);

	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end