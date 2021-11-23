void program() {
  
  c = imgp.display();
  //image(c,0,0);
  ////b.run();
  //b.toggle(1, 0, imgp, "toggle");
  Dropdown d1 = t1.dmenus.get(0);
  //d1.debug = true;
  Dropdown d2 = t1.dmenus.get(1);
  Dropdown d3 = t1.dmenus.get(2);
  int[]spi1 = {0, 1, 2, 3, 4, 5,6,7,8,9,10,11,12};
  //println(c);
  imgp.function = d1.index;
  imgp.shaderId = d2.index;
  //imgp.textureId = d3.index;
  t1.toggle(0,4,imgp.shaderSliders,"toggle");
  t1.toggle(0,0,imgp,"save");
  t1.toggle(0,1,imgp,"load");
  t1.toggle(0,2,imgp.workFlow1,"toggle");
  t1.toggle(0,5,imgp,"reset");
  //if(t1.toggle(0,0)){
  //  b.output.img = c.get();
  //  b.output.logic();
  //}
  //if (m2.toggle(1, imgp, "applyShader")) {
  //  imgp.applyTexture = false;
  //  imgp.updateTabs = true;
  //}
  //if (m2.toggle(2, imgp, "applyTexture")) {
  //  imgp.applyShader = false;
  //  imgp.updateTabs = true;
  //}
  //if(b.theme.click)println("sketch",imgp.function);
};

//@Override
//  void onActivityResult(int requestCode, int resultCode, Intent data) {
//  iin.handleActivity(requestCode, resultCode, data);
//};
