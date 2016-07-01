local map = {}
map.tiles = {}
map.tileset = require("src.tileset")
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

function map.tilemap_draw( shader )
  shader:send("quadW", map.tiles.tileW)
  shader:send("quadH", map.tiles.tileH)
  shader:send("tilesetW", map.tiles.tilesetW)
  shader:send("tilesetH", map.tiles.tilesetH)
  shader:send("dt",map.time)
  love.graphics.setShader( shader )
  local index = 1
	for row = 1, map.tilemap.width do
		for column = 1, map.tilemap.height do
      local tile_index = map.tilemap.data[index]
			shader:send("quadX", map.tiles[tile_index].x)
			shader:send("quadY", map.tiles[tile_index].y)
			love.graphics.draw(map.tileset.image, map.tiles[tile_index].quad,
        (column-1)*map.tiles.tileW, (row-1)*map.tiles.tileH)
      index = index + 1
		end
	end
	love.graphics.setShader()
end

function map.structures_draw(shader)
  love.graphics.setShader( shader )
	for rowtile_index = 1, #tilemap do
		local row = structures[rowtile_index]
		for columntile_index = 1, #row do
			local tile_index = row[columntile_index]
			shader:send("quadX", tiles[tile_index].x)
			shader:send("quadY", tiles[tile_index].y)
			love.graphics.draw(tileset.image, tiles[tile_index].quad, (columntile_index-1)*tiles.tileW, (rowtile_index-1)*tiles.tileH)
		end
	end
	love.graphics.setShader()
end

function map.units_draw(shader)
  love.graphics.setShader( shader )
	for rowtile_index = 1, #tilemap do
		local row = units[rowtile_index]
		for columntile_index = 1, #row do
			local tile_index = row[columntile_index]
			shader:send("quadX", tiles[tile_index].x)
			shader:send("quadY", tiles[tile_index].y)
			love.graphics.draw(tileset.image, tiles[tile_index].quad, (columntile_index-1)*tiles.tileW, (rowtile_index-1)*tiles.tileH)
		end
	end
	love.graphics.setShader()
end
return map
