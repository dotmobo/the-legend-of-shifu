-- some utils here
function getScaleTransformations(map)
    local tx =  ((WIN_WIDTH - (map.width * map.tilewidth * GAME_SCALE)) / (GAME_SCALE*2));
    local ty =  ((WIN_HEIGHT - (map.height * map.tileheight * GAME_SCALE)) / (GAME_SCALE*2));
    return tx, ty
end
