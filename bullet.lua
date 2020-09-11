function bulletFilter(item, other)
    return "touch"
end

function bulletCollide(cols, len, bullets, index, bullet, otherType)
    -- deal with the collisions
    for i=1,len do
        print('bullet collided with ' .. tostring(cols[i].type))
        if cols[i].type=='touch' then
            if cols[i].other[otherType] then
                print(cols[i].other.life)
                cols[i].other.hitted = true
                cols[i].other.hittedTime = 1
                cols[i].other.life = cols[i].other.life - 1
                cols[i].other.hitSound:setVolume(GAME_EFFECTS_VOLUME)
                cols[i].other.hitSound:play()
            end
            World:remove(bullet)
            table.remove(bullets, index)
            break
        end
    end
end

function moveBullet(bullets, index, bullet, goalX, goalY, otherType)
    local actualX, actualY, cols, len = World:move(bullet, goalX, goalY, bulletFilter)
    bullet.x, bullet.y = actualX, actualY
    bulletCollide(cols, len, bullets, index, bullet, otherType)
end

function createBullet(enemyOrPlayer, move)
    enemyOrPlayer.bulletSound:setVolume(GAME_EFFECTS_VOLUME)
    enemyOrPlayer.bulletSound:play()
    local bullet = {}
    bullet.width = enemyOrPlayer.bulletWidth
    bullet.height = enemyOrPlayer.bulletHeight
    bullet.moves = {
        stop = "stop",
        up = "up",
        down = "down",
        left = "left",
        right = "right"
    }
    if move == "up" then
        bullet.move = bullet.moves.up
        bullet.x = enemyOrPlayer.x + enemyOrPlayer.width / 2
        bullet.y = enemyOrPlayer.y - bullet.height
    elseif move == "down" then
        bullet.move = bullet.moves.down
        bullet.x = enemyOrPlayer.x + enemyOrPlayer.width / 2
        bullet.y = enemyOrPlayer.y + enemyOrPlayer.height
    elseif move == "left" then
        bullet.move = bullet.moves.left
        bullet.x = enemyOrPlayer.x - bullet.width
        bullet.y = enemyOrPlayer.y + enemyOrPlayer.height / 2
    elseif move == "right" then
        bullet.move = bullet.moves.right
        bullet.x = enemyOrPlayer.x + enemyOrPlayer.width
        bullet.y = enemyOrPlayer.y + enemyOrPlayer.height / 2
    end
    World:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
    table.insert(enemyOrPlayer.bullets, bullet)
    return bullet
end