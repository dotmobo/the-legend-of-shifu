-- libs
require('utils')
Gamestate = require('libs/hump/gamestate')
Bump = require('libs/bump')
Sti = require("libs/sti")
Anim8 = require("libs/anim8")
-- globals
Joystick = nil
Score = nil
Level = nil
World = nil
Map = nil
EnemiesLayer = nil
-- game state
Menu = {}
Game = {}
require('menu')
require('game')


function love.load()
	-- menu
	Gamestate.registerEvents()
    Gamestate.switch(Menu)
	-- load gamepad
	local joysticks = love.joystick.getJoysticks()
	Joystick = joysticks[1]
	-- font
    local font = love.graphics.newFont(GAME_FONT_SIZE)
    love.graphics.setFont(font)
end

