-- ajout du calque pour le joueur
function addPlayerLayer(map)
    return map:addCustomLayer("sprites", 5)
end

-- récupère le spawn
function getPlayerSpawn(map)
    local player
    for k, object in pairs(map.objects) do
        if object.name == OBJECT_PLAYER then
			player = object
			break
		end
    end
    return player
end

-- creer le jouer dans le layer
function createPlayerInLayer(world, layer, player)
	local sprite = love.graphics.newImage(PATH_SHIFU)
	local g = anim8.newGrid(SPRITESIZE, SPRITESIZE, sprite:getWidth(), sprite:getHeight())
	local bulletSprite = love.graphics.newImage(PATH_PEE)

    layer.player = {
		sprite = sprite,
		animations = {
			stop = anim8.newAnimation(g('1-2','1-2'), 0.25),
			move = anim8.newAnimation(g('1-2','3-3'), 0.125)
		},
		x      = player.x,
		y      = player.y,
		width = SPRITESIZE,
		height = SPRITESIZE,
		speed = PLAYER_SPEED,
		bullets = {},
		bulletSprite = bulletSprite,
		-- ox     = sprite:getWidth() / 2,
		-- oy     = sprite:getHeight() / 1.10
	}
	layer.player.animation = layer.player.animations.stop
	world:add(layer.player, layer.player.x, layer.player.y, layer.player.width, layer.player.height)
end

function addControlsToPlayer(world, layer)

	local movePlayer = function(player, goalX, goalY)
		local actualX, actualY, cols, len = world:move(player, goalX, goalY)
		player.x, player.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
		  print('collided with ' .. tostring(cols[i].type))
		end
	end

	local moveBullet = function(bullets, index, bullet, goalX, goalY)
		local actualX, actualY, cols, len = world:move(bullet, goalX, goalY)
		bullet.x, bullet.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
			print('collided with ' .. tostring(cols[i].type))
			if cols[i].type=='slide' then
				world:remove(bullet)
				table.remove(bullets, index)
				break
			end
		end
	end

	currentShootTimer = 0
	layer.update = function(self, dt)
		-- Move player up
		if love.keyboard.isDown("w", "up") then
			movePlayer(self.player, self.player.x, self.player.y - self.player.speed * dt)
		end
		-- Move player down
		if love.keyboard.isDown("s", "down") then
			movePlayer(self.player, self.player.x, self.player.y + self.player.speed * dt)
		end
		-- Move player left
		if love.keyboard.isDown("a", "left") then
			movePlayer(self.player, self.player.x - self.player.speed * dt, self.player.y)
		end
		-- Move player right
		if love.keyboard.isDown("d", "right") then
			movePlayer(self.player, self.player.x + self.player.speed * dt, self.player.y)
		end
		-- animation
		if love.keyboard.isDown("w", "up", "s", "down", "a", "left", "d", "right") then
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
		if love.keyboard.isDown("space") and currentShootTimer > BULLET_TIMER then
			local bullet = {}
			bullet.width = BULLET_WIDTH
			bullet.height = BULLET_HEIGHT
			bullet.x = playerLayer.player.x + playerLayer.player.width / 2
			bullet.y = playerLayer.player.y - bullet.height
			world:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
			table.insert(self.player.bullets, bullet)
			currentShootTimer = 0
		end
		-- move bullet
		for index, bullet in ipairs(self.player.bullets) do
			moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y - BULLET_SPEED * dt)
		end
	end
end

-- on dessine le joueur
function drawPlayer(layer)
	layer.draw = function(self)
		-- player's animation
		self.player.animation:draw(self.player.sprite, math.floor(self.player.x), math.floor(self.player.y))
		-- player's bullets
		for _,bullet in ipairs(self.player.bullets) do
			love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y)
		end
		-- for debugging
		love.graphics.setPointSize(5)
		love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
	end
end

-- on supprime le layer de spawn devenu inutile
function removeUnneededLayer()
    map:removeLayer("player")
end