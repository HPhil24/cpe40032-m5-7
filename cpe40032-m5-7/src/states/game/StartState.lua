--[[
    CMPE40032
    Super Mario Bros. Remake

    -- StartState Class --

]]

StartState = Class{__includes = BaseState}

function StartState:init()
	self.map = LevelMaker.generate(100, 10)
	self.background = math.random(3)

	gSounds['play-bg']:setLooping(true)
	gSounds['play-bg']:setVolume(0.3)
	gSounds['play-bg']:play()
end

function StartState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('play', {
			level = self.map,
			background = self.background,
			levelNumber = 1,
			score = 0,
		})
	end
end

function StartState:render()
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    self.map:render()

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf(' Super Alien Bros.', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(' Super Alien Bros.', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 29, VIRTUAL_WIDTH, 'center')
end
