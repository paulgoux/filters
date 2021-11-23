#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;
uniform float mult;
uniform float max;
 
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;

void main(void) {
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  vec2 uv = vertTexCoord.st;
  vec3 c = texture2D(texture, uv).rgb;
  int kSize = 1;
  //read out the texels
  for (int i=-kSize; i < kSize; ++i) {
    for (int j=-kSize; j < kSize; ++j) {
      float mag = sqrt(i*i+j*j);
    }
  }

  gl_FragColor = vec4(c/10000, 1.0);
}
