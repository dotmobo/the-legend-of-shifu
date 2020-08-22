require('levels')

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

-- creer le jouer dans le layer
function loadEnemies(layer, enemies)
    layer.enemies = {}
    local randomType = math.random(1,6)
    local sprite
    local animStopX = '1-2'
    local animStopY = '1-1'
    local animDieX = '1-2'
    local animDieY = '2-2'
    if randomType == 1 then
        sprite = love.graphics.newImage(SKELETON_SPRITE_PATH)
        animDieY = '2-3'
    elseif randomType == 2 then
        sprite = love.graphics.newImage(ZOMBIE_SPRITE_PATH)
        animDieY = '2-3'
    elseif randomType == 3 then
        sprite = love.graphics.newImage(SNAKE_SPRITE_PATH)
    elseif randomType == 4 then
        sprite = love.graphics.newImage(BIRD_SPRITE_PATH)
    elseif randomType == 5 then
        sprite = love.graphics.newImage(TREE_SPRITE_PATH)
    elseif randomType == 6 then
        sprite = love.graphics.newImage(CHICKEN_SPRITE_PATH)
    end
    local g = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, sprite:getWidth(), sprite:getHeight())
    local hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")

    for index, enemy in ipairs(enemies) do
         layer.enemies[index] = {
            sprite = sprite,
            animations = {
                stop = Anim8.newAnimation(g(animStopX,animStopY), 0.5),
                die = Anim8.newAnimation(g(animDieX,animDieY), 0.25),
            },
            x      = enemy.x,
            y      = enemy.y,
            width = GAME_SPRITE_SIZE,
            height = GAME_SPRITE_SIZE,
            speed = SKELETON_SPEED,
            directionX = 1,
            hitSound = hitSound,
            hitted = false,
            hittedTime = 0,
            moves = {
                stop = "stop",
                run = "run",
            },
            life = SKELETON_LIFE,
            dead = false,
            removed = false
        }
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
		if other.life then
			return "touch"
		else
			return "slide"
		end
    end

    local moveEnemy = function(enemy, goalX, goalY)
		local actualX, actualY, cols, len = World:move(enemy, goalX, goalY, enemyFilter)
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
                    Level = Level + 1
                    initEnemies(layer)
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