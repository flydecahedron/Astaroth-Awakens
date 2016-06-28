local tileset = {}
function tileset.load()
	Tileset = love.graphics.newImage("assets/tileset.png")
	local tileW, tileH = 24, 24
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	local count = 1
	local tiles = {}
  for j = 1, 10 do
		for i = 1, 16 do
			tiles[count]={}
			tiles[count][1] = love.graphics.newQuad((i-1)*tileW, (j-1)*tileH, tileW, tileH, tilesetW, tilesetH)
			tiles[count][2] = (i-1)*tileW
			tiles[count][3] = (j-1)*tileH
			count = count + 1
		end
	end
  return tiles
end
return tileset
