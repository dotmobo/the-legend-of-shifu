function getRandomEnemy(x, y)
    local randomType
    -- dungeon map with zombies and skeletons
    if MapType == 1 then
        randomType = math.random(1, 2)
    -- desert map with snake and bird
    elseif MapType == 2 then
        randomType = math.random(3, 4)
    -- forest map with tree and chicken
    elseif MapType == 3 then
        randomType = math.random(5, 6)
    -- snow map with snowmap and yeti
    elseif MapType == 4 then
        randomType = math.random(7, 8)
    end
    -- return the right monster
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
    elseif randomType == 7 then
        return getSnowman(x, y)
    elseif randomType == 8 then
        return getYeti(x, y)
    end
end

function getSkeleton(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(SKELETON_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-3'), 0.125)
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
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(SKELETON_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(SKELETON_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = SKELETON_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = SKELETON_BULLET_SPEED
    enemy.bulletWidth = SKELETON_BULLET_WIDTH
    enemy.bulletHeight = SKELETON_BULLET_HEIGHT
    return enemy
end

function getZombie(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(ZOMBIE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-3'), 0.125)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = ZOMBIE_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(ZOMBIE_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = ZOMBIE_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(ZOMBIE_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(ZOMBIE_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = ZOMBIE_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = ZOMBIE_BULLET_SPEED
    enemy.bulletWidth = ZOMBIE_BULLET_WIDTH
    enemy.bulletHeight = ZOMBIE_BULLET_HEIGHT
    return enemy
end

function getSnake(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(SNAKE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SNAKE_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SNAKE_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SNAKE_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(SNAKE_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(SNAKE_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = SNAKE_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = SNAKE_BULLET_SPEED
    enemy.bulletWidth = SNAKE_BULLET_WIDTH
    enemy.bulletHeight = SNAKE_BULLET_HEIGHT
    return enemy
end

function getBird(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(BIRD_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = BIRD_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(BIRD_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = BIRD_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(BIRD_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(BIRD_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = BIRD_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = BIRD_BULLET_SPEED
    enemy.bulletWidth = BIRD_BULLET_WIDTH
    enemy.bulletHeight = BIRD_BULLET_HEIGHT
    return enemy
end

function getTree(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(TREE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = TREE_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(TREE_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = TREE_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(TREE_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(TREE_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = TREE_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = TREE_BULLET_SPEED
    enemy.bulletWidth = TREE_BULLET_WIDTH
    enemy.bulletHeight = TREE_BULLET_HEIGHT
    return enemy
end

function getChicken(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(CHICKEN_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = CHICKEN_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(CHICKEN_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = CHICKEN_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(CHICKEN_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(CHICKEN_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = CHICKEN_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = CHICKEN_BULLET_SPEED
    enemy.bulletWidth = CHICKEN_BULLET_WIDTH
    enemy.bulletHeight = CHICKEN_BULLET_HEIGHT
    return enemy
end

function getSnowman(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(SNOWMAN_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = SNOWMAN_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(SNOWMAN_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = SNOWMAN_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(SNOWMAN_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(SNOWMAN_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = SNOWMAN_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = SNOWMAN_BULLET_SPEED
    enemy.bulletWidth = SNOWMAN_BULLET_WIDTH
    enemy.bulletHeight = SNOWMAN_BULLET_HEIGHT
    return enemy
end

function getYeti(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(YETI_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = YETI_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(YETI_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = YETI_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(YETI_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(YETI_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = YETI_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = YETI_BULLET_SPEED
    enemy.bulletWidth = YETI_BULLET_WIDTH
    enemy.bulletHeight = YETI_BULLET_HEIGHT
    return enemy
end