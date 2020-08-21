require('const')

function love.conf(t)
    t.window.title = GAME_TITLE -- Change le titre de la fenêtre
    t.window.icon = GAME_ICON_PATH -- Change l'icone de la fenêtre
    t.window.width = WIN_WIDTH -- Change la largeur de la fenêtre
    t.window.height = WIN_HEIGHT -- Change la hauteur de la fenêtre
    t.console = DEBUG_ENABLE
end