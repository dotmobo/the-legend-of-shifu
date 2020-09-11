require('levels')
require('enemyTypes')

local enemiesAliveNumber

function initEnemies(layer, playerLayer)
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
    updateEnemies(layer, enemies, playerLayer)
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
        if layer.enemies[index].isBoss == true then
            layer.enemies[index].spawnSound:setVolume(GAME_EFFECTS_VOLUME)
            layer.enemies[index].spawnSound:play()
        end
    end
end

function updateEnemies(layer, enemies, playerLayer)
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
                cols[i].other.hitSound:setVolume(GAME_EFFECTS_VOLUME)
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
                    for bulletIndex, bullet in ipairs(self.enemies[index].bullets) do
                        World:remove(bullet)
                        table.remove(self.enemies[index].bullets, bulletIndex)
                    end
                    World:remove(self.enemies[index])
                    self.enemies[index].removed = true
                    -- some bugs if i realy remove enemy, maybe clear it when level change
                    -- table.remove(self.enemies, index)
                    enemiesAliveNumber = enemiesAliveNumber - 1
                end

                -- if enemy with bullets
                if self.enemies[index]['bullets'] ~= nil then
                    self.enemies[index].bulletCurrentShootTimer = self.enemies[index].bulletCurrentShootTimer + dt
                    if self.enemies[index].bulletCurrentShootTimer > self.enemies[index].bulletShootTimer then
                        if self.enemies[index].isBoss == true then
                            createBullet(self.enemies[index], "up")
                            createBullet(self.enemies[index], "down")
                            createBullet(self.enemies[index], "left")
                            createBullet(self.enemies[index], "right")
                        else
                            if playerLayer.player.y <  self.enemies[index].y then
                                local bullet = createBullet(self.enemies[index], "up")
                            else
                                local bullet = createBullet(self.enemies[index], "down")
                            end
                        end
                        self.enemies[index].bulletCurrentShootTimer = 0
                    end
                    -- move bullet
                    for bulletIndex, bullet in ipairs(self.enemies[index].bullets) do
                        if bullet.move == bullet.moves.down then
                            moveBullet(self.enemies[index].bullets, bulletIndex, bullet, bullet.x, bullet.y + self.enemies[index].bulletSpeed * dt, 'isPlayer')
                        elseif bullet.move == bullet.moves.left then
                            moveBullet(self.enemies[index].bullets, bulletIndex, bullet, bullet.x - self.enemies[index].bulletSpeed * dt, bullet.y, 'isPlayer')
                        elseif bullet.move == bullet.moves.right then
                            moveBullet(self.enemies[index].bullets, bulletIndex, bullet, bullet.x + self.enemies[index].bulletSpeed * dt, bullet.y, 'isPlayer')
                        else
                            moveBullet(self.enemies[index].bullets, bulletIndex, bullet, bullet.x, bullet.y - self.enemies[index].bulletSpeed * dt, 'isPlayer')
                        end
                    end
                end

                -- kill enemy if he is outside the map (spawn bug)
                if self.enemies[index].x <= 0 or self.enemies[index].x >= MAP_WIDTH or self.enemies[index].y <= 0 or self.enemies[index].y >= MAP_HEIGHT then
                    self.enemies[index].life = 0
                end

                -- if not enemies, read enemies
                if enemiesAliveNumber ==0 then
                    if Level == 5 and WorldType == 1 then
                        WorldType = 2
                        Level = 1
                        Gamestate.switch(Transition)
                    elseif Level == 5 and WorldType == 2 then
                        WorldType = 3
                        Level = 1
                        Gamestate.switch(Transition)
                    elseif Level == 5 and WorldType == 3 then
                        WorldType = 4
                        Level = 1
                        Gamestate.switch(Transition)
                    elseif Level == 5 and WorldType == 4 then
                        Gamestate.switch(Win)
                    else
                        Level = Level + 1
                        Gamestate.switch(Transition)
                        -- playerLayer.player.gotToSpawn()
                        -- initEnemies(layer, playerLayer)
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


                -- enemies bullets
                if self.enemies[index]['bullets'] ~= nil then
                    for _,bullet in ipairs(self.enemies[index].bullets) do
                        if bullet.move == bullet.moves.left or bullet.move == bullet.moves.right then
                            love.graphics.draw(self.enemies[index].bulletSprite, bullet.x,bullet.y, math.rad(90))
                        else
                            love.graphics.draw(self.enemies[index].bulletSprite, bullet.x,bullet.y)
                        end
                    end
                end

                if DEBUG_ENABLE then
                    love.graphics.setPointSize(5)
                    love.graphics.points(math.floor(self.enemies[index].x), math.floor(self.enemies[index].y))
                end
            end
        end
	end
end