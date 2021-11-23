#ifdef GL_ES
  precision mediump float;
precision mediump int;
#endif

  #define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D texture1;
uniform float range;
uniform float type;
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution;
uniform float mult;
uniform float min;

void main(void) {

  
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  //float range = 1.0;
  vec4 max = vec4(0.0);

  vec2 tc = vertTexCoord.st+ vec2(0.0, 0.0);
  vec4 col1= texture2D( texture, tc );

  vec4 col0 = texture2D(texture, tc);

  vec4 col = vec4(0.0);
  vec2 tc1 = vec2(0.0);
  float av = ((max.r)+(max.g)+(max.b))/3.0*mult;
  float av1 = av;

  for (float i=-range; i<range+1.0; i++) {
    for (float j=-range; j<range+1.0; j++) {
      tc1 = vertTexCoord.st+vec2(i*x, j*y);
      vec4 ccol = texture2D(texture1, tc1);
      vec4 ccol1 = texture2D(texture1, tc1);
      //ccol = vec4(ccol.a);
      col += ccol;
      col1+= ccol1;

      // float b = ((ccol.r)+(ccol.g)+(ccol.b))/3.0*mult;
      // if (b>av)max = texture2D(texture, tc1);
      
      // float b1 = ((ccol1.r)+(ccol1.g)+(ccol1.b))/3.0*mult;
      // if (b1>av1)max = texture2D(texture1, tc1);
    }
  }
  float a = (range+range);
  vec4 sum = col / ((a+1.0)*(a+1.0));
  vec4 sum1 = col1 / ((a+1.0)*(a+1.0));
  //sum = vec4(sum.a);
  float b = ((sum.rgb-col0.rgb).r+(sum.rgb-col0.rgb).g+(sum.rgb-col0.rgb).b)/3.0*mult;
  b = ((sum.rgb-col0.rgb).r+(sum.rgb-col0.rgb).g+(sum.rgb-col0.rgb).b)/3.0*mult;
  float b1 = ((max.rgb).r+(max.rgb).g+(max.rgb).b)/3.0;
  float b2 = ((sum.rgb).r+(sum.rgb).g+(sum.rgb).b)/3.0;
  float b3 = ((col0.rgb).r+(col0.rgb).g+(col0.rgb).b)/3.0;
  float b4 = ((col1.rgb).r+(col1.rgb).g+(col1.rgb).b)/3.0;
  //vec3 c = vec3((sum.rgb-max.rgb)*mult);
  //vec3 d = vec3((sum.rgb-col0.rgb)*mult);
  vec3 c = vec3((sum.rgb-b1));
  vec3 d = vec3((sum.rgb-b3));
  vec3 e = vec3((sum1.rgb-b4));
  //if(b>0){
    
  if (type==0.0){
    gl_FragColor = vec4(1.0-d*mult, 1.0);
  }else if (type==1.0){
    gl_FragColor = vec4(d*mult, 1.0);
  }else if (type==2.0)
    gl_FragColor = vec4(c*mult, 1.0);
  else if (type==3.0)
    gl_FragColor = vec4(1.0-(c)*mult, 1.0);
  else if (type==4.0)
    gl_FragColor = vec4(1.0-sqrt(d*d)*mult, 1.0);
  else if (type==5.0)

    gl_FragColor = vec4(sqrt(d*d)*mult, 1.0);

  else if (type==6.0)
    gl_FragColor = vec4(1.0-(sqrt(c*c)*mult), 1.0);
  else if (type==7.0)
    gl_FragColor = vec4(1.0-(sqrt(c*c)*mult)-col0.rgb, 1.0);
  else if (type==8.0)
    gl_FragColor = vec4(sqrt(sqrt(c*c)*sqrt(d*d))*mult, 1.0);
  else if (type==9.0)
    gl_FragColor = vec4(sqrt(sqrt(c*c)*sqrt(d*d))*mult-col0.rgb, 1.0);
  else if (type==10.0)
    gl_FragColor = vec4(sqrt(sqrt(c*c)/sqrt(d*d))*mult, 1.0);
  else if (type==11.0) {
    vec3 a = vec3((sqrt(d*d)+sqrt(d*d))*mult);

    //if(a.r<1&&a.g<1&&a.b<1.0)
    gl_FragColor = vec4(a-col0.rgb, 1.0);
    //else gl_FragColor = vec4(1.0);
  } else if (type==12.0)
    gl_FragColor = vec4(1.0-sqrt((sum.rgb*col0.rgb)*(sum.rgb*col0.rgb)+
      (sum.rgb*col0.rgb)*(sum.rgb*col0.rgb))*mult
      , 1.0);
  else if (type==13.0)
    gl_FragColor = vec4((sqrt(sum.rgb*sum.rgb-(sum.rgb+col0.rgb)*(sum.rgb+col0.rgb)*
      (sum.rgb+col0.rgb)*(sum.rgb+col0.rgb))-col0.rgb)*mult
      , 1.0);
  else if (type==14.0)
    gl_FragColor = vec4(1.0-sqrt((sum.rgb-col0.rgb)*(sum.rgb+col0.rgb))*mult
      , 1.0);
  else if (type==15.0)
    gl_FragColor = vec4(sqrt((sum.rgb-col0.rgb)*(sum.rgb+col0.rgb))*mult
      , 1.0);

  //}else gl_FragColor = col/mult;
}
