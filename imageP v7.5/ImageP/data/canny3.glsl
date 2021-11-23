
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
  #define MERGE 0
  // sets RGB based on edge angle
  #define COLOR_ANGLE 1
  #define OUTLINE_COL 1.0, 1.0, 1.0
  // enable / disable canny, uses only sobel edge
  #define CANNY 1
  // STEP effects thickness
  #define STEP 1.0
  // MIN outline brightness mask
  //#define MIN 0.2
  // MAX NOT USED
  #define MAX 0.5f 
  //#define INTENSITY 1.0

  // GREENSCREEN requires MERGE
  #define GREENSCREEN 0
  #define GREENSCREEN_CHANNEL iChannel2
  #define threshold 0.55
  #define padding 0.01
 
uniform sampler2D texture;
uniform float mult;
uniform float type;
uniform float MIN;
uniform float INTENSITY;
 
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
const float M_PI = 3.14159265358979323846264338327950288;

// ------------------------------
//  SHADERTOY CODE BEGINS HERE  -
// ------------------------------

float GetBrightness(vec2 uv) {
  vec4 color = texture2D(texture, uv);
  if(type==0.0)
  return sqrt(((color.x * color.x) + (color.y*color.y) + (color.z * color.z))+
                    ((color.x * color.x) + (color.y*color.y) + (color.z * color.z)));
  else if(type==1.0)
  return mult/sqrt(((color.x * color.x) + (color.y*color.y) + (color.z * color.z))+
                    (mult-(color.x * color.x) * 
                    mult-(color.y*color.y) / 
                    (mult-(color.z * color.z))));
  else if(type==2.0)
  return mult/sqrt(((color.x * color.x) + (color.y*color.y) + (color.z * color.z))+
                    ((color.x * color.x) * (color.y*color.y) / 
                    ((color.z * color.z))));
}

vec2 Sobel(vec2 uv) {
  float stepx = 1.0 / resolution.x;
  float stepy = 1.0 / resolution.y;

  vec2 uvTL = vec2(uv.x-stepx, uv.y+stepy);
  vec2 uvML = vec2(uv.x-stepx, uv.y);
  vec2 uvBL = vec2(uv.x-stepx, uv.y-stepy);

  vec2 uvTR = vec2(uv.x+stepx, uv.y+stepy);
  vec2 uvMR = vec2(uv.x+stepx, uv.y);
  vec2 uvBR = vec2(uv.x+stepx, uv.y-stepy);

  vec2 uvTM = vec2(uv.x, uv.y+stepy);
  vec2 uvBM = vec2(uv.x, uv.y-stepy);
  // Time varying pixel color
  // vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
  float tl = GetBrightness(uvTL);
  float ml = GetBrightness(uvML);
  float bl = GetBrightness(uvBL);

  float tr = GetBrightness(uvTR);
  float mr = GetBrightness(uvMR);
  float br = GetBrightness(uvBR);

  float tm = GetBrightness(uvTM);
  float bm = GetBrightness(uvBM);

  float gx = 0.0f;
  gx += tl * -1.f;
  gx += ml * -2.f;     
  gx += bl * -1.f;

  gx += tr * 1.f;
  gx += mr * 2.f;     
  gx += br * 1.f;
  float gy = 0.0f;
  gy += tl * -1.f;
  gy += tm * -2.f;     
  gy += tr * -1.f;

  gy += bl * 1.f;
  gy += bm * 2.f;     
  gy += br * 1.f;

  return vec2(gx, gy);
}

float GetStrength(vec2 vg) {

  float gx = vg.x;
  float gy = vg.y;

  float g = (gx*gx+gy*gy);
  return g;
}

float GetAngle(vec2 vg) {
  float angle = atan(vg.y, vg.x);
  return angle;
}

void main(void) {
  
  float stepx = 1.0 / resolution.x;
  float stepy = 1.0 / resolution.y;
  
  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = vec2(vertTexCoord.st);
  vec2 sorbeA = Sobel(uv);
  float sobelA_Strength = GetStrength(sorbeA)*mult;
  float angle = GetAngle(sorbeA);
  #if CANNY
    vec2 dir;
  dir.x = cos(angle)*stepx;
  dir.y = sin(angle)*stepy;
  vec2 sobelB = Sobel(uv + dir);
  vec2 sobelC = Sobel(uv - dir);

  float sobelB_Strength = GetStrength(sobelB)*mult;    
  float sobelC_Strength = GetStrength(sobelC)*mult;

  if (sobelA_Strength < sobelB_Strength || sobelA_Strength < sobelC_Strength )
    sobelA_Strength = 0.0f;
  #endif
    // Treshold
    if (sobelA_Strength < MIN)
    sobelA_Strength = 0.0f;

  vec4 col = vec4(1.0, 1.0, 1.0, 1.0);

  #if MERGE
    #if GREENSCREEN
    vec4 greenScreen = vec4(0., 1., 0., 1.);
  vec4 sourceColor = texture2D(texture, uv);

  vec3 diff = sourceColor.xyz - greenScreen.xyz;
  float fac = smoothstep(threshold-padding, threshold+padding, dot(diff, diff));

  col += mix(sourceColor, texture2D(GREENSCREEN_CHANNEL, uv), 1.-fac);
  #else
    col += texture2D(texture, uv);
  #endif
    #endif

    #if COLOR_ANGLE
    vec3 outlineCol = vec3(sin(angle), sin(angle + 2.0f*M_PI/3.0f), sin(angle + 2.f*M_PI/3.0f * 2.0f));
  //vec3 outlineCol = vec3(10);

  #else
    vec3 outlineCol = vec3(OUTLINE_COL);
  #endif
    col += vec4((1.0-sobelA_Strength*INTENSITY), 
                (1.0-sobelA_Strength*INTENSITY),
                (1.0-sobelA_Strength*INTENSITY), 1.0);
  // Output to screen
  //col = vec4(angle,angle,angle,1.0f);
  gl_FragColor = col;
}