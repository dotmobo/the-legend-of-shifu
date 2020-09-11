
function initPlayer(layer)
	local spawn = getPlayerSpawn()
	loadPlayer(layer, spawn)
	updatePlayer(layer)
	drawPlayer(layer)
	removeUnneededLayer()
end

-- récupère le spawn
function getPlayerSpawn()
    local player
    for k, object in pairs(Map.objects) do
        if object.name == PLAYER_OBJECT_NAME then
			player = object
			break
		end
    end
    return player
end

function playerFilter(item, other)
	if other.isEnemy then
		return "touch"
	else
		return "slide"
	end
end

function playerCollide(cols, len)
	-- deal with the collisions
	-- TODO invinsibility frame before
	-- for i=1,len do
	-- 	print('player collided with ' .. tostring(cols[i].type))
	-- 	if cols[i].type == 'touch' then
	-- 		cols[i].item.hitted = true
	-- 		cols[i].item.hittedTime = 1
	-- 		cols[i].item.life = cols[i].item.life - 1
	--		cols[i].item.hitSound:setVolume(GAME_EFFECTS_VOLUME)
	-- 		cols[i].item.hitSound:play()
	-- 	end
	-- end
end

function movePlayer(player, goalX, goalY)
	local actualX, actualY, cols, len = World:move(player, goalX, goalY, playerFilter)
	player.x, player.y = actualX, actualY
	playerCollide(cols, len)
end

-- creer le jouer dans le layer
function loadPlayer(layer, player)
	local sprite = love.graphics.newImage(PLAYER_SPRITE_PATH)
	local g = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, sprite:getWidth(), sprite:getHeight())
	local bulletSprite = love.graphics.newImage(PLAYER_WEAPON_PATH)
	--load sound
	local bulletSound = love.audio.newSource(BULLET_SOUND_PATH, "static")
	local hitSound = love.audio.newSource(PLAYER_HIT_SOUND_PATH, "static")

    layer.player = {
		isPlayer = true,
		sprite = sprite,
		animations = {
			stop = Anim8.newAnimation(g('1-2','1-2'), 0.25),
			move = Anim8.newAnimation(g('1-2','3-3'), 0.125)
		},
		x      = player.x,
		y      = player.y,
		spawnX      = player.x,
		spawnY      = player.y,
		width = GAME_SPRITE_SIZE,
		height = GAME_SPRITE_SIZE,
		speed = PLAYER_SPEED,
		bullets = {},
		bulletSprite = bulletSprite,
		bulletSound = bulletSound,
		bulletWidth = BULLET_WIDTH,
		bulletHeight = BULLET_HEIGHT,
		life = PLAYER_LIFE,
		hitSound = hitSound,
		hitted = false,
		hittedTime = 0,
		weapon = "pee",
		moves = {
			stop = "stop",
			up = "up",
			down = "down",
			left = "left",
			right = "right"
		}
		-- ox     = sprite:getWidth() / 2,
		-- oy     = sprite:getHeight() / 1.10
	}
	layer.player.gotToSpawn = function()
		layer.player.x = layer.player.spawnX
		layer.player.y = layer.player.spawnY
		movePlayer(layer.player, layer.player.x, layer.player.y)
	end
	layer.player.animation = layer.player.animations.stop
	layer.player.move = layer.player.moves.stop
	World:add(layer.player, layer.player.x, layer.player.y, layer.player.width, layer.player.height)
end

