-- load libs

-- load assets
--local tiles = require "tileset"

-- load shader
function love.load()
	--camera = Camera(0, 0)

	--tileset initialization
	Tileset = love.graphics.newImage("assets/tileset.png")
	tileW, tileH = 24, 24
	tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	local count = 1
	tiles={}
	for j = 1, 10 do
		for i = 1, 16 do
			tiles[count]={}
			tiles[count][1] = love.graphics.newQuad((i-1)*tileW, (j-1)*tileH, tileW, tileH, tilesetW, tilesetH)
			tiles[count][2] = (i-1)*tileW
			tiles[count][3] = (j-1)*tileH
			count = count + 1
		end
	end
	tileTable = {
	{1,2,3,45,23,78,23,54,65,32},
	{4,5,6},
	{7,8,9},
	{1,2,3},
	{4,5,6},
	{7,8,9}
	}

	shader = love.graphics.newShader("shaders/selected.frag")
	shader:send("quadW", tileW)
	shader:send("quadH", tileH)
	shader:send("tilesetW", tilesetW)
	shader:send("tilesetH", tilesetH)
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
	if(time > 0 and time < 1)then
		shader:send("dt",time)
	elseif(time > 1)then
		if(time0 > 0)then
			time0 = time0 - math.min(dt, 1/30)
			shader:send("dt",time0)
		else
		    time = 0
		    time0 = 1
			shader:send("dt",time)
		end
	end
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(time,200,200)
	love.graphics.print(time0,200,250)
	love.graphics.setShader( shader )
	for rowIndex = 1, #tileTable do
		local row = tileTable[rowIndex]
		for columnIndex=1, #row do
			local number = row[columnIndex]
			shader:send("quadX", tiles[number][2])
			shader:send("quadY", tiles[number][3])
			love.graphics.draw(Tileset, tiles[number][1], (columnIndex-1)*tileW, (rowIndex-1)*tileH)
		end
	end
	love.graphics.setShader()
end
