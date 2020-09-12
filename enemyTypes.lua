function getRandomEnemy(x, y)
    local randomType
    -- dungeon map with zombies and skeletons
    if MapType == 1 and Level ~= 5 then
        randomType = math.random(1, 2)
    -- boss
    elseif MapType == 1 and Level == 5 then
        randomType = 10
    -- desert map with snake and bird
    elseif MapType == 2 and Level ~= 5 then
        randomType = math.random(3, 4)
    -- boss
    elseif MapType == 2 and Level == 5 then
        randomType = 11
    -- forest map with tree and chicken
    elseif MapType == 3 and Level ~= 5 then
        randomType = math.random(5, 6)
    -- boss
    elseif MapType == 3 and Level == 5 then
        randomType = 13
    -- snow map with snowmap and yeti
    elseif MapType == 4 and Level ~= 5 then
        randomType = math.random(7, 8)
    -- boss
    elseif MapType == 4 and Level == 5 then
        randomType = 12
    -- volcano map
    elseif MapType == 5 and Level ~= 5 then
        randomType = math.random(14, 15)
    -- boss
    elseif MapType == 5 and Level == 5 then
        randomType = 9
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
    elseif randomType == 9 then
        return getEvilChoco(x, y)
    elseif randomType == 10 then
        return getEvilMinette(x, y)
    elseif randomType == 11 then
        return getEvilBane(x, y)
    elseif randomType == 12 then
        return getEvilCobinou(x, y)
    elseif randomType == 13 then
        return getEvilStella(x, y)
    elseif randomType == 14 then
        return getPhoenix(x, y)
    elseif randomType == 15 then
        return getTrex(x, y)
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

