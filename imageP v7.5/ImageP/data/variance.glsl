//variance
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
//variance
uniform sampler2D texture;
uniform sampler2D Mean;
uniform sampler2D Img;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;

uniform float range;
uniform float mult;
uniform float mr;
uniform float mg;
uniform float mb;
uniform float ma;
uniform float type;
void main(void) {
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  // Grouping texcoord variables in order to make it work in the GMA 950. See post #13
  // in this thread:
  // http://www.idevgames.com/forums/thread-3467.html
  vec2 tx = vertTexCoord.st;
  vec4 myCol = texture2D(texture,tx);
  vec4 col = vec4(0.0);
  vec4 col0 = texture2D(Mean,tx);
  vec4 max = vec4(0.0);
  vec2 tc1 = vec2(0.0);
  float count = 0.0;
  for (float i=-range; i<range+1.0; i++) {
    for (float j=-range; j<range+1.0; j++) {
      tc1 = vertTexCoord.st+vec2(i*x, j*y);
      vec4 mean = texture2D(Mean, tc1);
      vec4 img = texture2D(Img, tc1);
      float avmean = (mean.r+mean.g+mean.b)/3.0;
      float avimg = (img.r+img.g+img.b)/3.0;
      col += mean-img;
      col = vec4(avmean-avimg);
      col += vec4(((mean.r-img.r)+(mean.b-img.b)+(mean.g-img.g))/3.0);
      count++;
    }
  }
  vec4 t = col/count;
  vec4 t1 = col;
  vec4 var = vec4(sqrt(t*t));
  vec4 var1 = vec4(sqrt(t1*t1));
  vec4 var2 = vec4(col*col-sqrt(t1*t1));
  vec4 var3 = vec4(col*col-sqrt((t1*t1)*(t1/t1)));
  float av = ((col.r)+(col.g)+(col.b)+(col.a))/4.0;
  float av1 = ((var.r)+(var.g)+(var.b)+(var.a))/4.0;
  float av2 = ((var1.r)+(var1.g)+(var1.b)+(var1.a))/4.0;
  float av3 = ((var2.r)+(var2.g)+(var2.b)+(var2.a))/4.0;
  float av4 = ((var3.r)+(var3.g)+(var3.b)+(var3.a))/4.0;
  //float r = myCol.r;
  //float g = myCol.g;
  //float b = myCol.b;
  //float a = myCol.a;
  float r = col.r;
  float g = col.g;
  float b = col.b;
  float a = col.a;
  float k = sqrt((av1 + ( av1 - av)) * av + (var.r + ( var.r - r)) * r + (var.g + ( var.g - g)) * g + (var.b + ( var.b - b)) * b);
  float k1 = av1*av1*av1 - (av1 + av)*(av1 - av)*(var.r + r)*(var.r - r)*(var.g + g)*(var.g - g)*(var.b + b)*(var.b - b)*(var.a + a)*(var.a - a);
  //k1 = av1*av1*av1 - (av1 + col.a)*(av1 - col.a)*(var.r + r)*(var.r - r)*(var.g + g)*(var.g - g)*(var.b + b)*(var.b - b)*(var.a + a)*(var.a - a);
  //k1 = av2*av2*av2 - (av2 + col.a)*(av2 - col.a)*(var.r + r)*(var.r - r)*(var.g + g)*(var.g - g)*(var.b + b)*(var.b - b)*(var.a + a)*(var.a - a);
  //k1 = av1*av1*av1 - (av1 + col.a)*(av1 - col.a)*(var.r + r)*(var.r - r)*(var.g + g)*(var.g - g)*(var.b + b)*(var.b - b)*(var.a + a)*(var.a - a);
  k1 = av4*av4*av4 - (av4 + col.a)*(av4 - col.a)*(var.r + r*mr)*(var.r - r*mr)*(var.g + g*mg)*(var.g - g*mg)*(var.b + b*mb)*(var.b - b*mb)*(var.a + a*ma)*(var.a - a*ma);
  var1 = vec4(k1);
  var = vec4(k1);
  if(type==0.0)
  gl_FragColor = vec4(var.rgb*mult,1.0); 
  else if(type==1.0)
  gl_FragColor = vec4(1.0-(var.rgb)*mult,1.0); 
  else if(type==2.0)
  gl_FragColor = vec4(var1.rgb*mult,1.0); 
  else if(type==3.0)
  gl_FragColor = vec4(1.0-(var1.rgb)*mult,1.0); 
  else if(type==4.0)
  gl_FragColor = vec4((var.rgb-col.rgb)*mult,1.0); 
  else if(type==5.0)
  gl_FragColor = vec4(1.0-(var.rgb-col.rgb)*mult,1.0); 
  else if(type==6.0)
  gl_FragColor = vec4((var.rgb-col0.rgb)*mult,1.0); 
  else if(type==7.0)
  gl_FragColor = vec4(1.0-(var.rgb-col0.rgb)*mult,1.0); 
  else if(type==8.0)
  gl_FragColor = vec4((var1.rgb-col.rgb)*mult,1.0); 
  else if(type==9.0)
  gl_FragColor = vec4(1.0-(var1.rgb-col.rgb)*mult,1.0); 
  else if(type==10.0)
  gl_FragColor = vec4((var1.rgb-col0.rgb)*mult,1.0); 
  else if(type==11.0)
  gl_FragColor = vec4(1.0-(var1.rgb-col0.rgb)*mult,1.0);
  else if(type==12.0)
  gl_FragColor = vec4(1.0-(var1.rgb-col0.rgb)*mult,1.0);
  else if(type==13.0)
  gl_FragColor = vec4(1.0-(var1.rgb-col0.rgb)*mult,1.0);
  
  //gl_FragColor = vec4(1.0);
  //gl_FragColor = var;
}
