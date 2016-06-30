
//extern vec4 palette_colors[2]; // size of color palette (2 colors)
extern number dt, quadX, quadY, quadW, quadH, tilesetW, tilesetH, offset;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
  vec2 quad_coords = vec2((texture_coords.x * tilesetW - quadX) / quadW,(texture_coords.y * tilesetH - quadY) / quadH);
  if(pixel == vec4(1.0,1.0,1.0,1.0)){
    return pixel;
  }
  //pulse background with a gold/brown gradient
  else if(pixel == vec4(1.0,0.0,1.0,1.0)){
  vec2 quadCenter = vec2(0.5,0.5);
  vec2 quadDistance = (quad_coords - quadCenter);
  number green = 0.6 - length(quadDistance);
  number red = 0.4 - length(quadDistance);
  number blue = 0.2 - length(quadDistance);
  pixel = vec4(red,green,blue, 0.5 + 0.4*(sin(dt*2.5)));
    return pixel;
  }
  else{
      return pixel * color;
  }
}
