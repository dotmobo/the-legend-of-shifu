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