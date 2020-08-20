function initEnemies(map, world, enemiesLayer)
    local enemy = {}
    enemy.x = SPRITESIZE*2
    enemy.y = SPRITESIZE*2
    loadEnemy(world, enemiesLayer, enemy)
    updateEnemy(world, enemiesLayer)
    drawEnemy(enemiesLayer)
end

-- creer le jouer dans le layer
function loadEnemy(world, layer, enemy)
	local sprite = love.graphics.newImage(PATH_SKELETON)
	local g = anim8.newGrid(SPRITESIZE, SPRITESIZE, sprite:getWidth(), sprite:getHeight())

    layer.enemy = {
		sprite = sprite,
		animations = {
            stop = anim8.newAnimation(g('1-2','1-1'), 0.5),
            die = anim8.newAnimation(g('1-2','2-3'), 0.25),
		},
		x      = enemy.x,
		y      = enemy.y,
		width = SPRITESIZE,
        height = SPRITESIZE,
        speed = 50,
        directionX = 1,
        moves = {
			stop = "stop",
		}

	}
    layer.enemy.animation = layer.enemy.animations.stop
    layer.enemy.move = layer.enemy.moves.stop
	world:add(layer.enemy, layer.enemy.x, layer.enemy.y, layer.enemy.width, layer.enemy.height)
end

function updateEnemy(world, layer)
    local moveEnemy = function(enemy, goalX, goalY)
		local actualX, actualY, cols, len = world:move(enemy, goalX, goalY)
		enemy.x, enemy.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
          print('enemy collided with ' .. tostring(cols[i].type))
          if cols[i].type == 'slide' then
            enemy.directionX = enemy.directionX * -1
            end
		end
    end

    layer.update = function(self, dt)
        -- default animation
        layer.enemy.move = layer.enemy.moves.stop
        -- move enemy
        moveEnemy(self.enemy, self.enemy.x + self.enemy.directionX * self.enemy.speed * dt, self.enemy.y)


        -- On met à jour l'animation du joueur
		self.enemy.animation:update(dt)
    end
end

function drawEnemy(layer)
	layer.draw = function(self)
		-- enemy's animation
		self.enemy.animation:draw(self.enemy.sprite, math.floor(self.enemy.x), math.floor(self.enemy.y))

		if ENABLE_DEBUG then
			love.graphics.setPointSize(5)
			love.graphics.points(math.floor(self.enemy.x), math.floor(self.enemy.y))
		end
	end
end