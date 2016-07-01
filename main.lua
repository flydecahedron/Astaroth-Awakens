-- load libs

-- load assets
-- initialize tileset
local map = require("src.map")
local tilemap = require("assets.maps.H")
local tileset = require("src.tileset")
local tileset_image = love.graphics.newImage("assets/tileset.png")
local tileW, tileH = 24, 24
--initialize map and tileset
map.load(tileset_image, tileW, tileH, tilemap)
local tiles = {}
local shader = love.graphics.newShader("src/shaders/selected.frag")
local units = {}
local structures = {}
function love.load()

	--initialize shader
end

function love.keypressed(key)
	-- Exit
	if key == "escape" then
		love.event.quit()
	end
end

function love.update(dt)
	map.update(dt, units, structures)
end

function love.draw()
	map.tilemap_draw(shader)
end
