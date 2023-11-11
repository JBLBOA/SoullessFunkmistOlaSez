function onEvent(name, value1, value2)
	if name == "bob jumpscare" then
		makeLuaSprite('kk', 'bob', 0, 0);
		addLuaSprite('kk', true);
		playSound('kk');
		triggerEvent('Screen Shake', '0.10, 0.10', '0.7, 0.7');
		doTweenColor('hello', 'kk', 'FFFFFFFF', 0.2, 'kk');
		setObjectCamera('kk', 'kk');
		runTimer('wait', 0.5);
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'kk' then
		doTweenAlpha('byebye', 'kk', 1, 0.1, 'linear');
	end
end

function onTweenCompleted(tag)
	if tag == 'kk' then
		removeLuaSprite('kk', true);
	end
end