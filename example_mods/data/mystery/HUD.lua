local healthBarIsFlip = true
local stickThere = false
function onUpdate(elapsed)
	if healthBarIsFlip == true then
		setProperty('healthBar.flipX', true)
		if getProperty('health') < 2 then
			stickThere = false
		end

		if getProperty('health') >= 2 then
			stickThere = true
		end
	else
		setProperty('healthBar.flipX', false)
end
end
function onCreatePost()
	if not middleScroll then
        setPropertyFromGroup('opponentStrums', 0, 'x', -5000);
        setPropertyFromGroup('opponentStrums', 1, 'x', -5000);
        setPropertyFromGroup('opponentStrums', 2, 'x', -5000);
        setPropertyFromGroup('opponentStrums', 3, 'x', -5000);
        setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 320);
        setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 320);
        setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 320);
        setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 320);
	end
	end

function onUpdatePost() -- pa' que el icono se de vuelta y funcione
	if healthBarIsFlip == true then
		setProperty('iconP1.flipX', true)
		setProperty('iconP2.flipX', true)
		if stickThere == false then
			if getProperty('health') > 0 then
				setProperty('iconP1.x', 226+getProperty('health')*296+getProperty('healthBar.x')-359.5)
				setProperty('iconP2.x', 357+getProperty('health')*297+getProperty('healthBar.x')-359.5)
			end
			if getProperty('health') <= 0 then
				setProperty('iconP1.x', 216+getProperty('healthBar.x')-359.5)
				setProperty('iconP2.x', 317+getProperty('healthBar.x')-359.5)
			end
		end
		if stickThere == true then
		   setProperty('iconP1.x', 818+getProperty('healthBar.x')-359.5)
		   setProperty('iconP2.x', 953+getProperty('healthBar.x')-359.5)
		end

	else
		setProperty('iconP1.flipX', false)
		setProperty('iconP2.flipX', false)
	end
end