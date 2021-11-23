#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;

uniform range;

void main(void) {
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  // Grouping texcoord variables in order to make it work in the GMA 950. See post #13
  // in this thread:
  // http://www.idevgames.com/forums/thread-3467.html
  vec4 col = vec4(0);
  vec4 col0 = vec4(0);
  int count = 0;
  for(int i=-range;i<range;i++){
    for(int j=-range;j<range;j++){
    vec2 tc0 = vertTexCoord.st + vec2(+i*x, +j*y);
    vec4 mean = texture2D(mean,tc0);
    vec4 img = texture2D(texture,tc0);
    col0 += vec4((mean-img)*(mean-img));
    count++;
    }
  }
  vec4 var = vec4(sqrt(col0*col0));
  gl_FragColor = var;  
}
