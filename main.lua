-- load libs

-- load assets
-- initialize tileset
local tileset = require("src.tileset")
local image = love.graphics.newImage("assets/tileset.png")
local tileW, tileH = 24, 24
local tiles = {}
tiles = tileset.load(image, tileW, tileH)
-- load shader
function love.load()
	--camera = Camera(0, 0)

	--tileset initialization


	tileTable = {
	{1,2,3,45,23,78,23,54,65,32},
	{4,5,6},
	{7,8,9},
	{1,2,3},
	{4,5,6},
	{7,8,9}
	}

	shader = love.graphics.newShader("src/shaders/selected.frag")
	shader:send("quadW", tiles.tileW)
	shader:send("quadH", tiles.tileH)
	shader:send("tilesetW", tiles.tilesetW)
	shader:send("tilesetH", tiles.tilesetH)
	time = 0
	time0 = 1
	offset = 0.2
	shader:send("dt",time)
end

function love.keypressed(key)
	-- Exit
	if key == "escape" then
		love.event.quit()
	end
end

function love.update(dt)
time = time + math.min(dt, 1/30)
shader:send("dt",time)
end

function love.draw()
	love.graphics.setShader( shader )
	for rowIndex = 1, #tileTable do
		local row = tileTable[rowIndex]
		for columnIndex = 1, #row do
			local number = row[columnIndex]
			shader:send("quadX", tiles[number].x)
			shader:send("quadY", tiles[number].y)
			love.graphics.draw(tileset.image, tiles[number].quad, (columnIndex-1)*tiles.tileW, (rowIndex-1)*tiles.tileH)
		end
	end
	love.graphics.setShader()
end
