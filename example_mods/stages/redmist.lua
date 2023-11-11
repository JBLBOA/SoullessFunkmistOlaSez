function onCreate()
	-- background shit
	makeLuaSprite('redmistBack', 'redmistBack', -400, -100);
	setLuaSpriteScrollFactor('redmistBack', 1.0, 1.0);
	scaleObject('redmistBack', 1.0, 1.0);

        makeLuaSprite('redmistFront', 'redmistFront', -400, -100);
	setLuaSpriteScrollFactor('redmistFront', 1.0, 1.0);
	scaleObject('redmistFront', 1.0, 1.0);

	addLuaSprite('redmistBack', false);
        addLuaSprite('redmistFront', false);



	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end