function onCreate()
    makeAnimatedLuaSprite('TacosDeCaca idle','TacosDeCaca',300,400)
    addAnimationByPrefix('TacosDeCaca idle','caca','TacosDeCaca idle',3,false)
    setProperty('TacosDeCaca idle.alpha',0.001)
    scaleObject('TacosDeCaca idle', 1.0, 1.0)
    setObjectCamera('TacosDeCaca idle','hud')
    addLuaSprite('TacosDeCaca idle',true)
end
function onUpdate()
    if getProperty('TacosDeCaca idle.animation.curAnim.finished') then
        removeLuaSprite('TacosDeCaca idle',false)
    end
end
function onEvent(name)
    if name == 'TacosDeCaca idle' then
        addLuaSprite('TacosDeCaca idle',true)
        setProperty('TacosDeCaca idle.alpha',1)
        playSound('TacosDeCaca idle')
        objectPlayAnimation('TacosDeCaca idle','caca',true)
        cameraShake('camGame',0.000,1)
        cameraShake('camHud',0.000,1)
    end
end