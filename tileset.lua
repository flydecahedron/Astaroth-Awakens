local tileset = {}
--default values for the tileset
tileset["image"] = love.graphics.newImage("assets/tileset.png")
tileset["tileW"] = 24
tileset["tileH"] = 24
function tileset.load(image, tileW, tileH)
	Tileset = love.graphics.newImage("assets/tileset.png")
	local tileW, tileH = 24, 24
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	local count = 1
	local tiles = {}
	tiles["tileW"] = tileW
	tiles["tileH"] = tileH
	tiles["tilesetW"] = tilesetW
	tiles["tilesetH"] = tilesetH
  for j = 1, tilesetH/tileH do
		for i = 1, tilesetW/tileW do
			tiles[count]={}
			tiles[count]["quad"] = love.graphics.newQuad((i-1)*tileW, (j-1)*tileH, tileW, tileH, tilesetW, tilesetH)
			tiles[count]["x"] = (i-1)*tileW
			tiles[count]["y"] = (j-1)*tileH
			count = count + 1
		end
	end
  return tiles
end
return tileset
