local map = {}
map.tileset = require("src.tileset")
map.tiles =  {}
map.tilemap = {}
map.units = {}
map.structures = {}
map.time = 0

function map.load(tileset_image, tileW, tileH, tilemap, units, structures)
  map.tiles = map.tileset.load(tileset_image, tileW, tileH)
  map.tilemap = tilemap
end

function map.get_tile(x,y)

end

function map.update(dt, units, structures)
  map.time = map.time + math.min(dt,1/30)
  map.units = units
  map.structures = structures
end

function map.tilemap_draw(shader)
  shader:send("quadW", map.tiles.tileW)
  shader:send("quadH", map.tiles.tileH)
  shader:send("tilesetW", map.tiles.tilesetW)
  shader:send("tilesetH", map.tiles.tilesetH)
  shader:send("dt",map.time)
  love.graphics.setShader( shader )
  local index = 1
	for row = 1, map.tilemap.width do
		for column = 1, map.tilemap.height do
			shader:send("quadX", map.tiles[index].x)
			shader:send("quadY", map.tiles[index].y)
			love.graphics.draw(map.tileset.image, map.tiles[index].quad,
        (column-1)*map.tiles.tileW, (row-1)*map.tiles.tileH)
      index = index + 1
		end
	end
	love.graphics.setShader()
end

function map.structures_draw(shader)
  love.graphics.setShader( shader )
	for rowIndex = 1, #tilemap do
		local row = structures[rowIndex]
		for columnIndex = 1, #row do
			local index = row[columnIndex]
			shader:send("quadX", tiles[index].x)
			shader:send("quadY", tiles[index].y)
			love.graphics.draw(tileset.image, tiles[index].quad, (columnIndex-1)*tiles.tileW, (rowIndex-1)*tiles.tileH)
		end
	end
	love.graphics.setShader()
end

function map.units_draw(shader)
  love.graphics.setShader( shader )
	for rowIndex = 1, #tilemap do
		local row = units[rowIndex]
		for columnIndex = 1, #row do
			local index = row[columnIndex]
			shader:send("quadX", tiles[index].x)
			shader:send("quadY", tiles[index].y)
			love.graphics.draw(tileset.image, tiles[index].quad, (columnIndex-1)*tiles.tileW, (rowIndex-1)*tiles.tileH)
		end
	end
	love.graphics.setShader()
end
return map
