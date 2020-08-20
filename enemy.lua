

function initEnemies(map, world, enemiesLayer)
    local enemies= {}
    local enemy1 = {x = SPRITESIZE*2, y = SPRITESIZE*2}
    local enemy2 = {x = SPRITESIZE*5, y = SPRITESIZE*7}
    -- local enemy3 = {x = SPRITESIZE*2, y = SPRITESIZE*2}
    table.insert(enemies, enemy1)
    table.insert(enemies, enemy2)
    -- table.insert(enemies, enemy3)


   -- for index, enemy in ipairs(enemies) do
    loadEnemies(world, enemiesLayer, enemies)
    updateEnemies(world, enemiesLayer, enemies)
    drawEnemies(enemiesLayer, enemies)

end

-- creer le jouer dans le layer
function loadEnemies(world, layer, enemies)
    enemiesLayer.enemies = {}
    local sprite = love.graphics.newImage(PATH_SKELETON)
    local g = anim8.newGrid(SPRITESIZE, SPRITESIZE, sprite:getWidth(), sprite:getHeight())
    local enemyHitSound = love.audio.newSource(PATH_SKELETON_HIT_SOUND, "static")

    for index, enemy in ipairs(enemies) do
         layer.enemies[index] = {
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
            enemyHitSound = enemyHitSound,
            moves = {
                stop = "stop",
                run = "run",
            },
            life = 3,
            dead = false,
            removed = false
        }
        layer.enemies[index].animations.die.onLoop = function(anim)
            anim:pauseAtEnd()
            layer.enemies[index].dead = true
        end


        layer.enemies[index].animation = layer.enemies[index].animations.stop
        layer.enemies[index].move = layer.enemies[index].moves.stop
        world:add(layer.enemies[index], layer.enemies[index].x, layer.enemies[index].y, layer.enemies[index].width, layer.enemies[index].height)

    end
end

function updateEnemies(world, layer, enemies)
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
        for index, enemy in ipairs(enemies) do
            if not self.enemies[index].removed then
                -- default animation
                self.enemies[index].move = self.enemies[index].moves.run

                -- die motherfucker !
                if self.enemies[index].life <= 0 then
                    self.enemies[index].animation = self.enemies[index].animations.die
                    self.enemies[index].move = self.enemies[index].moves.stop
                end

                -- move enemy
                if (self.enemies[index].move == self.enemies[index].moves.run) then
                    moveEnemy(self.enemies[index], self.enemies[index].x + self.enemies[index].directionX * self.enemies[index].speed * dt, self.enemies[index].y)
                end

                -- On met à jour l'animation du joueur
                self.enemies[index].animation:update(dt)

                -- remove the enemy from bump when he is deadd
                if self.enemies[index].dead then
                    print("dead " .. index)
                    world:remove(self.enemies[index])
                    self.enemies[index].removed = true
                    -- table.remove(enemies, index)
                end
            end
        end
    end
end

function drawEnemies(layer, enemies)
    layer.draw = function(self)
        for index, enemy in ipairs(enemies) do
            if not self.enemies[index].removed then
                -- enemy's animation
                self.enemies[index].animation:draw(self.enemies[index].sprite, math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))

                if ENABLE_DEBUG then
                    love.graphics.setPointSize(5)
                    love.graphics.points(math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))
                end
            end
        end
	end
end