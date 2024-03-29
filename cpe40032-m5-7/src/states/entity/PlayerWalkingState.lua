--[[
    CMPE40032
    Super Mario Bros. Remake

]]


PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
	self.player = player
	self.animation = Animation {
		frames = {10, 11},
		interval = 0.1
	}
	self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
	self.player.currentAnimation:update(dt)

	if self.player.victory then
		self.player:changeState('victory')
	end

	-- idle if we're not pressing anything at all
	if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
		self.player:changeState('idle')
	else
		local tileBottomLeft = self.player.map:pointToTile(self.player.x + 4, self.player.y + self.player.height)
		local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 4, self.player.y + self.player.height)

		-- temporarily shift player down a pixel to test for game objects beneath
		self.player.y = self.player.y + 1

		local collidedObjects = self.player:checkObjectCollisions()

		self.player.y = self.player.y - 1

		-- check to see whether there are any tiles beneath us
		if #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
			self.player.dy = 0
			self.player:changeState('falling', {Momentum = self.player.speed})
		elseif love.keyboard.isDown('left') then
			self.player.x = self.player.x - self.player.speed * dt
			self.player.direction = 'left'
			self.player:checkLeftCollisions(dt)
		elseif love.keyboard.isDown('right') then
			self.player.x = self.player.x + self.player.speed * dt
			self.player.direction = 'right'
			self.player:checkRightCollisions(dt)
		end
	end

	-- check if we've collided with any entities and die if so
	for k, entity in pairs(self.player.level.entities) do
		if entity:collides(self.player) then
			self.player.gameOver = true
			self.player:changeState('death')
		end
	end

	if love.keyboard.wasPressed('space') then
		self.player:changeState('jump', {heightMod = 0, Momentum = self.player.speed})
	end
end