function getPhoenix(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(PHOENIX_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = PHOENIX_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(PHOENIX_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = PHOENIX_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(PHOENIX_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(PHOENIX_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = PHOENIX_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = PHOENIX_BULLET_SPEED
    enemy.bulletWidth = PHOENIX_BULLET_WIDTH
    enemy.bulletHeight = PHOENIX_BULLET_HEIGHT
    return enemy
end

function getTrex(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.sprite = love.graphics.newImage(TREX_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-1'), 0.5),
        die = Anim8.newAnimation(enemy.grid('1-2','2-2'), 0.25)
    }
    enemy.width = GAME_SPRITE_SIZE
    enemy.height = GAME_SPRITE_SIZE
    enemy.speed = TREX_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(TREX_HIT_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = TREX_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(TREX_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(TREX_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = TREX_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = TREX_BULLET_SPEED
    enemy.bulletWidth = TREX_BULLET_WIDTH
    enemy.bulletHeight = TREX_BULLET_HEIGHT
    return enemy
end

function getEvilChoco(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.isBoss = true
    enemy.sprite = love.graphics.newImage(EVILCHOCO_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_BOSS_SPRITE_SIZE, GAME_BOSS_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-2'), 0.25),
        die = Anim8.newAnimation(enemy.grid('1-2','3-3'), 0.75)
    }
    enemy.width = GAME_BOSS_SPRITE_SIZE
    enemy.height = GAME_BOSS_SPRITE_SIZE
    enemy.speed = EVILCHOCO_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(EVILCHOCO_HIT_SOUND_PATH, "static")
    enemy.spawnSound = love.audio.newSource(EVILCHOCO_SPAWN_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = EVILCHOCO_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(EVILCHOCO_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(EVILCHOCO_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = EVILCHOCO_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = EVILCHOCO_BULLET_SPEED
    enemy.bulletWidth = EVILCHOCO_BULLET_WIDTH
    enemy.bulletHeight = EVILCHOCO_BULLET_HEIGHT
    return enemy
end

function getEvilMinette(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.isBoss = true
    enemy.sprite = love.graphics.newImage(EVILMINETTE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_BOSS_SPRITE_SIZE, GAME_BOSS_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-2'), 0.25),
        die = Anim8.newAnimation(enemy.grid('1-2','3-3'), 0.75)
    }
    enemy.width = GAME_BOSS_SPRITE_SIZE
    enemy.height = GAME_BOSS_SPRITE_SIZE
    enemy.speed = EVILMINETTE_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(EVILMINETTE_HIT_SOUND_PATH, "static")
    enemy.spawnSound = love.audio.newSource(EVILMINETTE_SPAWN_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = EVILMINETTE_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(EVILMINETTE_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(EVILMINETTE_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = EVILMINETTE_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = EVILMINETTE_BULLET_SPEED
    enemy.bulletWidth = EVILMINETTE_BULLET_WIDTH
    enemy.bulletHeight = EVILMINETTE_BULLET_HEIGHT
    return enemy
end

function getEvilBane(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.isBoss = true
    enemy.sprite = love.graphics.newImage(EVILBANE_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_BOSS_SPRITE_SIZE, GAME_BOSS_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-2'), 0.25),
        die = Anim8.newAnimation(enemy.grid('1-2','3-3'), 0.75)
    }
    enemy.width = GAME_BOSS_SPRITE_SIZE
    enemy.height = GAME_BOSS_SPRITE_SIZE
    enemy.speed = EVILBANE_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(EVILBANE_HIT_SOUND_PATH, "static")
    enemy.spawnSound = love.audio.newSource(EVILBANE_SPAWN_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = EVILBANE_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(EVILBANE_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(EVILBANE_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = EVILBANE_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = EVILBANE_BULLET_SPEED
    enemy.bulletWidth = EVILBANE_BULLET_WIDTH
    enemy.bulletHeight = EVILBANE_BULLET_HEIGHT
    return enemy
end

function getEvilCobinou(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.isBoss = true
    enemy.sprite = love.graphics.newImage(EVILCOBINOU_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_BOSS_SPRITE_SIZE, GAME_BOSS_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-2'), 0.25),
        die = Anim8.newAnimation(enemy.grid('1-2','3-3'), 0.75)
    }
    enemy.width = GAME_BOSS_SPRITE_SIZE
    enemy.height = GAME_BOSS_SPRITE_SIZE
    enemy.speed = EVILCOBINOU_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(EVILCOBINOU_HIT_SOUND_PATH, "static")
    enemy.spawnSound = love.audio.newSource(EVILCOBINOU_SPAWN_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = EVILCOBINOU_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(EVILCOBINOU_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(EVILCOBINOU_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = EVILCOBINOU_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = EVILCOBINOU_BULLET_SPEED
    enemy.bulletWidth = EVILCOBINOU_BULLET_WIDTH
    enemy.bulletHeight = EVILCOBINOU_BULLET_HEIGHT
    return enemy
end

function getEvilStella(x, y)
    local enemy = {}
    enemy.isEnemy = true
    enemy.isBoss = true
    enemy.sprite = love.graphics.newImage(EVILSTELLA_SPRITE_PATH)
    enemy.grid = Anim8.newGrid(GAME_BOSS_SPRITE_SIZE, GAME_BOSS_SPRITE_SIZE, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.animations = {
        stop = Anim8.newAnimation(enemy.grid('1-2','1-2'), 0.25),
        die = Anim8.newAnimation(enemy.grid('1-2','3-3'), 0.75)
    }
    enemy.width = GAME_BOSS_SPRITE_SIZE
    enemy.height = GAME_BOSS_SPRITE_SIZE
    enemy.speed = EVILSTELLA_SPEED
    enemy.directionX = 1
    enemy.hitSound = love.audio.newSource(EVILSTELLA_HIT_SOUND_PATH, "static")
    enemy.spawnSound = love.audio.newSource(EVILSTELLA_SPAWN_SOUND_PATH, "static")
    enemy.hitted = false
    enemy.hittedTime = 0
    enemy.moves = {
        stop = "stop",
        run = "run",
    }
    enemy.life = EVILSTELLA_LIFE
    enemy.dead = false
    enemy.removed = false
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
	enemy.bulletSprite = love.graphics.newImage(EVILSTELLA_BULLET_PATH)
    enemy.bulletSound = love.audio.newSource(EVILSTELLA_BULLET_SOUND_PATH, "static")
    enemy.bulletShootTimer = EVILSTELLA_BULLET_TIMER
    enemy.bulletCurrentShootTimer = 0
    enemy.bulletSpeed = EVILSTELLA_BULLET_SPEED
    enemy.bulletWidth = EVILSTELLA_BULLET_WIDTH
    enemy.bulletHeight = EVILSTELLA_BULLET_HEIGHT
    return enemy
end