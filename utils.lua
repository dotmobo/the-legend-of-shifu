-- some utils here
function getScaleTransformations(map)
    local tx =  ((WIN_WIDTH - (map.width * map.tilewidth * SCALE)) / (SCALE*2));
    local ty =  ((WIN_HEIGHT - (map.height * map.tileheight * SCALE)) / (SCALE*2));
    return tx, ty
end