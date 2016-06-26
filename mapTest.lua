return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "2016.05.25",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 15,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "testTileSet",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "testTileSet.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 20,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1, 1, 1, 9, 0, 0, 9, 0,
        1, 1, 1, 1, 0, 9, 1, 1, 1, 1, 5, 5, 5, 1, 1, 9, 6, 6, 9, 9,
        1, 1, 0, 1, 10, 9, 1, 2, 2, 0, 1, 1, 1, 5, 1, 9, 9, 1, 9, 9,
        1, 1, 1, 1, 10, 5, 5, 2, 2, 1, 1, 1, 5, 5, 6, 1, 9, 6, 0, 9,
        1, 1, 1, 1, 10, 9, 1, 5, 5, 5, 5, 1, 5, 5, 6, 1, 9, 9, 6, 0,
        1, 1, 2, 1, 10, 9, 2, 5, 5, 1, 1, 5, 5, 5, 6, 6, 9, 9, 9, 6,
        1, 2, 2, 1, 10, 10, 10, 2, 0, 1, 1, 1, 5, 5, 6, 6, 9, 0, 9, 2,
        1, 2, 2, 1, 1, 10, 10, 10, 10, 10, 1, 1, 5, 5, 6, 1, 9, 6, 1, 2,
        2, 2, 2, 1, 1, 10, 10, 5, 2, 5, 10, 1, 10, 5, 6, 10, 9, 9, 1, 2,
        1, 1, 2, 1, 10, 10, 1, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 9, 1, 1,
        1, 1, 2, 1, 10, 1, 1, 10, 1, 5, 0, 1, 1, 9, 9, 9, 1, 9, 0, 1,
        1, 1, 2, 1, 10, 10, 10, 10, 10, 10, 0, 1, 1, 9, 9, 9, 9, 2, 2, 1,
        1, 1, 2, 1, 1, 1, 10, 10, 1, 1, 1, 1, 10, 10, 1, 1, 9, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 1, 6, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    }
  }
}
