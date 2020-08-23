require('levels')
require('enemyTypes')

local enemiesAliveNumber

function initEnemies(layer)
    local enemies, enemiesNum = getLevelEnemies()
    -- local maxEnemies = 7
    -- local enemiesNum = math.floor(math.random(Level, GAME_DIFFICULTY*Level % maxEnemies))
    print("Number of enemies: "..enemiesNum)
    -- for i=1, enemiesNum do
    --    local enemy = {}
    --    enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
    --    enemy.y = i*GAME_SPRITE_SIZE
    --    table.insert(enemies, enemy)
    -- end

    enemiesAliveNumber = enemiesNum
    loadEnemies(layer, enemies)
    updateEnemies(layer, enemies)
    drawEnemies(layer, enemies)

end

-- creer les enemies dans le layer
function loadEnemies(layer, enemies)
    -- load enemies
    layer.enemies = {}
    for index, enemy in ipairs(enemies) do
        layer.enemies[index] = getRandomEnemy(enemy.x, enemy.y)
        layer.enemies[index].animations.die.onLoop = function(anim)
            anim:pauseAtEnd()
            layer.enemies[index].dead = true
        end
        layer.enemies[index].animation = layer.enemies[index].animations.stop
        layer.enemies[index].move = layer.enemies[index].moves.stop
        World:add(layer.enemies[index], layer.enemies[index].x, layer.enemies[index].y, layer.enemies[index].width, layer.enemies[index].height)

    end
end

function updateEnemies(layer, enemies)
    local enemyFilter = function(item, other)
		if other.isPlayer then
			return "touch"
		else
			return "slide"
		end
    end

    local enemyCollide = function(cols, len)
        -- deal with the collisions
		for i=1,len do
            print('enemy collided with ' .. tostring(cols[i].type))
            if cols[i].type == 'slide' or cols[i].type == 'touch' then
                cols[i].item.directionX = cols[i].item.directionX * -1
            end
            if cols[i].type == 'touch'then
                cols[i].other.hitted = true
				cols[i].other.hittedTime = 1
                cols[i].other.life = cols[i].other.life - 1
                cols[i].other.hitSound:play()
            end
		end
    end

    local moveEnemy = function(enemy, goalX, goalY)
		local actualX, actualY, cols, len = World:move(enemy, goalX, goalY, enemyFilter)
		enemy.x, enemy.y = actualX, actualY
		enemyCollide(cols, len)
    end

    layer.update = function(self, dt)
        for index, enemy in ipairs(enemies) do
            if self.enemies[index] and not self.enemies[index].removed then
                -- default animation
                self.enemies[index].move = self.enemies[index].moves.run

                if self.enemies[index].hitted and self.enemies[index].hittedTime > 0 then
                    self.enemies[index].hittedTime = self.enemies[index].hittedTime - GAME_HITTED_SPEED*dt
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
                    Score = Score + 1
                    World:remove(self.enemies[index])
                    self.enemies[index].removed = true
                    -- some bugs if i realy remove enemy, maybe clear it when level change
                    -- table.remove(self.enemies, index)
                    enemiesAliveNumber = enemiesAliveNumber - 1
                end

                -- if not enemies, read enemies
                if enemiesAliveNumber ==0 then
                    if Level == 5 then
                        Gamestate.switch(Win)
                    else
                        Level = Level + 1
                        initEnemies(layer)
                    end
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

                if DEBUG_ENABLE then
                    love.graphics.setPointSize(5)
                    love.graphics.points(math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))
                end
            end
        end
	end
end