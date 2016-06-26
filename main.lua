-- load libs
local camera = require "libs/hump.camera"

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
	--gradient shader over time on "foreground" or ascii character
	shader1 = love.graphics.newShader(
  [[
    extern vec4 palette_colors[2]; // size of color palette (2 colors)
    extern number dt, quadX, quadY, quadW, quadH, tilesetW, tilesetH;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      //vec2 quad_coords = vec2((texture_coords.x * tilesetW - quadX) / quadW,(texture_coords.y * tilesetH - quadY) / quadH);
      if(pixel == vec4(1.0,1.0,1.0,1.0)){
      	pixel = vec4(1.0,0.0,0.0,1.0);
	  	number average = (pixel.r+pixel.b+pixel.g)/3.0;
	  	number factorX = (texture_coords.x * tilesetW - quadX) / quadW;
	  	factorX = factorX + dt;
	  	//number factorY = (texture_coords.y * tilesetH - quadY) / quadH;
	  	pixel.r = pixel.r + (average-pixel.r) * factorX;
	  	//pixel.g = pixel.g + (average-pixel.g) * factorX;
	  	//pixel.b = pixel.b + (average-pixel.b) * factorX;
      	return pixel;
      }
      if(pixel == vec4(1.0,0.0,1.0,1.0)){
      	return vec4(0.0,0.0,0.0,0.0);
      }
      return pixel * color;
    }

  ]] )
	--gradient shader over time on "background"
	shader2 = love.graphics.newShader(
  [[
    extern vec4 palette_colors[2]; // size of color palette (2 colors)
    extern number dt, quadX, quadY, quadW, quadH, tilesetW, tilesetH, offset;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      //vec2 quad_coords = vec2((texture_coords.x * tilesetW - quadX) / quadW,(texture_coords.y * tilesetH - quadY) / quadH);
      if(pixel == vec4(1.0,1.0,1.0,1.0)){
      	//pixel = vec4(1.0,0.0,0.0,1.0);
      	return pixel;
      }
      if(pixel == vec4(1.0,0.0,1.0,1.0)){
      	pixel = vec4(0.0,0.7,0.0,0.8);
	  	number quadCoordX = (texture_coords.x * tilesetW - quadX) / quadW;
	  	number factorX = quadCoordX + dt;
	  	number quadCoordY = (texture_coords.y * tilesetH - quadY) / quadH;
	  	number factorY = (quadCoordY + 2) * dt;
	  	//pixel.r = pixel.r + (average-pixel.r) * factorX;
	  	pixel.g = pixel.g * factorX * factorY;
	  	//pixel.b = pixel.b + (average-pixel.b) * factorX;
      	return pixel;
      }
      return pixel * color;
    }
  ]] )
	--gradient bar moves over background
	-- use an offset variable against the y coord ?
	shader3 = love.graphics.newShader(
  [[
    extern vec4 palette_colors[2]; // size of color palette (2 colors)
    extern number dt, quadX, quadY, quadW, quadH, tilesetW, tilesetH, offset;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      //vec2 quad_coords = vec2((texture_coords.x * tilesetW - quadX) / quadW,(texture_coords.y * tilesetH - quadY) / quadH);
      if(pixel == vec4(1.0,1.0,1.0,1.0)){
      	//pixel = vec4(1.0,0.0,0.0,1.0);
      	return pixel;
      }
      if(pixel == vec4(1.0,0.0,1.0,1.0)){
	  	number quadCoordX = (texture_coords.x * tilesetW - quadX) / quadW;
	  	//number factorX = quadCoordX + dt;
	  	number quadCoordY = (texture_coords.y * tilesetH - quadY) / quadH;
	  	number factorY = (quadCoordY + 2) * dt;
	  	number centerY = quadH/2;
	  	number gradientH = quadH/10;
	  	if(quadCoordY>centerY){
	  		if(quadCoordY<(centerY + gradientH)){
	  			pixel.r = 0.0;
			  	pixel.g = 1.0 - (quadCoordY) * dt;
			  	pixel.b = 0.0;
			  	//pixel.a = quadCoordX * dt;
		      	return pixel;
	  		}
	  	}
	  	pixel.r = 0.0;
	  	pixel.g = 1.0 - (quadCoordY) * dt;
	  	pixel.b = 0.0;
	  	//pixel.a = quadCoordX * dt;
      	return pixel;
      }
      return pixel * color;
    }
  ]] )

		shader = love.graphics.newShader(
  [[
    extern vec4 palette_colors[2]; // size of color palette (2 colors)
    extern number dt, quadX, quadY, quadW, quadH, tilesetW, tilesetH, offset;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      vec2 quad_coords = vec2((texture_coords.x * tilesetW - quadX) / quadW,(texture_coords.y * tilesetH - quadY) / quadH);
      if(pixel == vec4(1.0,1.0,1.0,1.0)){
      	//pixel = vec4(1.0,0.0,0.0,1.0);
      	return pixel;
      }
      if(pixel == vec4(1.0,0.0,1.0,1.0)){
	  	//number quadCoordX = (texture_coords.x * tilesetW - quadX) / quadW;
	  	//number factorX = quadCoordX + dt;
	  	//number quadCoordY = (texture_coords.y * tilesetH - quadY) / quadH;
	  	//number factorY = (quadCoordY + 2) * dt;
	  	//vec2 quadCenter = vec2((quadW/2 - quadX)/tilesetW,((tilesetH - quadY) / quadH)/2);
	  	vec2 quadCenter = vec2(0.5,0.5);
	  	vec2 quadDistance = (quad_coords - quadCenter);
	  	number green = 0.7 - length(quadDistance);
	  	number red = 0.7- length(quadDistance);
	  	pixel = vec4(red,green,0.0,0.8 * (dt));
      	return pixel;
      }
      return pixel * color;
    }
  ]] )
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
