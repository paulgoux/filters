#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 resolution;
//uniform vec2 iMouse;
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform int size;
uniform float size1;
uniform float sigma;
float normpdf(in float x, in float sigma){
  return 0.39894*exp(-0.5*x*x/(sigma*sigma));
}

void main(void){
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  vec2 uv = vertTexCoord.st;
  vec3 c = texture2D(texture, uv).rgb;
  
    
    //declare stuff
    const int mSize = 100;
    //const int kSize = (size-1)+1;
    //const int kSize = size;
    float kernel[mSize];
    vec3 final_colour = vec3(0.0);
    
    //create the 1-D kernel
    
    float Z = 0.0;
    for (int j = 0; j < size; ++j){
      kernel[size+j] = kernel[size-j] = normpdf(float(j), sigma);
    }
    
    //get the normalization factor (as the gaussian has been clamped)
    for (int j = 0; j < size; ++j){
      Z += kernel[j];
    }
    
    //read out the texels
    float s = size1;
    int ii = 0;
    int jj = 0;
    for (float n=-s; n < s+1.0; ++n){
    ii++;
      for (float m=-s; m < s+1.0; ++m){
        float mag = sqrt(n*n+m*m);
        jj ++;
        if(mag<size1){
        final_colour += 
        kernel[size+jj]*kernel[size+ii]*
        texture2D(texture, 
        uv+vec2(n*x,m*y)).rgb*0.1;
        // (uv+vec2(ii*x,jj*y)) / uv).rgb;
  
       }}
    }
    
    gl_FragColor = vec4(final_colour/(Z*Z), 1.0);
    // gl_FragColor = vec4(0.0);
}
