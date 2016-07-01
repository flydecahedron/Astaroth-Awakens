-- load libs

-- load modules
local map = require("src.map")
local tileset = require("src.tileset")
local ui = require("src.ui")
-- load assets
local tilemap = require("assets.maps.H")
local tileset_image = love.graphics.newImage("assets/tileset.png")
-- load shaders
local shader = love.graphics.newShader("src/shaders/selected.frag")
-- initialize map and tileset
local tileW, tileH = 24, 24
map.load(tileset_image, tileW, tileH, tilemap)
local units = {}
local structures = {}

function love.load()

end

function love.keypressed(key)
	-- Exit
	if key == "escape" then
		love.event.quit()
	end
end

function love.update(dt)
	map.update(dt, units, structures)
	ui.update()
end

function love.draw()
	map.tilemap_draw(shader)
	ui.draw()
end
