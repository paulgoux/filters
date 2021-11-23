
precision mediump float;
precision mediump int;


#define PROCESSING_TEXTURE_SHADER;

uniform sampler2D texture;
uniform float mult;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

void main(void) {
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;

  float PI = 3.14159265359;
  vec4 horizEdge = vec4( 0.0 );
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y ) ) * 1.0;
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y     ) ) * 4.0;
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y ) ) * 1.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y ) ) * 1.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y     ) ) * 4.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y ) ) * 1.0;

  vec4 vertEdge = vec4( 0.0 );
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y ) ) * 1.0;
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x    , vertTexCoord.y - y ) ) * 4.0;
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y ) ) * 1.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y ) ) * 1.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x    , vertTexCoord.y + y ) ) * 4.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y ) ) * 1.0;

  vec3 edge = sqrt((horizEdge.rgb * horizEdge.rgb) + (vertEdge.rgb * vertEdge.rgb));
  float x1 = (horizEdge.r+horizEdge.g+horizEdge.b)/3.0;
  float y1 = (vertEdge.r+vertEdge.g+vertEdge.b)/3.0;
	float m = 0.001;
	float n = 4.0;
	float k = 0.8;
	float x2 = map(x1,0.0-m,m,0.0,n);
	float y2 = map(y1,0.0-m,m,0.0,n);
	float t1 = atan(y2,x2);
  float sum = (edge.r+edge.g+edge.b)/3.0;
	//float mag = map(sum,0.0,k,0.0,n);
	float mag = sum;
	
	if(t1<0) gl_FragColor = vec4(n-x2,n-y2,1.0-mag*mult,1.0);
	else gl_FragColor = vec4(x2,y2,1.0-mag*mult,1.0);
	//gl_FragColor = vec4(n-x2,n-y2,1.0-mag*mult,1.0);
	
	//gl_FragColor = vec4(1.0-x1,1.0-y1,1.0-mag*mult,1.0);
  


}
