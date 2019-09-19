--[[
    CMPE40032
    Super Mario Bros. Remake

    -- VictoryState Class --

]]
VictoryState = Class{__includes = BaseState}

function VictoryState:init()
	gSounds['victory-bg']:setLooping(true)
	gSounds['victory-bg']:setVolume(0.5)
	gSounds['victory-bg']:play()

	self.timer = 0
end

function VictoryState:enter(params)
	self.levelNumber = params.levelNumber
	self.player = params.player
	self.background = params.background
end

function VictoryState:update(dt)
	if self.timer > 3 and (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
		gSounds['victory-bg']:stop()
		gStateMachine:change('play', {
			level = LevelMaker.generate(self.player.map.width + 10, 10),
			background = math.random(3),
			levelNumber = self.levelNumber + 1,
			score = self.player.score,
	
		})
	end

	self.timer = self.timer + dt
end

function VictoryState:render()
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
		gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

	love.graphics.setColor(0, 0, 0, 120)
	love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

	love.graphics.setFont(gFonts['medium'])
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.printf('Level ' .. tostring(self.levelNumber), 1, VIRTUAL_HEIGHT / 2 - 55 + 1, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf('Level ' .. tostring(self.levelNumber), 0, VIRTUAL_HEIGHT / 2 - 55, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.setFont(gFonts['large'])
	love.graphics.printf('COMPLETE', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf('COMPLETE', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

	local text = {
		'Score: '.. tostring(self.player.score),

		'Killed: '
	}

	local creaturePosition = {
		VIRTUAL_WIDTH - 162,
		VIRTUAL_WIDTH - 116,
	}

	if self.timer > 0.75 then
		love.graphics.setFont(gFonts['medium'])
		gPrint(text[1], 4, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
	end


	if self.timer > 1.25 then
		love.graphics.setFont(gFonts['medium'])
		gPrint(text[2], 4, VIRTUAL_HEIGHT / 2+20, VIRTUAL_WIDTH - 50, 'center')

		love.graphics.draw(gTextures['creatures'], gFrames['creatures'][49], creaturePosition[1] + 45, VIRTUAL_HEIGHT / 2 +18)
		gPrint('x' .. tostring(self.player.killCount[1]), creaturePosition[1] + 65, VIRTUAL_HEIGHT / 2 +20)
	end

	if self.timer > 1.5 then
		love.graphics.setFont(gFonts['medium'])
		gPrint('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 54, VIRTUAL_WIDTH, 'center')
	end
end