function updatePlayer(layer)

	currentShootTimer = 0
	layer.update = function(self, dt)
		if self.player.life <=0 then
			Gamestate.switch(Lose)
		end
		-- hit
		if self.player.hitted and self.player.hittedTime > 0 then
			self.player.hittedTime = self.player.hittedTime - GAME_HITTED_SPEED*dt
			if self.player.hittedTime <= 0 then
				self.player.hitted = false
			end
		end
		-- default animation
		layer.player.move = layer.player.moves.stop
		-- Move player up
		if love.keyboard.isDown("up") or (Joystick and (Joystick:isGamepadDown('dpup') or Joystick:getGamepadAxis('lefty') <= -0.25)) then
			layer.player.move = layer.player.moves.up
			movePlayer(self.player, self.player.x, self.player.y - self.player.speed * dt)
		end
		-- Move player down
		if love.keyboard.isDown("down") or (Joystick and (Joystick:isGamepadDown('dpdown') or Joystick:getGamepadAxis('lefty') >= 0.25)) then
			layer.player.move = layer.player.moves.down
			movePlayer(self.player, self.player.x, self.player.y + self.player.speed * dt)
		end
		-- Move player left
		if love.keyboard.isDown("left") or (Joystick and (Joystick:isGamepadDown('dpleft') or Joystick:getGamepadAxis('leftx') <= -0.25)) then
			layer.player.move = layer.player.moves.left
			movePlayer(self.player, self.player.x - self.player.speed * dt, self.player.y)
		end
		-- Move player right
		if love.keyboard.isDown("right") or (Joystick and (Joystick:isGamepadDown('dpright') or Joystick:getGamepadAxis('leftx') >= 0.25)) then
			layer.player.move = layer.player.moves.right
			movePlayer(self.player, self.player.x + self.player.speed * dt, self.player.y)
		end

		-- animation
		if layer.player.move ~= layer.player.moves.stop then
			-- move animation
			self.player.animation = self.player.animations.move
		else
			-- static animation by default
			self.player.animation = self.player.animations.stop
		end
		-- On met à jour l'animation du joueur
		self.player.animation:update(dt)

		-- add bullet
		currentShootTimer = currentShootTimer + dt
		if currentShootTimer > BULLET_TIMER then
			if love.keyboard.isDown("z", "w") or (Joystick and (Joystick:isGamepadDown('y') or Joystick:getGamepadAxis('righty') <= -0.75)) then
				local bullet = createBullet(self.player, "up")
				currentShootTimer = 0
			elseif love.keyboard.isDown("s") or (Joystick and (Joystick:isGamepadDown('a') or Joystick:getGamepadAxis('righty') >= 0.75)) then
				local bullet = createBullet(self.player, "down")
				currentShootTimer = 0
			elseif love.keyboard.isDown("a", "q") or (Joystick and (Joystick:isGamepadDown('x') or Joystick:getGamepadAxis('rightx') <= -0.75)) then
				local bullet = createBullet(self.player, "left")
				currentShootTimer = 0
			elseif love.keyboard.isDown("d") or (Joystick and (Joystick:isGamepadDown('b') or Joystick:getGamepadAxis('rightx') >= 0.75)) then
				local bullet = createBullet(self.player, "right")
				currentShootTimer = 0
			end
		end
		-- move bullet
		for index, bullet in ipairs(self.player.bullets) do
			if bullet.move == bullet.moves.down then
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y + BULLET_SPEED * dt, 'isEnemy')
			elseif bullet.move == bullet.moves.left then
				moveBullet(self.player.bullets, index, bullet, bullet.x - BULLET_SPEED * dt, bullet.y, 'isEnemy')
			elseif bullet.move == bullet.moves.right then
				moveBullet(self.player.bullets, index, bullet, bullet.x + BULLET_SPEED * dt, bullet.y, 'isEnemy')
			else
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y - BULLET_SPEED * dt, 'isEnemy')
			end
		end
	end
end

-- on dessine le joueur
function drawPlayer(layer)
	layer.draw = function(self)
		if self.player.hitted then
			love.graphics.setColor(208, 0, 0, 1)
		else
			love.graphics.setColor(255, 255, 255, 1)
		end
		-- player's animation
		self.player.animation:draw(self.player.sprite, math.floor(self.player.x), math.floor(self.player.y))
		-- player's bullets
		for _,bullet in ipairs(self.player.bullets) do
			if bullet.move == bullet.moves.left or bullet.move == bullet.moves.right then
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y, math.rad(90))
			else
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y)
			end
		end
		if DEBUG_ENABLE then
			love.graphics.setPointSize(5)
			love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
		end

	end
end

-- on supprime le layer de spawn devenu inutile
function removeUnneededLayer()
    Map:removeLayer("player")
end