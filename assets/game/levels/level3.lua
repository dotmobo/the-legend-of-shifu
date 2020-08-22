return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 11,
  height = 9,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 5,
  nextobjectid = 2,
  properties = {},
  tilesets = {
    {
      name = "tileset3",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../../tilesets/tilesets/tileset3.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 64,
      tiles = {
        {
          id = 34,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 35,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 36,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 37,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 38,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 39,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 42,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 45,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 46,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 47,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 50,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 55,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 58,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 59,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 60,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 61,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 62,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 63,
          properties = {
            ["collidable"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "ground",
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
        54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54
      }
    },
    {
      type = "tilelayer",
      id = 2,
      name = "subground",
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0,
        0, 44, 44, 0, 0, 0, 0, 0, 53, 45, 0,
        0, 44, 44, 0, 0, 0, 0, 0, 0, 53, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 53, 45, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 45, 53, 0,
        0, 0, 46, 0, 0, 0, 0, 0, 53, 45, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 0, 0, 45, 47,
        0, 0, 0, 0, 0, 0, 0, 0, 45, 53, 44
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "blocks",
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        35, 39, 39, 39, 39, 39, 39, 39, 39, 38, 40,
        43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        43, 0, 0, 0, 0, 0, 0, 0, 46, 0, 48,
        43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        43, 0, 0, 0, 0, 47, 0, 0, 0, 0, 48,
        43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56,
        43, 0, 0, 0, 0, 0, 0, 0, 35, 60, 64,
        43, 0, 0, 0, 0, 0, 0, 35, 64, 0, 0,
        59, 62, 60, 60, 60, 60, 60, 64, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 73.6192,
          y = 216.988,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
