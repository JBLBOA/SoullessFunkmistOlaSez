function onCreate()
	-- background shit
	makeLuaSprite('caca', 'caca', -700, -300);
	setLuaSpriteScrollFactor('mist', 1.2, 1.2);
	
	addLuaSprite('caca', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end