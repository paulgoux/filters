

//#ifdef GL_ES
precision mediump float;
precision mediump int;
//#endif

#define PROCESSING_TEXTURE_SHADER;

uniform sampler2D texture;
uniform float thresh;

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

  float q = 1.0;
  float r = 1.0;
  vec4 p1 = vec4( 0.0 );
  vec4 p2 = vec4( 0.0 );
  float m = 32.0;
	float n = 1.0;
  vec4 mCol = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y ) );
	float x1 = map(mCol.r,0.0,m,0.0-n,n);
	float y1 = map(mCol.g,0.0,m,0.0-n,n);
	//x1 = mCol.r;
	//y1 = mCol.g;
  float a1 = atan(y1,x1);
	float myGrad = map(a1,0.0-PI,PI,0.0,360.0);
  float myCol = mCol.b;
	
	  
		if ((0 <= myGrad && myGrad < (22.5))){
			p1 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y ) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y ) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 45
		else if ((22.5) <= myGrad && myGrad < (67.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 90
		else if ((67.5) <= myGrad && myGrad< (112.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y + y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y - y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 135
		else if((112.5) <= myGrad && myGrad < (157.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 180
		else if ((157.5) <= myGrad && myGrad < (202.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y ) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y ) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 225
		else if ((202.5) <= myGrad && myGrad < (247.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		
		//angle 270
		else if ((247.5) <= myGrad && myGrad < (292.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 315
		else if ((292.5) <= myGrad && myGrad < (337.5)){
			p1 = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y - y) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y + y) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		//angle 360
		else if ((337.5) <= myGrad && myGrad <= (360)){
			p1 = texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y ) ) * 1.0;
			p2 = texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y ) ) * 1.0;
			q = p1.b;
			r = p2.b;
		}
		
		if((r<thresh&&myCol<=r)&&(q<thresh&&myCol<=q)){
			//gl_FragColor = vec4(1.0-myCol,1.0-myCol,1.0-myCol,1.0);
			gl_FragColor = vec4(0.0,0.0,0.0,1.0);
		}else{
			gl_FragColor = vec4(1.0 ,1.0,1.0,1.0);
		}
		
};
