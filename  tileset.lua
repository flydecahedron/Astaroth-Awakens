function love.load()
	Tileset = love.graphics.newImage("assets/tileset.png")
	local tileW, tileH = 24, 24
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	tiles{}
	for j = 1, 10 do		
		for i = 1, 16 do
			tiles[i][j] = love.graphics.newQuad((i-1)*tileW, (j-1)*tileH, tileW, tileH, tilesetW, tilesetH)
		end
	end
end