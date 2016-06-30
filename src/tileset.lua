local tileset = {}
--default values for the tileset
function tileset.load(image, tileW, tileH)
	local tilesetW, tilesetH = image:getWidth(), image:getHeight()
	local count = 1
	tileset.image = image
	tileset.tileW = tileW
	tileset.tileH = tileH
	local tiles = {}
	tiles.image = image
	tiles.tileW = tileW
	tiles.tileH = tileH
	tiles.tilesetW = tilesetW
	tiles.tilesetH = tilesetH
	-- tiles are organized by row then column
	-- for example, tiles[12] for a 10 x 10 tileset would be the second tile on the second row
  for j = 1, tilesetH/tileH do
		for i = 1, tilesetW/tileW do
			tiles[count]={}
			tiles[count].quad = love.graphics.newQuad((i-1)*tileW, (j-1)*tileH, tileW, tileH, tilesetW, tilesetH)
			tiles[count].x = (i-1)*tileW
			tiles[count].y = (j-1)*tileH
			count = count + 1
		end
	end
  return tiles
end
return tileset
