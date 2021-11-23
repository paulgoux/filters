//import android.content.Intent; 
import processing.video.*;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;
BMS b, bb1;
BMScamera cam;
TextArea ta1, ta2;
imageProcessor imgp;
Button b1;
Menu m1, m2, m3, m4, m5, save, saveMenu;

tab t1, t2;
accordionTab at1;
SliderBox sl1;
Dropdown d1, d2, d3, d4;
//imgOutput iout;
fileInput iin;
imagePicker iin2;

String []menuLabels1 = {"Load", "Save", "Pick Camera", "Load workflow", 
  "Save workflow", "Restore Menus"};
PShader bw;
PGraphics c;
//PImage img1;
int[] s1 = {0, 1, 2, 3, 4, 5};
int[] s2 = {0, 1, 2, 3, 4, 5, 6, 7};
int[] s3 = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
String []l2 = {"Blur", "Mean", "Variance", "Sobel", "Canny", "Gaussian", 
      "Gaussian 2", "Gaussian 3", "Brcosa", "Hue", "Pixelate", "Blur1", "Channels", 
      "Threshold", "Neon", "Wrap", "Deform", "PixelRolls", "Patches", "ModColor", 
      "Halftone", "Halftone cmyk", "Inverson", "Bilateral"};
String []l3 = {"brcosa.glsl", "hue.glsl", "pixelate.glsl", "blur.glsl", 
  "channels.glsl", "threshold.glsl", "neon.glsl", "wrap.glsl", "deform.glsl", 
  "pixelrolls.glsl", "patches.glsl", "modcolor.glsl", "halftone.glsl", 
  "halftone_cmyk.glsl", "invert.glsl", "bilateral_filter.glsl"};
void setup() {
  size(700, 600, P2D);
  //iin2 = new imagePicker(this);
  b = new BMS(this, true);
  //bb1 = new BMS(b);

  b.setupDock();
  //b.createCamera();
  //cam = b.camera;
  iin2 = null;
  //orientation(LANDSCAPE);

  String [] d1l = {"1", "2"};

  //iout = new imgOutput(b);
  iin = new fileInput(b);
  //iin.image = true;

  imgp = new imageProcessor(b);
  imgp.loadShaders();
  
  imgp.set("circle.jpg");
  imgp.initCanvasesP2D();
  //println("setup tabs", imgp.shaderSliders.states.size());

  b.setTransparency(200);
  String []m1Labels = {"IMGP", "Shader Type", "Shader Tex"};

  m2 = new Menu(200, 0, 90, 50, "IMG", m1Labels, b);
  String []l1 = {"Image", "Image F", "ScreenShot", "Video", "Cam", "Video F", 
    "WorkFlow"};
  m2.createSubMenu(0, l1);

  c = createGraphics(displayWidth, displayHeight, P2D);
  t1 = new tab( width-143, 0, 143, height-20, "             ", b);
  t1.title.h = 40;

  t1.toggle = true;
  t1.draggable = true;
  String []l5 = {"", "Image", "Image F", "ScreenShot", "Video", "Cam", "Video F", 
    "WorkFlow", "Load workflow", "Save workflow", "Restore Menus", "Save img", "Save vid"};

  d1 = new Dropdown(00, 20, t1.w, 40, 0, "Pick", l5, b);
  d1.setclassicBar();
  t1.add(d1);
  d2 = new Dropdown(00, 70, d1.w, 40, 0, "Pick S1", l2, b);
  d2.setclassicBar();
  t1.add(d2);
  //b.add(t1);

  d3 = new Dropdown(00, 170, d1.w, 40, 0, "Pick S2", l3, b);
  //d3.draggable = true;
  d3.setclassicBar();
  t1.add(d3);
  b.add(t1);

  b.setFontColor(0, 0, 0);
  imgp.toggle = true;
  String []menuLabels = {"Save", "Load", "Workflow", "Options", "Settings","Reset"};
  saveMenu = new Menu(30, height - 7*40, t1.w, 40, 0, menuLabels, b);
  t1.add(saveMenu);
  b.bg = false;
  //b.dock.add(t1);
  //cam.start();
  //imgp.getCam();
  //imgp.cam = null;
  println("dim",imgp.c1.width,imgp.c1.height);
};

void draw() {

  background(255);
  if (c!=null)
  image(imgp.c3, 0, 0);
  //rect(2,2,imgp.img.width-4,imgp.img.height-4);
  if(imgp.workFlow1.tabs.size()>1){
    tab t = imgp.workFlow1.tabs.get(1);
    //t.setPos(200,200);
    //t.disptab();
    //t.title.draw();
    //t.title.toggle(t,"visible");
    //println(t.title.x,t.title.y,t.label,t.bx,t.by,t.visible,t.toggle);
    //if(t.canvas!=null)
    //t.displayTab();;
  }
  b.run();

  program();
  b.theme.run();
  //println("d1",d1.w,d1.c.width,d1.c.height);
  //println("d2",d2.w,d2.c.width,d2.c.height);
  //println("d2",d2.w,d3.c.width,d3.c.height);
  fill(0);
  textSize(20);
  text(frameRate, 90, 90);
  textSize(12);
};

void onCameraPreviewEvent() {
  cam.read();
};

void mousePressed() {
  //if(t1.getToggle(0,1))iin2 = new imagePicker(b);
  //imgp.cam = null;
  //imgp.getCam();

  //cam.toggleFlash();
};
