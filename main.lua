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
MapType = nil
WorldType = nil
-- game state
Menu = {}
Game = {}
Lose = {}
Win = {}
Transition = {}
require('menu')
require('game')
require('lose')
require('win')
require('transition')

function love.load()
	-- random seed
	math.randomseed(os.time())
	-- music
	Music = love.audio.newSource(GAME_MUSIC_PATH, "static")
	Music:setVolume(GAME_MUSIC_VOLUME)
	Music:setLooping(true)
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

