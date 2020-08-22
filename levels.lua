function getLevelEnemies()
    local enemies = {}
    local enemiesNum = 0
    if Level == 1 then
        enemiesNum = 2
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'skeleton'
            table.insert(enemies, enemy)
        end
    end
    if Level == 2 then
        enemiesNum = 3
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'skeleton'
            table.insert(enemies, enemy)
        end
    end
    if Level == 3 then
        enemiesNum = 4
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'skeleton'
            table.insert(enemies, enemy)
        end
    end
    if Level == 4 then
        enemiesNum = 5
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'zombie'
            table.insert(enemies, enemy)
        end
    end
    if Level == 5 then
        enemiesNum = 6
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'zombie'
            table.insert(enemies, enemy)
        end
    end
    if Level == 6 then
        enemiesNum = 1
        for i=1, enemiesNum do
            local enemy = {}
            enemy.x = GAME_SPRITE_SIZE*math.random(2, 8)
            enemy.y = i*GAME_SPRITE_SIZE
            enemy.type = 'minette'
            table.insert(enemies, enemy)
        end
    end
    return enemies, enemiesNum
end