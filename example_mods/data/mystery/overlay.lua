function onCreatePost()
        makeLuaSprite("color", "overlays/yummer", -150, -10)
	setObjectCamera("color", "hud")
	setProperty("color.alpha", 0.8)
	scaleObject("color", 1.5, 1.3)
        setBlendMode("color", "subtract")
	updateHitbox("color")

        addLuaSprite("color", true)
        
end