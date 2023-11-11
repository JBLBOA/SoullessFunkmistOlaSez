function onCreate()
    makeAnimatedLuaSprite('Bubbles','Bubble Transition',130,0)
    addAnimationByPrefix('Bubbles','burbuja','Bubbles',24,false)
    setProperty('Bubbles.alpha',0.001)
    scaleObject('Bubbles', 3.0, 3.0)
    setObjectCamera('Bubbles','hud')
    addLuaSprite('Bubbles',true)
end
function onUpdate()
    if getProperty('Bubbles.animation.curAnim.finished') then
        removeLuaSprite('Bubbles',false)
    end
end
function onEvent(name)
    if name == 'Bubbles' then
        addLuaSprite('Bubbles',true)
        setProperty('Bubbles.alpha',1)
        playSound('Transition')
        objectPlayAnimation('Bubbles','burbuja',true)
        cameraShake('camGame',0.000,1)
        cameraShake('camHud',0.000,1)
    end
end