function getRandomEnemy(x, y)
    local randomType = math.random(1,6)
    if randomType == 1 then
        return getSkeleton(x, y)
    elseif randomType == 2 then
        return getZombie(x, y)
    elseif randomType == 3 then
        return getSnake(x, y)
    elseif randomType == 4 then
        return getBird(x, y)
    elseif randomType == 5 then
        return getTree(x, y)
    elseif randomType == 6 then
        return getChicken(x, y)
    end
end

function getSkeleton(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(SKELETON_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-3'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end

function getZombie(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(ZOMBIE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-3'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end

function getSnake(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(SNAKE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end

function getBird(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(BIRD_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end

function getTree(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(TREE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end

function getChicken(x, y)
    local enemy = {}
    enemy.sprite = love.graphics.newImage(CHICKEN_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SKELETON_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SKELETON_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SKELETON_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    return enemy
end