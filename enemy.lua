

function initEnemies(map, world, enemiesLayer)
    local enemies= {}
    -- local enemy1 = {x = SPRITESIZE*2, y = SPRITESIZE*2}
    -- local enemy2 = {x = SPRITESIZE*5, y = SPRITESIZE*7}
    -- table.insert(enemies, enemy1)
    -- table.insert(enemies, enemy2)

    local enemiesNum = math.floor(math.random(1, 3*DIFFICULTY))
    print("Number of enemies: "..enemiesNum)
    for i=1, enemiesNum do
        local enemy = {}
        enemy.x = SPRITESIZE*math.random(2, 8)
        enemy.y = i*SPRITESIZE
        table.insert(enemies, enemy)
    end

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
    local hitSound = love.audio.newSource(PATH_SKELETON_HIT_SOUND, "static")

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
            hitSound = hitSound,
            hitted = false,
            hittedTime = 0,
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
    local enemyFilter = function(item, other)
		if other.life then
			return "touch"
		else
			return "slide"
		end
    end

    local moveEnemy = function(enemy, goalX, goalY)
		local actualX, actualY, cols, len = world:move(enemy, goalX, goalY, enemyFilter)
		enemy.x, enemy.y = actualX, actualY
		-- deal with the collisions
		for i=1,len do
            print('enemy collided with ' .. tostring(cols[i].type))
            if cols[i].type == 'slide' or cols[i].type == 'touch' then
                enemy.directionX = enemy.directionX * -1
            end
            if cols[i].type == 'touch'then
                cols[i].other.hitted = true
				cols[i].other.hittedTime = 1
                cols[i].other.life = cols[i].other.life - 1
                cols[i].other.hitSound:play()
            end
		end
    end

    layer.update = function(self, dt)
        for index, enemy in ipairs(enemies) do
            if self.enemies[index] and not self.enemies[index].removed then
                -- default animation
                self.enemies[index].move = self.enemies[index].moves.run

                if self.enemies[index].hitted and self.enemies[index].hittedTime > 0 then
                    self.enemies[index].hittedTime = self.enemies[index].hittedTime - HITTED_SPEED*dt
                    if self.enemies[index].hittedTime <= 0 then
                        self.enemies[index].hitted = false
                    end
                end

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
                    score = score + 1
                    world:remove(self.enemies[index])
                    self.enemies[index].removed = true
                    -- some bugs if i realy remove enemy, maybe clear it when level change
                    -- table.remove(self.enemies, index)
                end
            end
        end
    end
end

function drawEnemies(layer, enemies)
    layer.draw = function(self)
        for index, enemy in ipairs(enemies) do
            if self.enemies[index] and not self.enemies[index].removed then

                if self.enemies[index].hitted then
                    love.graphics.setColor(208, 0, 0, 1)
                else
                    love.graphics.setColor(255, 255, 255, 1)
                end
                self.enemies[index].animation:draw(self.enemies[index].sprite, math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))

                if ENABLE_DEBUG then
                    love.graphics.setPointSize(5)
                    love.graphics.points(math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))
                end
            end
        end
	end
end