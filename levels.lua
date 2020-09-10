function addEnemies(enemiesNum)
    local enemies = {}
    for i=1, enemiesNum do
        local enemy = {}
        enemy.x = GAME_SPRITE_SIZE*math.random(3, 8)
        enemy.y = GAME_SPRITE_SIZE*math.random(2, 5)
        table.insert(enemies, enemy)
    end
    return enemies
end

function addBoss(enemiesNum)
    local enemies = {}
    for i=1, enemiesNum do
        local enemy = {}
        enemy.x = GAME_SPRITE_SIZE*2 -- center
        enemy.y = GAME_SPRITE_SIZE*2-- center
        table.insert(enemies, enemy)
    end
    return enemies
end

function getLevelEnemies()
    local enemies = {}
    local enemiesNum = 0
    if Level == 1 then
        enemiesNum = 2
        enemies = addEnemies(enemiesNum)
    elseif Level == 2 then
        enemiesNum = 3
        enemies = addEnemies(enemiesNum)
    elseif Level == 3 then
        enemiesNum = 4
        enemies = addEnemies(enemiesNum)
    elseif Level == 4 then
        enemiesNum = 5
        enemies = addEnemies(enemiesNum)
    elseif Level == 5 then
        enemiesNum = 1
        enemies = addBoss(enemiesNum)
    end
    return enemies, enemiesNum
end