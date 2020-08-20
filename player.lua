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
	layer.player.animation = layer.player.animations.stop
	layer.player.move = layer.player.moves.stop
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
		if love.keyboard.isDown("up") then
			layer.player.move = layer.player.moves.up
			movePlayer(self.player, self.player.x, self.player.y - self.player.speed * dt)
		end
		-- Move player down
		if love.keyboard.isDown("down") then
			layer.player.move = layer.player.moves.down
			movePlayer(self.player, self.player.x, self.player.y + self.player.speed * dt)
		end
		-- Move player left
		if love.keyboard.isDown("left") then
			layer.player.move = layer.player.moves.left
			movePlayer(self.player, self.player.x - self.player.speed * dt, self.player.y)
		end
		-- Move player right
		if love.keyboard.isDown("right") then
			layer.player.move = layer.player.moves.right
			movePlayer(self.player, self.player.x + self.player.speed * dt, self.player.y)
		end
		if not love.keyboard.isDown("up", "down", "left", "right") then
			layer.player.move = layer.player.moves.stop
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
		if love.keyboard.isDown("z", "w", "a", "q", "s", "d") and currentShootTimer > BULLET_TIMER then
			local bullet = {}
			bullet.width = BULLET_WIDTH
			bullet.height = BULLET_HEIGHT
			bullet.moves = {
				stop = "stop",
				up = "up",
				down = "down",
				left = "left",
				right = "right"
			}

			if love.keyboard.isDown("z", "w") then
				bullet.move = bullet.moves.up
				bullet.x = playerLayer.player.x + playerLayer.player.width / 2
				bullet.y = playerLayer.player.y - bullet.height
			elseif love.keyboard.isDown("s") then
				bullet.move = bullet.moves.down
				bullet.x = playerLayer.player.x + playerLayer.player.width / 2
				bullet.y = playerLayer.player.y + playerLayer.player.height
			elseif love.keyboard.isDown("a", "q") then
				bullet.move = bullet.moves.left
				bullet.x = playerLayer.player.x - bullet.width
				bullet.y = playerLayer.player.y + playerLayer.player.height / 2
			elseif love.keyboard.isDown("d") then
				bullet.move = bullet.moves.right
				bullet.x = playerLayer.player.x + playerLayer.player.width
				bullet.y = playerLayer.player.y + playerLayer.player.height / 2
			end

			world:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
			table.insert(self.player.bullets, bullet)
			currentShootTimer = 0
		end
		-- move bullet
		for index, bullet in ipairs(self.player.bullets) do
			if bullet.move == bullet.moves.down then
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y + BULLET_SPEED * dt)
			elseif bullet.move == bullet.moves.left then
				moveBullet(self.player.bullets, index, bullet, bullet.x - BULLET_SPEED * dt, bullet.y)
			elseif bullet.move == bullet.moves.right then
				moveBullet(self.player.bullets, index, bullet, bullet.x + BULLET_SPEED * dt, bullet.y)
			else
				moveBullet(self.player.bullets, index, bullet, bullet.x, bullet.y - BULLET_SPEED * dt)
			end
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
			if bullet.move == bullet.moves.left or bullet.move == bullet.moves.right then
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y, math.rad(90))
			else
				love.graphics.draw(self.player.bulletSprite, bullet.x,bullet.y)
			end
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