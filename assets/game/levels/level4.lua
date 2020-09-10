return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.2",
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
      name = "tileset4",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../../tilesets/tilesets/tileset4.png",
      imagewidth = 256,
      imageheight = 256,
      objectalignment = "unspecified",
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
          id = 43,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 44,
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
          id = 54,
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
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      id = 2,
      name = "subground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 54, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 54, 46, 0,
        0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 52, 52, 0, 0, 46, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 53, 0, 0, 0, 0, 0, 54, 46, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 54, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 11,
      height = 9,
      id = 3,
      name = "blocks",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        55, 55, 35, 36, 38, 36, 36, 36, 36, 36, 40,
        55, 35, 64, 0, 0, 0, 0, 0, 0, 55, 48,
        35, 64, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        51, 44, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        51, 0, 0, 0, 0, 0, 0, 0, 0, 45, 48,
        51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48,
        51, 0, 0, 0, 0, 0, 0, 0, 0, 55, 48,
        59, 63, 63, 63, 63, 63, 63, 62, 63, 63, 64
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 216.436,
          y = 218.117,
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
