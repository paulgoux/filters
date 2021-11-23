import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;

import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.opengl.PShader;
import processing.video.Movie; 

import java.awt.Rectangle;
import java.awt.Robot;
//import java.awt.AWTException;
//import it.tidalwave.java.awt.Rectangle.*;
//import hudson.plugins.robot.*;

public class imageProcessor {
  public BMS Bms;
  public PApplet p;
  public float Mean = 0, Variance, VarianceR, VariancfeG, VarianceB, VarianceBR, 
    s_mult, currentSliderPos = 30, ix, iy, workFlowDDHeight = 30, tabTitleHeight;
  public PImage img, img2;
  public float fx, fy;
  //mean, mean_, meanGx, meanGy, blurX, blurY, threshold, variance, varianceR, varianceG, varianceB, varianceBR, Gaussian, 
  //kMeans, kNearest, sobel, sobelx, sobely, sobel2, sobel2x, sobel2y, sobelMax, sobelMin, sobelG, gradientB, blur, combined, current, canny, cannyT, temp;
  public int cutoff = 250, gridRes = 1, Type = 3, pointMax = 30, min = 40, max = 10, 
    contourType = 1, linesCompleted, Mode = 4, thresh = 10, pixelThresh = 40, currentShader, 
    pixelThresh1 = 20, shaderId = -1, textureId = -1;
  public String currentParameter, currentS, folderLocation, audioLocation, videoLocation;

  public boolean state, bdown, slidersState, mdown1, pieSliders, classicSliders, getCam, 
    loadImage, loadVideo, getScreenShot, recorder, dataFolder, menus, applyShader, applyTexture
    , updateTabs, workflow, workflowFirstRun, workFlowRunning, runWorkFlow, reset;
  public int processes, function = -1;
  public ArrayList<String>workFlowLabels=new ArrayList<String>();
  public String []ddLabels = l2;

  public String []menuLabels = {"Load", "Save Workflow", "Save Image", "Restore Menus", "State"};
  public String []sobelSliderLabels = {"Mult", "Range"};
  public String []sobel2aliderLabels = {"Mult", "Range"};
  public String []sobel2bliderLabels = {"Mult", "Range", "Type"};
  public String []sobelSliderLabels1 = {"Mult", "Range", "Threshold"};
  public String []sobelGSSliderLabels = {"Mult", "Range"};
  public String []sobelSSliderLabels = {"Mult", "Range"};
  public String []sobelASliderLabels = {"Mult", "Range"};
  public String []sobel2SliderLabels = {"Mult", "Range"};
  public String []sobelMaxSliderLabels = {"Mult", "Range"};
  public String []sobelMax2SliderLabels = {"Mult", "Range"};
  public String []sobelMax3SliderLabels = {"Mult", "Range"};
  public String []sobelMax4SliderLabels = {"Mult", "Range"};
  public String []meanSliderLabels = {"Range"};
  public String []meanASliderLabels = {"Mult", "Range"};
  public String []meanSSliderLabels = {"Mult", "Range"};
  public String []varianceSliderLabels = {"Mult", "Range"};
  public String []blurSliderLabels = {"Mult", "Range"};
  public String []blurSSliderLabels ;
  public String []sharpenSliderLabels = {"Mult", "Range"};
  public String []substractSliderLabels ;
  public String []gaussian3SliderLabels ;
  public String []gaussian5SliderLabels ;
  public String []gaussianSSliderLabels = {"Mult", "Range"};
  public String []combineSliderLabels ;
  public String []cannySliderLabels = {"Mode", "Thresh"};
  public String []canny2SliderLabels = {"Mode", "Thresh", "Thresh1"};
  public String []canny3SliderLabels = {"Mode", "Thresh"};
  public String []cannyTSliderLabels = {"Type", "Thresh"};
  public String []cannyT1SliderLabels = {"Type", "Thresh"};
  public String []cannyT2SliderLabels = {"Type", "Thresh", "Thresh2"};
  public String []blendSliderLabels ;
  public String []variance2SliderLabels  = {"Range"};
  public String []variance3SliderLabels  = {"Range"};
  public String []menuLabels2 = {"Run"};
  public String []menuLabels3 = {"Clear"};
  public String []menuLabels4 = {"Run All"};
  public String [][]kernelLabels = {{"Range"}, 
    {"Mult", "Output"}, 
    {"Mult", "Range"}, 
    {"Mult", "Range", "Output"}, 
    {"Mult", "Thresh1", "Thresh2"}, 
    {"Mult", "Range"}, 

  };
  public String [] functions = {"Blur", "BlurS", "Gaussian 3", "Gaussian 5", "GausianS", "Mean", "MeanS", 
    "Variance", "VarianceS", "Sobel", "SobelS", "Sobel 2", "Sobel Max", "Canny", "CannyS"};
  public HashMap<String, String[]> workFlowSliders = new HashMap<String, String[]>();
  public String []sliderLabels, currentFolder, currentWorkFlow;
  public String file, folder, location;
  public PImage currentImage;
  public PGraphics canvas2;
  public Menu menu, run, runAll, clear;
  public Dropdown workFlowDD;
  int imgx, imgy;
  public SliderBox sobelSlider, meanSlider, varianceSlider, blurSlider, sobelMaxSlider, sharpenSlider, gaussianSlider ;
  public float currentF;
  int currentImageIndex, counter;
  public int firstImageIndex;
  public boolean update = true, imageF = true, videoF, audioF, camF, mdown, m2down, 
    updateSliders, sDown, docked, save, saveWorkflowImages;
  public final int IMAGES = 0, VIDEOS = 1, AUDIO = 2, MOVIE = 3, SOUND = 4;
  public boolean load, toggle, iUpdate, iUpdate2, iUpdate3, iUpdate4, wUpdate;
  public HashMap<String, Integer> textureHashMap = new HashMap<String, Integer>();
  public HashMap<String, Integer> shaderHashMap = new HashMap<String, Integer>();
  public ArrayList<PImage> images = new ArrayList<PImage>();
  public ArrayList<PImage> imagesWF = new ArrayList<PImage>();
  public ArrayList<PGraphics> pgraphicsWF = new ArrayList<PGraphics>();
  public ArrayList<ArrayList<PImage>> imagesWF2 = new ArrayList<ArrayList<PImage>>();
  public ArrayList<ArrayList<PImage>> processedImages = new ArrayList<ArrayList<PImage>>();
  public ArrayList<PImage> thumbnails = new ArrayList<PImage>();
  public ArrayList<PImage> currentThumbnails = new ArrayList<PImage>();
  public ArrayList<PImage> nextThumbnails = new ArrayList<PImage>();
  public ArrayList<PImage> previousThumbnails = new ArrayList<PImage>();
  public ArrayList<SliderBox> sliderBoxes = new ArrayList<SliderBox>();
  public ArrayList<String> names = new ArrayList<String>();
  public fileInput input;
  public fileOutput output, outputWF;
  public tab info, sliders;
  public accordionTab workFlow, workFlow1, workFlow2;
  public PGraphics canvas, camera, c1, c2, c3, pass1, pass2, pass3, pass4;
  public PShader mean, Sobel, Blur, GaussianS, Sobel1, Sobel2, SobelG, SobelG1, 
    SobelMax, SobelMax2, Canny, CannyTrim, CannyTrim1, variance, 
    gaussian, gaussian1, gaussian2, tempShader, sobel, canny, shader;
  public String imPath = "";
  //public String shaderPath = "shaders\\";
  public String shaderPath = "";
  //currentField;
  public String [] instructions;
  public Dock myDock;
  //ScreenShot screen;
  Webcam cam;
  //Movie myMovie;
  tab meanTab, varianceTab, sobelTab, cannyTab, gaussianTab, gaussian1Tab, gaussian2Tab, 
    blurTab, shaderSliders;
  String[] shaders = new String[] {"Blur", "Mean", "Variance", "Sobel", "Canny", "Gaussian", 
    "Gaussian 2", "Gaussian 3", "brcosa.glsl", "hue.glsl", "pixelate.glsl", "blur.glsl", 
    "channels.glsl", "threshold.glsl", "neon.glsl", "wrap.glsl", "deform.glsl", 
    "pixelrolls.glsl", "patches.glsl", "modcolor.glsl", "halftone.glsl", 
    "halftone_cmyk.glsl", "invert.glsl", "bilateral_filter.glsl"};
  PShader []Shaders;

  public imageProcessor(BMS bms) {
    Bms = bms;
    p = bms.applet;
    img = p.createImage(p.width, p.height, p.ARGB);

    //initCanvases();
    initMenus();
    //initHashMap();
  };

  public imageProcessor(String s) {
    img = p.loadImage(s);

    //initCanvases();
    initHashMap();
  };

  public imageProcessor(String s, BMS bms) {
    Bms = bms;
    p = bms.applet;
    img = p.loadImage(s);
    initCam();
  };

  public imageProcessor(PImage p) {
    img = new PImage(p.width, p.height, PConstants.ARGB);
    img.pixels = p.pixels;
    initHashMap();
  };

  public imageProcessor(PImage p1, BMS bms) {
    Bms = bms;
    p = bms.applet;
    img = new PImage(p1.width, p.height, PConstants.ARGB);
    img.pixels = p1.pixels;
    initHashMap();
    initCam();
  };

  public imageProcessor(int w, int h) {
    img = new PImage(w, h, PConstants.ARGB);
    initHashMap();
  };

  public imageProcessor(int w, int h, BMS bms) {
    Bms = bms;
    p = bms.applet;
    img = new PImage(w, h, PConstants.ARGB);
    initHashMap();
    initCam();
  };

  public void initCam() {
    //if(Bms.camera==null)Bms.createCamera();
    //cam = Bms.camera;
  };

  //  public imageProcessor() {
  //  };



  public void initCanny() {
  };

  public void initScreenShot() {
    //screen = new ScreenShot(Bms, p.displayWidth, p.displayHeight);
  };

  public void initScreenShot(int x, int y) {
    //screen = new ScreenShot(Bms, x, y);
  };

  public void initWebcam(int x, int y) {
    //cam = new Webcam(Bms);
  };

  public void loadShaders() {
    Blur = p.loadShader(shaderPath+"blur.glsl");
    println("blur shader", Blur);
    mean = p.loadShader(shaderPath+"mean.glsl");
    println("mean shader", mean);
    variance = p.loadShader(shaderPath+"variance.glsl");
    sobel = p.loadShader(shaderPath+"sobel1.glsl");
    Sobel1 = p.loadShader(shaderPath+"sobel1.glsl");
    Sobel2 = p.loadShader(shaderPath+"sobel2.glsl");
    SobelG = p.loadShader(shaderPath+"sobelG.glsl");
    SobelG1 = p.loadShader(shaderPath+"sobelG1.glsl");
    SobelMax = p.loadShader(shaderPath+"sobelMax.glsl");
    canny = p.loadShader(shaderPath+"input_sound.glsl");
    Canny = p.loadShader(shaderPath+"canny.glsl");
    //CannyTrim = p.loadShader(shaderPath+"cannyTrim.glsl");
    //CannyTrim1 = p.loadShader(shaderPath+"cannyTrim1.glsl");
    gaussian = p.loadShader(shaderPath+"gaussian.glsl");
    gaussian1 = p.loadShader(shaderPath+"gaussian1.glsl");
    gaussian2 = p.loadShader(shaderPath+"gaussian2.glsl");
    Shaders = new PShader[shaders.length];
    for (int i=8; i<shaders.length; i++) {
      String s1 = shaders[i];
      PShader s = p.loadShader(shaderPath+s1);
      Shaders[i-8] = s;
    }
  }

  public void initCanvases() {
    c1 = p.createGraphics(img.width, img.height);
    c2 = p.createGraphics(img.width, img.height);
    c3 = p.createGraphics(img.width, img.height);
    currentImage = p.createGraphics(img.width, img.height);
    pass1 = p.createGraphics(img.width, img.height);
    pass2 = p.createGraphics(img.width, img.height);
    pass3 = p.createGraphics(img.width, img.height);
    pass4 = p.createGraphics(img.width, img.height);

    c1.beginDraw();
    c1.image(img, 0, 0);
    c1.endDraw();
    c2.beginDraw();
    c2.image(img, 0, 0);
    c2.endDraw();
    c3.beginDraw();
    c3.image(img, 0, 0);
    c3.endDraw();
    pass1.beginDraw();
    pass1.image(img, 0, 0);
    pass1.endDraw();
    pass2.beginDraw();
    pass2.image(img, 0, 0);
    pass2.endDraw();
    pass3.beginDraw();
    pass3.image(img, 0, 0);
    pass3.endDraw();
    pass4.beginDraw();
    pass4.image(img, 0, 0);
    pass4.endDraw();
    //initHashMap();
    p.println("initcanvases");
  };

  public void initCanvasesP2D() {
    c1 = p.createGraphics(width, height, p.P2D);
    c2 = p.createGraphics(width, height, p.P2D);
    c3 = p.createGraphics(width, height, p.P2D);
    currentImage = p.createGraphics(width, height);
    //img = p.createGraphics(width, height);
    pass1 = p.createGraphics(width, height, p.P2D);
    pass2 = p.createGraphics(width, height, p.P2D);
    pass3 = p.createGraphics(width, height, p.P2D);
    pass4 = p.createGraphics(width, height, p.P2D);

    c1.beginDraw();
    c1.background(255);
    c1.image(img, 0, 0);
    c1.endDraw();
    c2.beginDraw();
    c2.image(c1, 0, 0);
    c2.endDraw();
    c3.beginDraw();
    c3.image(c1, 0, 0);
    c3.endDraw();
    //img = c3.get();
    pass1.beginDraw();
    pass1.image(c1, 0, 0);
    pass1.endDraw();
    pass2.beginDraw();
    pass2.image(c1, 0, 0);
    pass2.endDraw();
    pass3.beginDraw();
    pass3.image(c1, 0, 0);
    pass3.endDraw();
    pass4.beginDraw();
    pass4.image(c1, 0, 0);
    pass4.endDraw();
    cast();
    //initHashMap();
    p.println("initcanvases");
  };

  void initCanvases2() {
    c1 = p.createGraphics(width, height, p.P2D);
    c2 = p.createGraphics(width, height, p.P2D);
    c3 = p.createGraphics(width, height, p.P2D);
    currentImage = p.createGraphics(width, height);
    pass1 = p.createGraphics(width, height, p.P2D);
    pass2 = p.createGraphics(width, height, p.P2D);
    pass3 = p.createGraphics(width, height, p.P2D);
    pass4 = p.createGraphics(width, height, p.P2D);

    c1.beginDraw();
    c1.background(255);
    c1.image(img, 0, 0);
    c1.endDraw();
  };

  public void initMenus() {

    //menu = new Menu(p.width-250, 23, 100, 30, 0, menuLabels, Bms);

    info = new tab(0, p.height - 170, p.width, 150, "Images", Bms);
    sliders = new tab(p.width-100, 68, 100, p.height - 240, "Sliders", Bms);
    PGraphics pg = p.createGraphics(200, (int)sliders.h);
    sliders.canvases.add(pg);

    //    sliders.title.w -=20;
    Button b1 = new Button(80, 0, 20, 20, "<", Bms);
    b1.setclassicBar();
    sliders.add(b1);

    workFlow = new accordionTab(0, 68, 100, p.height - 240, b);

    tab t1 = new tab(0, 68, 200, p.height - 240, "Workflow", Bms);
    t1.title.h = workFlowDDHeight;
    TextArea m1 = new TextArea(0, 0, 100, t1.h - 60, Bms);
    run = new Menu(0, t1.h-60, 100, menuLabels2, Bms);
    clear = new Menu(50, t1.h-60, t1.w-run.w, menuLabels3, Bms);
    runAll = new Menu(0, t1.h-40, t1.w, menuLabels4, Bms);
    t1.add(m1);


    run.w = 50;
    run.items.get(0).w = 50;
    clear.w = 50;
    clear.items.get(0).w = 50;
    runAll.w = 100;
    runAll.items.get(0).w = 100;
    t1.add(m1);
    t1.add(run);
    t1.add(clear);
    t1.add(runAll);
    input = new fileInput(Bms);
    output = new fileOutput(Bms);
    info.toggle = true;
    sliders.toggle = true;
    t1.toggle = true;
    info.draggable = true;
    info.scrollable = true;
    t1.draggable = true;
    sliders.draggable = true;
    sliders.scrollable = true;
    canvas = p.createGraphics(p.width-200, p.height - 190);

    workFlow1 = new accordionTab(0, 68, 100, p.height - 240, b);

    tab t2 = new tab(0, 68, 120, p.height - 240, "Workflow1", Bms);
    t2.title.h = workFlowDDHeight;
    String[] tabstates = {"Mean", "Variance", "Sobel", "Canny", "Gaussian", 
      "Gaussian 2", "Gaussian 3", "Brcosa", "Hue", "Pixelate", "Blur1", "Channels", 
      "Threshold", "Neon", "Wrap", "Deform", "PixelRolls", "Patches", "ModColor", 
      "Halftone", "Halftone cmyk", "Inverson", "Bilateral"};
    //t2.parentDock = myDock;
    workFlowDD = new Dropdown(0, 0, 100, workFlowDDHeight, 0, "Function", ddLabels, Bms);
    //workFlow.add(1,workFlowDD);
    t2.draggable = true;
    t2.add(workFlowDD);

    t2.toggle = true;
    Button b2 = new Button(t2.w-80, 40, 40, 40, "-", Bms);
    b2.setclassicBar();
    t2.add(b2);
    Button b3 = new Button(t2.w-40, 40, 40, 40, "+", Bms);
    b3.setclassicBar();
    t2.add(b3);
    Bms.dock.add(t1);
    Bms.dock.add(t2);
    workFlow.add(t1);
    workFlow1.add(t2);
    workFlow.toggle = true;
    workFlow1.toggle = true;
    println("init img", Bms, t1, Bms.dock);

    //blur
    shaderSliders = new tab(0, 90, 200, 300, "Blur", Bms);

    shaderSliders.addStates(tabstates);
    //shaderSliders.toggle = true;
    //shaderSliders.draggable = true;
    //blur 0
    String[] sl1Labels = {"mult", "range"};
    SliderBox sl1 = new SliderBox(40, 20, 90, 20, 10, sl1Labels, Bms);
    //sl1.setPieSquare();
    sl1.setClassicBar();
    shaderSliders.add(0, sl1);
    //mean 1
    String[] sl2Labels = {"mult", "range", "type", "min"};
    SliderBox sl2 = new SliderBox(40, 20, 90, 20, 10, sl2Labels, Bms);
    //sl1.setPieSquare();
    sl2.setClassicBar();
    shaderSliders.add(1, sl2);
    // variance 2
    String[] sl3Labels = {"mult", "range", "type", "mult", "range", "type", "mr", "mg", "mb", "ma"};
    SliderBox sl3 = new SliderBox(40, 20, 90, 20, 10, sl3Labels, Bms);
    //sl1.setPieSquare();
    sl3.setClassicBar();
    shaderSliders.add(2, sl3);
    //sobel1 3
    String[] sl4Labels = {"mult", "intensity", "min", "Type"};
    SliderBox sl4 = new SliderBox(40, 20, 90, 20, 10, sl4Labels, Bms);
    //sl1.setPieSquare();
    sl4.setClassicBar();
    shaderSliders.add(3, sl4);
    //sobel2
    //String[] sl5Labels = {"mult", "intensity", "min","Type"};
    //SliderBox sl5 = new SliderBox(40, 20, 90, 20, 10, sl5Labels,Bms);
    ////sl1.setPieSquare();
    //sl5.setClassicBar();
    //shaderSliders.add(4,sl5);
    ////sobel3
    //String[] sl6Labels = {"mult", "intensity", "min","Type"};
    //SliderBox sl6 = new SliderBox(40, 20, 90, 20, 10, sl6Labels,Bms);
    ////sl1.setPieSquare();
    //sl6.setClassicBar();
    //shaderSliders.add(5,sl6);
    //canny 4
    String[] sl7Labels = {"mult", "intensity", "type", "Blur S", "Sigma", "Size"};
    SliderBox sl7 = new SliderBox(40, 20, 90, 20, 10, sl7Labels, Bms);
    //sl1.setPieSquare();
    sl7.setClassicBar();
    shaderSliders.add(4, sl7);
    //gaussian1 5
    String[] sl8Labels = {"Range", "Sigma", "Size"};
    SliderBox sl8 = new SliderBox(40, 20, 90, 20, 10, sl8Labels, Bms);
    //sl1.setPieSquare();
    sl8.setClassicBar();
    shaderSliders.add(5, sl8);
    //gaussian2 6
    String[] sl9Labels = {"Range", "Sigma", "Size"};
    SliderBox sl9 = new SliderBox(40, 20, 90, 20, 10, sl9Labels, Bms);
    //sl1.setPieSquare();
    sl9.setClassicBar();
    shaderSliders.add(6, sl9);
    //gaussian3 7
    String[] sl10Labels = {"Range", "Sigma", "Size"};
    SliderBox sl10 = new SliderBox(40, 20, 90, 20, 10, sl10Labels, Bms);
    //sl1.setPieSquare();
    sl10.setClassicBar();
    shaderSliders.add(7, sl10);
    //brcosa 8
    String[] sl11Labels = {"Brightness", "Contrast", "Saturation"};
    SliderBox sl11 = new SliderBox(40, 20, 90, 20, 10, sl11Labels, Bms);
    //sl1.setPieSquare();
    sl11.setClassicBar();
    shaderSliders.add(8, sl11);
    //hue 9
    String[] sl12Labels = {"Hue"};
    SliderBox sl12 = new SliderBox(40, 20, 90, 20, 10, sl12Labels, Bms);
    //sl1.setPieSquare();
    sl12.setClassicBar();
    shaderSliders.add(9, sl12);
    //pixeLate 10
    String[] sl13Labels = {"xPixels", "yPixels"};
    SliderBox sl13 = new SliderBox(40, 20, 90, 20, 10, sl13Labels, Bms);
    //sl1.setPieSquare();
    sl13.setClassicBar();
    shaderSliders.add(10, sl13);
    //blur 11
    String[] sl14Labels = {"Sigma", "Blur Size", "Tex Offset"};
    SliderBox sl14 = new SliderBox(40, 20, 90, 20, 10, sl14Labels, Bms);
    //sl1.setPieSquare();
    sl14.setClassicBar();
    shaderSliders.add(11, sl14);
    //channels 12
    String[] sl15Labels = {"RBias", "GBias", "BBias", "RMult", "GMult", "BMult"};
    SliderBox sl15 = new SliderBox(40, 20, 90, 20, 10, sl15Labels, Bms);
    //sl1.setPieSquare();
    sl15.setClassicBar();
    shaderSliders.add(12, sl15);
    //threshold 13
    String[] sl16Labels = {"Threshold"};
    SliderBox sl16 = new SliderBox(40, 20, 90, 20, 10, sl16Labels, Bms);
    //sl1.setPieSquare();
    sl16.setClassicBar();
    shaderSliders.add(13, sl16);
    //neon 14
    String[] sl17Labels = {"Brt", "Rad"};
    SliderBox sl17 = new SliderBox(40, 20, 90, 20, 10, sl17Labels, Bms);
    //sl1.setPieSquare();
    sl17.setClassicBar();
    shaderSliders.add(14, sl17);
    //wrap 15
    String[] sl18Labels = {"Radius", "Twist"};
    SliderBox sl18 = new SliderBox(40, 20, 90, 20, 10, sl18Labels, Bms);
    //sl1.setPieSquare();
    sl18.setClassicBar();
    shaderSliders.add(15, sl18);
    //deform 16
    String[] sl19Labels = {"mult", "M1x", "M1y", "Turns"};
    SliderBox sl19 = new SliderBox(40, 20, 90, 20, 10, sl19Labels, Bms);
    //sl1.setPieSquare();
    sl19.setClassicBar();
    shaderSliders.add(16, sl19);
    //pixelrolls 17
    String[] sl20Labels = {"Sigma", "Pixels", "Roll Rate", "Roll Amounts"};
    SliderBox sl20 = new SliderBox(40, 20, 90, 20, 10, sl20Labels, Bms);
    //sl1.setPieSquare();
    sl20.setClassicBar();
    shaderSliders.add(17, sl20);
    //patches 18
    String[] sl21Labels = {"Row", "Col"};
    SliderBox sl21 = new SliderBox(40, 20, 90, 20, 10, sl21Labels, Bms);
    //sl1.setPieSquare();
    sl21.setClassicBar();
    shaderSliders.add(18, sl21);
    //modColor 19
    String[] sl22Labels = {"mult", "intensity", "min", "Type"};
    SliderBox sl22 = new SliderBox(40, 20, 90, 20, 10, sl22Labels, Bms);
    //sl1.setPieSquare();
    sl22.setClassicBar();
    shaderSliders.add(19, sl22);
    //halftone 20
    String[] sl23Labels = {"pixelsPerRow"};
    SliderBox sl23 = new SliderBox(40, 20, 90, 20, 10, sl23Labels, Bms);
    //sl1.setPieSquare();
    sl23.setClassicBar();
    shaderSliders.add(20, sl23);
    //halftone cmyk 21
    String[] sl24Labels = {"Density", "Frequency"};
    SliderBox sl24 = new SliderBox(40, 20, 90, 20, 10, sl24Labels, Bms);
    //sl1.setPieSquare();
    sl24.setClassicBar();
    shaderSliders.add(21, sl24);
    //bilateral 23
    String[] sl25Labels = {"Resolution", "Sigma"};
    SliderBox sl25 = new SliderBox(40, 20, 90, 20, 10, sl25Labels, Bms);
    //sl1.setPieSquare();
    sl25.setClassicBar();
    shaderSliders.add(23, sl25);
    //shaderSliders.draggable = true;
    for (int i=0; i<shaderSliders.tabs.size(); i++) {
      tab t = shaderSliders.tabs.get(i);
      //t.draggable = true;
    }
    for (int i=0; i<shaderSliders.states.size(); i++) {
      tab t = shaderSliders.states.get(i);
      t.title.h = workFlowDDHeight;
      //t.draggable = true;
    }

    Button b6 = new Button(0, workFlow1.h-80, workFlow1.w, 30, "Run Workflow", Bms);
    b6.setClassicBar();
    t2.add(b6);
    Button b7 = new Button(0, b6.y+b6.h, workFlow1.w, 30, "Clear", Bms);
    b7.setClassicBar();
    t2.add(b7);
    //Bms.dock.add(shaderSliders);
    //Bms.add(shaderSliders);
    workFlow.toggle = false;
    workFlow1.toggle = false;
    Bms.add(workFlow);
    Bms.add(workFlow1);
    println(shaderSliders);
    initHashMap();
    initDock1();
    initFiles();
    //b.add(
  };

  public void initDock1() {
    //myDock.add(info);
    //myDock.add(sliders);
    //myDock.add(workFlow);
    //myDock.add(workFlow1);
  };

  public void initFiles() {
    imPath = p.dataPath("images");
    //shaderPath = p.dataPath("shaders");
  };

  public void initHashMap() {
    workFlowSliders.put("Blur", blurSliderLabels);
    workFlowSliders.put("BlurS", blurSSliderLabels);
    workFlowSliders.put("Gaussian 3", gaussian3SliderLabels);
    workFlowSliders.put("Gaussian 5", gaussian5SliderLabels);
    workFlowSliders.put("GaussianS", gaussianSSliderLabels);
    workFlowSliders.put("Mean", meanSliderLabels);
    workFlowSliders.put("MeanS", meanSSliderLabels);
    workFlowSliders.put("Sobel", sobelSliderLabels);
    workFlowSliders.put("SobelGS", sobelGSSliderLabels);
    workFlowSliders.put("SobelS", sobelSSliderLabels);
    workFlowSliders.put("SobelS2", sobelSSliderLabels);
    workFlowSliders.put("SobelS3", sobelSSliderLabels);
    workFlowSliders.put("Sobel 2", sobel2SliderLabels);
    workFlowSliders.put("Sobel Max", sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max2", sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max3", sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max4", sobelMaxSliderLabels);
    workFlowSliders.put("Canny", cannySliderLabels);
    workFlowSliders.put("CannyTrim", cannyTSliderLabels);
    workFlowSliders.put("CannyTrim1", cannyT1SliderLabels);
    workFlowSliders.put("Combine", combineSliderLabels);
    workFlowSliders.put("Substract", substractSliderLabels);
    workFlowSliders.put("Blend", blendSliderLabels);
    workFlowSliders.put("Variance", varianceSliderLabels);
    workFlowSliders.put("Variance2", variance2SliderLabels);
    workFlowSliders.put("Variance3", variance3SliderLabels);
    println(shaderSliders);
    for (int i=0; i<shaderSliders.states.size(); i++) {
      String s = shaderSliders.states.get(i).title.label;
      shaderHashMap.put(s.toLowerCase(), i);
      println(s.toLowerCase(), i);
    }

    for (int i=8; i<shaderSliders.states.size(); i++) {
      String s = shaderSliders.states.get(i).title.label;
      textureHashMap.put(s.toLowerCase(), i);
    }
  };

  Object parseParameter(String parameter) {
    try {
      return Integer.parseInt(parameter);
    } 
    catch(NumberFormatException e) {
      try {
        return Float.parseFloat(parameter);
      } 
      catch(NumberFormatException e1) {
        try {
          Field field = this.getClass().getField(parameter);
          return field.get(this);
        } 
        catch (NoSuchFieldException e2) {
          return null;
        }
        catch(IllegalAccessException e2) {
          throw new RuntimeException(e2);
        }
      }
    }
  };

  Class<?> getParameterClass(String parameter) {
    try {
      Integer.parseInt(parameter);
      return int.class;
    } 
    catch(NumberFormatException e) {
      try {
        Float.parseFloat(parameter);
        return float.class;
      } 
      catch(NumberFormatException e1) {

        if (parameter!=null)return PImage.class;
        else return null;
      }
    }
  };

  public void loadInput() {
    if (location!=null) {
      String loc = "";
      if (file!=null||folder!=null) {
        if (file!=null)loc = file;
        else loc = folder;
      }
      load = false;
      location = null;
    }
  };

  public PGraphics display() {

    if (toggle) {
      displayMenus();
      if (mousePressed) {
        fx = mouseX;
        fy = mouseY;
      }

      if (load) {
        fx = 0;
        fy = 0;
      }
      if (!shaderSliders.posTab()&&!t1.posTab()&&!Bms.dock.pos()&&!Bms.file.toggle
        &&img!=null) {
        imgx = (int)map(fx-width/2, 0, width, 0, img.width);
        imgy = (int)map(fy-height/2, 0, height, 0, img.height);
      }
      if (save) {
        //iout.img = c1.get();
        //iout.logic();

        println("img save");
        save = false;
      }
      if (load||function!=5)Bms.camera = null;
      //if(!load)iin.img = null;
      if (load) {

        //iin.getItem();
        //load = false;
        //c1.clear();
        //t1.dmenus.get(0).index = -1;
        //t1.dmenus.get(0).reset();
        //t1.dmenus.get(0).index = 1;
        //t1.dmenus.get(0).label = "Image";
      }
      if (iin.img!=null) {
        //set(iin.img);
        //reset();
        //iin.img = null;
        //function = 1;
        //load = false;
        println("img load");
      }
      //      sliders.toggleU(0,this,"updateSliders");
      if (!docked) {
        // sliders
        // Bms.dock
        docked = true;
      }
      
      if (reset)reset();
      if (function>-1) {
        if (function>-1&&function!=5&&cam!=null)cam.cam.stop();
        if (function==1)preloaded();
        if (function==2)loadFolder();
        if (function==3)getScreenShot();
        if (function==4)loadImage();
        if (function==5&&!load)getCam();
        if (function==6)loadVideo();
        if (function==7)state = true;
      }
      if (workFlow1.toggle&&!reset) {
        if (runWorkFlow&&!workFlowRunning) {
          workflowFirstRun = true;
          workFlowRunning = true;
          println("img disp,00");

          c3.clear();
        } else workflowFirstRun = false;
        workFlowLogic();
      }
      
      
      
      if (shaderId>-1&&!workFlow1.toggle) {
        ////if(img!=null){
        //if (shaderId==-1)c1 = simple();
        //if (shaderId==0)c1 = blur();
        //if (shaderId==1)c1 = mean();
        //if (shaderId==2)c1 = variance();
        //if (shaderId==3)c1 = sobel();
        //if (shaderId==4)c1 = canny();
        //}
      }
      //if (textureId>-1) {
      //  applyShader = false;
      //  applyTexture = true;
      //  shaderId = -1;
      //  drawTextures();
      //}
    }
    if (Bms.fmenu!=null&&Bms.fmenu.getClose()) {
      function = -1;
    }

    //image(c1,0,0);
    save = false;
    return c1;
  };

  public void displayMenus() {
    if (shaderId>-1) {
      shaderSliders.state = shaderId;
    }
    if (textureId>-1) {
      shaderSliders.state = textureId+8;
    }
  };

  public void displayCanvas() {
    if (!p.mousePressed)mdown = false;

    if (currentImage!=null&&canvas!=null) {
      if (iUpdate) {
        canvas.beginDraw();
        canvas.background(50);
        canvas.image(currentImage, 0, 0);
        canvas.endDraw();

        iUpdate = false;
      }
      if (iUpdate2&&names.size()>0) {
        if ((firstImageIndex + currentImageIndex-3)<names.size()&&(firstImageIndex + currentImageIndex-3)>0)
          currentImage = p.loadImage(names.get(firstImageIndex + currentImageIndex-3));
        canvas.beginDraw();
        canvas.background(50);
        canvas.image(currentImage, 0, 0);
        canvas.endDraw();
        iUpdate2 = false;
      }
    }

    if (iUpdate4&&imagesWF.size()>0) {
      currentImage = imagesWF.get(imagesWF.size()-1);
      canvas.beginDraw();
      canvas.background(50);
      canvas.image(currentImage, 0, 0);
      canvas.endDraw();
      iUpdate4 = false;
    } else if (iUpdate4&&imagesWF.size()==0) {
      PApplet.println("Workflow error...");
      iUpdate4 = false;
    }
    p.image(canvas, workFlow.w, 21);
  };

  public void slidersTabLogic() {
    int a = 200;
    int b = 100;
    int c = 40;
    //    if(sliders.click(0))slidersState++;
    //    if(slidersState==2)slidersState = 0;
    //    sliders.toggleU(0,this,"slidersState");
    boolean k = false;
    if (sliders.toggle(0, this, "slidersState")) {
      if (!slidersState)slidersState = true;
      else slidersState = false;
      updateSliders = true;
    }

    if (slidersState&&updateSliders) {
      //      p.println("img sliderstabl 00");
      sliders.canvasIndex = 1;

      //      sliders.title.w = a-20;
      sliders.title.w = a;

      sliders.setPos(p.width -a, sliders.y);
      sliders.title.setPos(sliders.x, sliders.y);
      sliders.w = a;
      sliders.buttons.get(0).x = sliders.w-20;
      //      sliders.sliderh.w = a;
      sliders.sliderv.x = sliders.w-10;
      //      for(int i=0;i<sliders.sliderBoxes.size();i++){
      //        SliderBox s = sliders.sliderBoxes.get(i);
      //        if(s!=null)s.menu.x = c;
      //      }
      //
      //      for(int i=1;i<sliders.buttons.size();i++){
      //        if(sliders.buttons.size()>1){
      //          Button b1 = sliders.buttons.get(i);
      //          b1.x = c;
      //        }}
    } else if (!slidersState&&updateSliders) {
      //      p.println("img sliderstabl 01");
      sliders.canvasIndex = 0;
      sliders.setPos(p.width -b, sliders.y);
      sliders.title.w = b;
      sliders.title.setPos(p.width -b, sliders.y);
      sliders.w = b;
      sliders.buttons.get(0).x = sliders.w-20;
      sliders.sliderh.w = b;
      sliders.sliderv.x = sliders.w-10;

      //      for(int i=0;i<sliders.sliderBoxes.size();i++){
      //        SliderBox s = sliders.sliderBoxes.get(i);
      //        if(s!=null){
      //          s.menu.x = 0;
      //
      //        }
      //      }
      //      for(int i=1;i<sliders.buttons.size();i++){
      //        Button b1 = sliders.buttons.get(i);
      //        b1.x = 0;
      //      }
    }

    for (int i=0; i<sliders.sliderBoxes.size(); i++) {
      SliderBox s = sliders.sliderBoxes.get(i);
      if (s!=null) {
        for (int j=0; j<s.menu.sliders.size(); j++) {
          Slider s1 = s.menu.sliders.get(j);
          if (s1.label=="Mult")s1.set(1, 50);
          if (s1.label=="Range")s1.setint(1, 10);
          if (s1.label=="Thresh")s1.set(1, 255);
          if (s1.label=="Type")s1.setint(1, 10);
        }
      }
    }
    if (updateSliders)updateSliders = false;
    if (!p.mousePressed)mdown1 = false;
  };

  public void infoTabLogic() {
    if (thumbnails.size()>0)info.sliderh.setint(0, thumbnails.size(), this, "firstImageIndex");
    if (!p.mousePressed&&info.posTab()) {
      currentImageIndex = PApplet.floor(PApplet.map(p.mouseX, 0, info.w, 0, 7));
    } else if (info.posTab()&&!info.sliderh.mdown)iUpdate2 = true;

    if (info.sliderh.mdown&&p.mousePressed&&info.posTab()&&!iUpdate&&p.mouseX!=p.pmouseX) {
      iUpdate = true;
      mdown = true;
    }

    if (names!=null&&names.size()>0&&iUpdate) {

      for (int i=firstImageIndex-4; i<firstImageIndex+5; i++) {
        if (i>0&&i<thumbnails.size()) {
          PImage p1 = thumbnails.get(i);

          if (!info.images.contains(p1)) {
            info.images.add(p1);
          }
          if (info.images.size()>9)info.images.remove(0);
        }
      }
    }
  };

  public void workFlowLogic() {
    Dropdown d1 = null;
    //if (!state)
    d1 = workFlow1.tabs.get(0).dmenus.get(workFlow1.tabs.get(0).dmenus.size()-1);

    if (d1!=null) {
      //println("kkkkk",d1);
      Button bb = workFlow1.tabs.get(0).getButton(0);
      Button bb1 = workFlow1.tabs.get(0).getButton(1);
      workFlow1.tabs.get(0).toggle(2, this, "runWorkFlow");
      if (runWorkFlow)workflowD(workFlow1);

      if (workFlow1.tabs.get(0).toggle(1)&&d1.index>-1) {

        int n = shaderHashMap.get(d1.label.toLowerCase());
        println("shadeeeer", d1.label, d1.index);
        tab t1 = shaderSliders.states.get(d1.index);
        SliderBox sl1 = t1.sliderBoxes.get(0);
        tab t = new tab(0, t1.title.h*(workFlow1.tabs.size()+1), t1.w, sl1.h+40, t1.title.label, Bms);
        t.title.h = workFlowDDHeight;
        //t.setPos(t.x,t.y+(workFlowDDHeight-20));

        String []labels = new String[sl1.sliders.size()];
        for (int i=0; i<sl1.sliders.size(); i++) {
          Slider s = sl1.sliders.get(i);
          labels[i] = s.label;
        }
        SliderBox sl2 = new SliderBox(sl1.x, sl1.y-10, sl1.w, 20, 10, labels, Bms);
        sl2.setClassicBar();
        sl2.setDrag(false);
        t.add(sl2);
        workFlow1.add(t);

        workFlow1.tabs.get(0).add(new Dropdown(
          0, workFlow1.tabs.get(0).dmenus.size()*workFlowDDHeight, 100, workFlowDDHeight, 0, 
          "Function " + workFlow1.tabs.get(0).dmenus.size(), 
          ddLabels, Bms));

        bb.setPos(bb.x, bb.y+workFlowDDHeight);
        bb1.setPos(bb1.x, bb1.y+workFlowDDHeight);
      }
      if (workFlow1.tabs.get(0).toggle(0)&&workFlow1.tabs.get(0).dmenus.size()>1) {
        if (workFlow1.tabs.get(0).dmenus.size()>=1) {
          workFlow1.tabs.get(0).dmenus.remove(workFlow1.tabs.get(0).dmenus.size()-1);
          workFlow1.tabs.remove(workFlow1.tabs.size()-1);
        }
        bb.y-=workFlowDDHeight;
        bb1.y-=workFlowDDHeight;
      }
    }

    if (workFlow1.tabs.get(0).visible&&
      workFlow1.tabs.get(0).toggle(3, imgp, "clearWorkFlow")) {
      runWorkFlow = false;
      println("workflow clear");
      for (int i=workFlow1.tabs.get(0).dmenus.size()-1; i>0; i--) {
        workFlow1.tabs.get(0).dmenus.remove(i);
      }
      for (int i=workFlow1.tabs.size()-1; i>0; i--) {
        workFlow1.tabs.remove(i);
      }
      workFlow1.tabs.get(0).dmenus.get(0).reset();
      workFlow1.tabs.get(0).getButton(2).toggle = false;
      workFlow1.tabs.get(0).getButton(3).toggle = false;
    }

    //if(info.sliderh.mdown)iUpdate2 = true;

    // if(workFlow1.menus.items.get(0).click(workflow.getMouse())){

    // }
  };

  public void workFlowLogic1() {
    //if()
  };

  public void runWorkFlow() {
    if (run.toggle(0)&&!state) {
      PApplet.println("workflow 0");
      imagesWF = new ArrayList<PImage>();
      img = currentImage;

      if (workFlow.tabs.get(0).textareas.get(0).tempLine!=null) {

        PApplet.println("Run", workFlow.tabs.get(0).textareas.get(0).textArea);
        String[] s = PApplet.splitTokens(workFlow.tabs.get(0).textareas.get(0).tempLine, ",");
        String[] s1 = new String[1];
        currentWorkFlow = s1;
        s1[0] = workFlow.tabs.get(0).textareas.get(0).textArea[0];
        iUpdate3 = true;
        workflow(s1);
        //p.println(s1);
      } else PApplet.println(false);
    }

    if (clear.toggle(0)) {
      currentWorkFlow = null;
      workFlow.tabs.get(0).textareas.get(0).reset();
    }
  };

  public void runWorkFlow1() {
    if (run.toggle(0)&&state) {
      imagesWF = new ArrayList<PImage>();
      img = currentImage;

      if (sliders.sliderBoxes.size()>0) {
        String log = "Run state1";

        String []wf = new String[sliders.sliderBoxes.size()] ;
        PApplet.println("Run state1", workFlow.tabs.get(0).textareas.get(0).getValue());
        for (int i=0; i<sliders.sliderBoxes.size(); i++) {
          String s = workFlow1.tabs.get(0).dmenus.get(i).label + "(";
          SliderBox sl = null;
          if (sliders.sliderBoxes.get(i)!=null)
            sl = sliders.sliderBoxes.get(i);
          for (int j=0; j<sl.menu.sliders.size(); j++) {
            Slider slider = sl.menu.sliders.get(j);

            float v1 = -1;
            int v2 = -1;

            if (slider.label=="Mult"||slider.label=="Thresh") {
              if (j<sl.menu.sliders.size()-1)s += slider.value + ",";
              else s += slider.value ;
            } else {
              if (j<sl.menu.sliders.size()-1)s += (int)slider.value + ",";
              else s += (int)slider.value ;
            }
          }
          s += ")";
          if (s!=null)wf[i] = s;
        }
        PApplet.println(wf);
        workflow(wf);
      } else PApplet.println("No workflow available");
    }

    if (clear.toggle(0)&&state) {
      currentWorkFlow = null;

      while (sliders.buttons.size()>1)sliders.buttons.remove(sliders.buttons.size()-1);
      while (sliders.sliderBoxes.size()>0)sliders.buttons.remove(sliders.sliderBoxes.size()-1);
    }
    // if(runAll.toggle(0)){

    //   for(int i=0;i<names.size();i++){

    //   }
    // }
  };

  public PGraphics applyShader(PShader s, HashMap h) {
    if (applyShader) {
      canvas.beginDraw();
      canvas.shader(s);
      p.image(img, 0, 0);
      canvas.endDraw();
    }
    return canvas;
  };

  public void loadImages() {
    //input.listen();
    if (input.imageFiles!=null&&load) {
      PApplet.println("input", input.imageFiles.size());
      //currentFolder = input.names;
      ////names = new String[input.values.length];
      //if (images.size()<input.Files.size())
      //  for (int i=0; i<input.Files.size(); i++) {
      //    String s1 = input.Files.get(i);
      //    if(input.isImage(s1)) { 

      //      PImage thumbnail = p.loadImage(s1);

      //      thumbnail.resize(150, 90);
      //      thumbnails.add(thumbnail);
      //      names.add(s1);
      //    }
      //  }
      if (names.size()>0) {
        PApplet.println("step 1", "first index:", firstImageIndex);
        info.sliderh.valuex = 0;
        info.sliderh.value = 0;
        if (firstImageIndex<0)firstImageIndex=0;
        currentImage = p.loadImage(names.get(firstImageIndex));
        iUpdate = true;
      } else {
        PApplet.println("No images found...");
        names = new ArrayList<String>();
      }
      input.imageFiles = null;
    }
  };

  public void loadFolder() {
    if (saveMenu.toggle(1)) {
      Bms.File.folder = true;
      Bms.Folder.getFolder();
    }
  };

  public void loadImage() {
    //if(saveMenu.toggle(0))Bms.File.openImageExplorer();
    if (Bms.File.img!=null)img = Bms.File.img;
  };

  public void loadVideo() {
    //Window f = Bms.fmenu;
    //if (videoLocation==null) {
    //  Bms.File.video = true;
    //  if (f.currentf!=null&&f.select.toggle(0)) {
    //    videoLocation = f.currentf;
    //    if (myMovie==null) {
    //      myMovie = new Movie(p, videoLocation);
    //    } else {
    //      myMovie.play();
    //      img = myMovie;
    //    }
    //  }
    //} else {
    //  if (myMovie==null)myMovie = new Movie(p, videoLocation);
    //  else {
    //    myMovie.play();
    //    img = myMovie;
    //  }
    //}
  };

  public void preloaded() {
  };

  public void loadVideo(String s) {
    //myMovie = new Movie(p, s);
    //myMovie.play();
    //if (Bms.fmenu.getClose()) {
    //  //      p.println("imgp vid close");
    //  function = -1;
    //}
  };


  public void loadSound() {
    //Bms.File.listen();
    if (Bms.fmenu.getClose())function = -1;
  };

  public void getScreenShot() {
    //if (screen == null) {
    //  initScreenShot();
    //  p.println("get screen");
    //  //screen = new ScreenShot();
    //} else {
    //  img = screen.getScreenshot();
    //}
  };

  public void getScreenShot(int w, int h) {
    //if (function==2)
    //  if (screen == null)screen = new ScreenShot(Bms, w, h);
    //  else {
    //    img = screen.getScreenshot();
    //  }
  };

  public void getCam() {
    if (cam == null) {

      cam = new Webcam(Bms);
      p.println("getcam", cam);
      cam.cam.start();
      //println("imgp start cam");
    } else {
      cam.read();
      //cam.display(c1);
      img = cam.getCam();
      //c1 = 
      c1.beginDraw();
      c1.image(img,0,0);
      c1.endDraw();
      c3 = c1;
      if (p.mousePressed)p.println("imgp read cam");
    }
  };


  public PGraphics drawTextures() {
    tab t = null;
    if (currentShader>-1) {
      if (textureId>-1) {
        t = workFlow1.tabs.get(currentShader);
      }

      // brcosa

      PShader shader = Shaders[textureId];
      //println(shader);
      if (textureId == 0) {
        t.set(0, 0, 0, 1);
        t.set(0, 1, -5, 5);
        t.set(0, 2, -5, 5);
        shader.set("brightness", 1.0);
        shader.set("contrast", map(mouseX, 0, width, -5, 5));
        shader.set("saturation", map(mouseY, 0, height, -5, 5));
      } 

      // hue
      else if (textureId == 1) {
        t.set(0, 0, 0, TWO_PI);

        shader.set("hue", t.getSlider(0, 0).value);
      } 

      // pixelate
      else if (textureId == 2) {
        t.set(0, 0, 0, p.width*4);
        t.set(0, 1, 0, p.height*4);
        //println("texture",shader,);
        shader.set("pixels", t.getSlider(0, 0).value*0.1, t.getSlider(0, 1).value*0.1);
      }

      // blur
      else if (textureId == 3) {
        t.set(0, 0, 0, 10.0);
        t.set(0, 1, 0, 30.0);
        t.set(0, 2, 0, 1.0);
        shader.set("sigma", t.getSlider(0, 0).value);
        shader.set("blurSize", (int) t.getSlider(0, 1).value);
        shader.set("texOffset", t.getSlider(0, 2).value, 1.0);
      }
      // channels
      if (textureId==4) {

        t.set(0, 0, -0.2, 0.2);
        t.set(0, 1, -0.2, 0.2);
        t.set(0, 2, -0.2, 0.2);
        t.set(0, 3, 0.8, 1.5);
        t.set(0, 4, 0.8, 1.5);
        t.set(0, 5, 0.8, 1.5);

        shader.set("rbias", t.getSlider(0, 0).value, 0.1);
        shader.set("gbias", t.getSlider(0, 1).value, 0.0);
        shader.set("bbias", t.getSlider(0, 2).value, 0.0);
        shader.set("rmult", t.getSlider(0, 3).value, 1.0);
        shader.set("gmult", t.getSlider(0, 4).value, 1.0);
        shader.set("bmult", t.getSlider(0, 5).value, 1.0);
      }
      // threshold
      else if (textureId == 5) {
        t.set(0, 0, -1, 1);
        shader.set("threshold", t.getSlider(0, 0).value);
      } 

      // neon
      else if (textureId == 6) {
        t.set(0, 0, 0, 0.5);
        t.set(0, 1, 0, 3);
        shader.set("brt", t.getSlider(0, 0).value);
        shader.set("rad", (int) t.getSlider(0, 1).value);
      } 

      // wrap
      else if (textureId == 7) {
        t.set(0, 0, 0, 2);
        t.set(0, 1, 1.0, 10.0);
        shader.set("radius", t.getSlider(0, 0).value);
        shader.set("radTwist", t.getSlider(0, 1).value);
      }

      // deform
      else if (textureId == 8) {
        t.set(0, 0, -0.2, 0.2);
        t.set(0, 1, 0, width);
        t.set(0, 1, -0.2, 0.2);
        t.set(0, 3, 0.01, 1999);
        shader.set("time", t.getSlider(0, 0).value);
        shader.set("mouse", (float) t.getSlider(0, 1).value/width, 
          (float) t.getSlider(0, 2).value/height);
        shader.set("turns", map(sin(t.getSlider(0, 3).value), -1, 1, 2.0, 10.0));
      }

      // pixelRolls
      else if (textureId == 9) {

        t.set(0, 0, 0, 100);
        t.set(0, 1, 0, img.width);
        t.set(0, 2, 0, 10);
        t.set(0, 3, 0, 0.25);

        shader.set("time", (float) t.getSlider(0, 0).value);
        shader.set("pixels", t.getSlider(0, 1).value/5, 250.0);
        shader.set("rollRate", t.getSlider(0, 2).value);
        shader.set("rollAmount", t.getSlider(0, 3).value);
      }

      // patches
      else if (textureId == 10) {
        t.set(0, 0, 0, 1);
        t.set(0, 1, 0, 1);
        shader.set("row", t.getSlider(0, 0).value);
        shader.set("col", t.getSlider(0, 1).value);
      }

      // modcolor
      else if (textureId == 11) {
        t.set(0, 0, 0, 1);
        t.set(0, 1, 0, 1);
        t.set(0, 2, 0, 1);
        shader.set("modr", t.getSlider(0, 0).value);
        shader.set("modg", t.getSlider(0, 1).value);
        shader.set("modb", t.getSlider(0, 2).value);
      }

      // halftone
      else if (textureId == 12) {
        t.set(0, 0, 2, 100);
        shader.set("pixelsPerRow", (int) t.getSlider(0, 0).value);
      }

      // halftone cmyk
      else if (textureId == 13) {
        t.set(0, 0, 0, 1);
        t.set(0, 1, 0, 100);
        shader.set("density", t.getSlider(0, 0).value);
        shader.set("frequency", t.getSlider(0, 1).value);
      }

      // bilateral filter (no parameters)
      else if (textureId == 15) {
        t.set(0, 0, 0, 1);
        t.set(0, 1, 0, 1);
        shader.set("resolution", float(img.width), float(img.height));
        shader.set("sigma", 20*pow(t.getSlider(0, 1).value, 2));
      }
      //else if (textureId == 15) {
      //  t.set(0, 0, 0, 1);
      //  shader.set("resolution", float(width), float(height));
      //  shader.set("sigma", 20*pow(t.getSlider(0, 0).value, 2));
      //}
      c1.beginDraw();
      //c1.texture(c3);
      //c1.beginShape();
      c1.shader(shader);
      c1.image(c3, 0, 0);

      //c1.endShape();
      c1.endDraw();

      //c3.beginDraw();
      //c3.image(c1, 0, 0);
      //c3.endDraw();
      c3 = c1;
    }
    return c1;
  };

  //public void save() {
  //  if(saveMenu.toggle(2)){
  //    fileOutput output = Bms.output;
  //    output.img = c1.get();
  //    Bms.output.writeFile = true;
  //    if(function==0){
  //      output.saveImage = true;
  //      output.saveImage();
  //    }
  //    if(function==1);
  //    if(function==2);
  //  }
  //};

  public void workflow(String a) {
    String[] s = PApplet.splitTokens(a, "-");
    PApplet.println("workflow 0");
    for (int i=0; i<s.length; i++) {
      String s1 = s[i];

      //ArrayList<Integer> [] pIndex = strIndex(s1,"(",")");
      int [] pIndex = strIndex1(s1, "(", ")");
      String function = s1.substring(0, pIndex[0]);

      //String[]parameters = new String [pIndex[0].size()];
      String[]parameters = PApplet.splitTokens(s[i].substring(pIndex[0]+1, pIndex[1]), ",");
      parameters[parameters.length-1] =  parameters[parameters.length-1].substring(0, parameters.length-1);

      boolean image = false;
      Method method = null;
      try {
        method = this.getClass().getMethod(function, float.class, float.class);
        //imageProcessor instance = new imageProcessor();
        float result = (float) method.invoke(this, 1, 3);
        PApplet.println("result", result);
      } 
      catch (SecurityException e) {
        PApplet.println(function, "se");
      }
      catch (NoSuchMethodException e) {  
        PApplet.println(function, "nsm");
      }
      catch (IllegalAccessException e) {  
        PApplet.println(function, "nsm");
      }
      catch (InvocationTargetException e) {  
        PApplet.println(function, "nsm");
      }
      for (int j=0; j<parameters.length; j++) {

        float currentF = Float.parseFloat(parameters[j]);

        if (currentF>-10000000&&currentF<10000000) {
          PApplet.println(function, "f " + currentF);
        } else PApplet.println(function, "s " + parameters[j]);
      }
    }
  };

  public void workflow(String[] a) {
    if (!iUpdate3) {
      PApplet.println("something wrong..");
    }
    if (iUpdate3&&a!=null) {
      PApplet.println("workflow 0");
      String[] s = a;

      for (int i=0; i<s.length; i++) {
        String s1 = s[i];
        if (s[i].length()>0) {
          int [] pIndex = strIndex1(s1, "(", ")");
          String function = s1.substring(0, pIndex[0]);

          String[]parameters = PApplet.splitTokens(s[i].substring(pIndex[0]+1, pIndex[1]), ",");
          PApplet.print("Parameters", function +"(");
          String s2 = "";
          Class<?>[] parameterClasses = new Class<?>[parameters.length];
          Object[] parsedParameters = new Object[parameters.length];
          for (int j=0; j<parameters.length; j++) {
            //p.print(parameters[j]);

            parameterClasses[j] = getParameterClass(parameters[j]);
            parsedParameters[j] = parseParameter(parameters[j]);
            // s2+=parameterClasses[j]+" "+parameters[j];
            s2 += parameters[j];
            if (j<parameters.length-1)s2+=",";
          }
          PApplet.println(s2+")");

          update = true;
          try {
            Method method = this.getClass().getMethod(function, parameterClasses);
            method.invoke(this, parsedParameters);
            img = imagesWF.get(imagesWF.size()-1);
            workFlowLabels.add(function);
          } 
          catch (NoSuchMethodException e) {
            PApplet.println("nsm", function, parameterClasses[0]);
            e.printStackTrace();
          }
          catch(IllegalAccessException e) {
            PApplet.println("ia");
            e.printStackTrace();
          }
          catch( InvocationTargetException e) {
            PApplet.println("it...Check images");
            e.printStackTrace();
          }
        }
      }
      update = false;
    } else if (a==null) {
      iUpdate3 = false;
      PApplet.println("Please correct function...");
    }
  };

  public void workflow2(String[] a) {
    if (update&&a!=null) {
      String[] s = a;

      for (int i=0; i<s.length; i++) {
        String s1 = s[i];
        if (s[i].length()>0) {
          int [] pIndex = strIndex1(s1, "(", ")");
          String function = s1.substring(0, pIndex[0]);

          String[]parameters = PApplet.splitTokens(s[i].substring(pIndex[0]+1, pIndex[1]), ",");
          PApplet.print("p", function +"(");
          String s2 = "";
          Class<?>[] parameterClasses = new Class<?>[parameters.length];
          Object[] parsedParameters = new Object[parameters.length];
          for (int j=0; j<parameters.length; j++) {
            //p.print(parameters[j]);

            parameterClasses[j] = getParameterClass(parameters[j]);
            parsedParameters[j] = parseParameter(parameters[j]);
            // s2+=parameterClasses[j]+" "+parameters[j];
            s2 += parameters[j];
            if (j<parameters.length-1)s2+=",";
          }
          PApplet.println(s2+")");

          update = true;
          try {
            Method method = this.getClass().getMethod(function, parameterClasses);
            method.invoke(this, parsedParameters);
          } 
          catch (NoSuchMethodException e) {
            PApplet.println("nsm", function, "...Check Params?");
          }
          catch(IllegalAccessException e) {
            PApplet.println("ia") ;
          }
          catch( InvocationTargetException e) {
            PApplet.println("it", "This function is missing an image...");
            e.printStackTrace();
          }
        }
      }
      update = false;
    } else if (a==null)update = false;

    if (p.keyPressed&&p.key =='r')update = true;
  };

  public void workflowD(accordionTab a) {
    if (workFlowRunning&&a!=null) {
      for (int i=1; i<a.tabs.size(); i++) {
        //a.tabs.get(i).toggle = true;
        String s1 = a.tabs.get(i).title.label.toLowerCase();
        //p.println("workflowt loop 1",s1,i);
        c3.beginDraw();
        if (i==1)c3.clear();
        c3.image(c1, 0, 0);
        c3.fill(0);
        c3.ellipse(mouseX, mouseY, 100, 100);
        c3.endDraw();
        currentShader = i;
        if (s1!=null&&!s1.contains("Function"))
          if (workFlow1.tabs.get(0).dmenus.get(i-1).index<8) {

            try {
              Method method = this.getClass().getMethod(s1, null);
              method.invoke(this);
            } 
            catch (NoSuchMethodException e) {
              PApplet.println("nsm", function, s1);
              e.printStackTrace();
            }
            catch(IllegalAccessException e) {
              PApplet.println("ia");
              e.printStackTrace();
            }
            catch( InvocationTargetException e) {
              PApplet.println("it...Check images");
              e.printStackTrace();
            }
          } else if (a.tabs.size()>1) {
            c3.beginDraw();
            c3.image(c1, 0, 0);
            c3.endDraw();
            currentShader = i;
            textureId = textureHashMap.get(a.tabs.get(i).title.label.toLowerCase())-8;
            //p.println("workflowt loop 1", s1, currentShader, textureId);
            //c1 = 
            drawTextures();
          }
      }
    }
  };


  float mult(float a, float b) {
    return a * b;
  };

  //String[] split(String s,String s1){
  //  String[]S = p.splitTokens(s.substring(pIndex[0]+1,pIndex[1]),",");
  //  parameters[parameters.length-1] =  parameters[parameters.length-1].replaceAll(")s+","");
  //  return 
  //};

  int [] strIndex1(String s) {
    int[]index = new int [2];
    for (int i=0; i<s.length(); i++) {
      char c = s.charAt(i);
      if (c=='(')index[0] = i;
      if (c==')')index[1] = i;
    }
    return index;
  };

  ArrayList [] strIndex(String s) {
    ArrayList[]index = new ArrayList [2];
    index[0] = new ArrayList<Integer>();
    index[1] = new ArrayList<Integer>();
    for (int i=0; i<s.length(); i++) {
      char c = s.charAt(i);
      if (c=='(')index[0].add(i);
      if (c==')')index[1].add(i);
    }
    return index;
  };

  int [] strIndex1(String s, String a, String b) {
    int[]index = new int [2];
    for (int i=0; i<s.length(); i++) {
      char c = s.charAt(i);
      if (c=='a')index[0] = i;
      if (c=='b')index[1] = i;
    }
    return index;
  };

  ArrayList [] strIndex(String s, String a, String b) {
    ArrayList[]index = new ArrayList [2];
    index[0] = new ArrayList<Integer>();
    index[1] = new ArrayList<Integer>();
    for (int i=0; i<s.length(); i++) {
      char c = s.charAt(i);
      if (c=='a')index[0].add(i);
      if (c=='b')index[1].add(i);
    }
    return index;
  };

  int findNext(String s) {
    int a = -1;

    return a;
  };

  public void displayWF(String []s) {
    logic();
    workflow(s);
    if (imagesWF.size()>0)
      p.image(imagesWF.get(counter), ix, iy);
    p.text(workFlowLabels.get(counter), 10, 10);
  };


  public void displayWFCanvas(String []s) {
    logic();
    workflow2(s);
    //if(imagesWF.size()>0)p.image(imagesWF.get(imagesWF.size()-1),x,y);

    //if(imagesWF.size()>0)
    //p.image(imagesWF.get(counter),x,y);
  };

  public void logic() {
    int count = 0;
    if (p.mousePressed&&!mdown) {
      mdown = true;
      counter++;
    }

    if (counter<imagesWF.size()) {
      if (imagesWF.get(counter).width>p.width) {
        if (p.mouseX>0&&p.mouseX<p.width)
          ix = -(int)PApplet.map(p.mouseX, 0, p.width, 0, imagesWF.get(counter).width-p.width);
      }
      if (imagesWF.get(counter).height>p.height) {
        if (p.mouseY>0&&p.mouseY<p.height)
          iy = -(int)PApplet.map(p.mouseY, 0, p.height, 0, imagesWF.get(counter).height-p.height);
      }
    }

    if (!p.mousePressed) {
      mdown = false;
      m2down = false;
    }
    if (counter>imagesWF.size()-1)counter = 0;
    if (imagesWF.size()>0&&mdown&&!m2down) {
      m2down = true;
      PApplet.println(workFlowLabels.get(counter), imagesWF.size());
    }
  };

  public void logic2() {
    //if(p.mousePressed&&!mdown){
    //  mdown = true;
    //  counter++;
    //  p.println(counter);
    //}

    if (p.mouseX>0)counter = (int)PApplet.map(p.mouseX, 0, p.width, 0, imagesWF.size());
    //if(p.mouseX>0)counter = (int)p.map(p.mouseX,0,width,0,cell.edges.size());

    if (!p.mousePressed)mdown = false;
    //if(counter>cell.edges.size()-1)counter = 0;
    p.fill(0);
    p.text("c "+counter, 10, 20);
  };

  public PGraphics simple() {
    c1.beginDraw();
    //if (img!=null)

    c1.image(img, 0, 0);
    c1.endDraw();
    if (workflow&&saveWorkflowImages) {
      //pgraphicsWF.add(c1);
    }
    //image(img,0,0);
    //println("simple",c1);
    return c1;
  };

  public void preload() {
  };

  public PGraphics mean() {
    //shaderSliders.getSlider(0,0).endvalue = 10;

    tab t = workFlow1.tabs.get(currentShader);
    //println("workflow mean 1",t.title.label);
    t.set(0, 0, 0, 50);
    t.set(0, 1, 0, 20);
    t.setInt(0, 2, 0, 20);
    t.set(0, 3, 0, 1);

    mean.set("mult", t.getSlider(0, 0).value);
    float v1 = t.getSlider(0, 1).value;
    float v2 = t.getSlider(0, 2).value;
    //if (t.getSlider(0, 1).mdown)
    mean.set("range", (v1));
    mean.set("type", v2);
    mean.set("min", t.getSlider(0, 3).value);

    c1.beginDraw();
    c1.beginShape();
    c1.texture(c3);
    c1.image(c3, 0, 0);
    //println(t.getSlider(0, 4).value);
    c1.endShape();
    c1.shader(mean);
    c1.endDraw();
    c3 = c1;
    return c1;
  };

  public PGraphics meanV() {

    c1.beginDraw();
    c1.shader(mean);
    c1.image(img, 0, 0);
    c1.endDraw();
    if (workflow&&saveWorkflowImages) {
      //pgraphicsWF.add(c1);
    }
    return c1;
  };

  public PGraphics canny() {
    tab t = workFlow1.tabs.get(currentShader);
    t.set(0, 0, 0, 10);
    t.set(0, 1, 0, 10);
    t.setInt(0, 2, 0, 3);
    t.setInt(0, 3, 1, 10);
    t.set(0, 4, 0, 5);
    t.set(0, 5, 0, 10);

    //"mult", "intensity", "type", "Blur S", "Sigma", "Size"
    gaussian.set("blurSize", (int)t.getSlider(0, 3).value);
    gaussian.set("sigma", t.getSlider(0, 4).value); 

    gaussian.set("horizontalPass", 0);
    pass1.beginDraw();
    pass1.beginShape();
    pass1.texture(c3);
    pass1.image(c3, 0, 0);
    pass1.shader(gaussian);
    pass1.endShape();
    pass1.endDraw();

    // Applying the blur shader along the horizontal direction      
    gaussian.set("horizontalPass", 1);
    pass2.beginDraw();
    pass2.beginShape();
    pass2.texture(pass1);
    pass2.image(pass1, 0, 0);
    pass2.shader(gaussian);
    pass2.endShape();
    pass2.endDraw();  

    canny.set("mult", t.getSlider(0, 0).value);
    canny.set("INTENSITY", t.getSlider(0, 1).value);
    //canny.set("MIN", t.getSlider(0, 2).value);
    canny.set("type", (t.getSlider(0, 2).value));
    c1.beginDraw();
    c1.beginShape();
    c1.texture(pass2);
    c1.image(pass2, 0, 0);
    c1.shader(canny);
    c1.endShape();
    c1.endDraw();
    c3 = c1;

    return c1;
  };

  public PGraphics gaussian() {
    tab t = workFlow1.tabs.get(currentShader);
    t.set(0, 0, 0, 100);
    t.setInt(0, 1, 0, 5);
    gaussian.set("blurSize", (int)t.getSlider(0, 1).value);
    gaussian.set("sigma", t.getSlider(0, 0).value); 

    gaussian.set("horizontalPass", 0);
    pass1.beginDraw();
    pass1.beginShape();
    pass1.texture(c3);
    pass1.image(c3, 0, 0);
    pass1.shader(gaussian);
    pass1.endShape();
    pass1.endDraw();

    gaussian.set("horizontalPass", 1);
    pass2.beginDraw();
    pass2.beginShape();
    pass2.texture(pass1);
    pass2.image(pass1, 0, 0);
    pass2.shader(gaussian);
    pass2.endShape();
    pass2.endDraw();  
    c1 = pass2;
    //if(workFlow.toggle)
    //currentImage = c1.get();
    return pass2;
  };

  public PGraphics gaussianBlur() {
    tab t = workFlow1.tabs.get(currentShader);
    t.set(0, 0, 0, 10);
    t.setInt(0, 1, 0, 5);
    gaussian.set("blurSize", (int)t.getSlider(0, 1).value);
    gaussian.set("sigma", t.getSlider(0, 0).value); 

    gaussian.set("horizontalPass", 0);
    pass1.beginDraw();      
    pass1.beginShape();
    pass1.texture(c3);
    pass1.image(c3, 0, 0);
    pass1.shader(gaussian);
    pass1.endDraw();

    gaussian.set("horizontalPass", 1);
    c1.beginDraw();
    c1.beginShape();
    c1.texture(c3);
    c1.image(pass1, 0, 0);
    c1.shader(gaussian); 
    c1.endDraw();   
    c3 = c1;
    //currentImage = c1.get();
    return c1;
  };

  public PGraphics blur() {
    c1 = gaussianBlur();
    return c1;
  };

  public PGraphics variance() {
    //{"mult", "range", "type", "mult1", "range","type","mr","mg","mb","ma"};
    tab t = workFlow1.tabs.get(currentShader);
    t.set(0, 0, -50, 50);
    t.set(0, 1, 0, 10);
    t.setInt(0, 2, 0, 20);
    t.set(0, 3, 0, 200);
    t.setInt(0, 4, 0, 10);
    t.setInt(0, 5, 0, 10);
    t.set(0, 6, 0, 10);
    t.set(0, 7, 0, 10);
    t.set(0, 8, 0, 10);
    t.set(0, 9, 0, 10);
    //t.setInt(0, 9, 0, 10);
    mean.set("mult", t.getSlider(0, 0).value);
    mean.set("range", t.getSlider(0, 1).value);
    //if(t.getSlider(0, 2).mdown)
    mean.set("type", t.getSlider(0, 2).value);
    //mean.set("mult", t.getSlider(0, 3).value);
    //mean.set("mr", t.getSlider(0, 5).value);
    //mean.set("mg", t.getSlider(0, 6).value);
    //mean.set("mb", t.getSlider(0, 7).value);
    //mean.set("ma", t.getSlider(0, 8).value);
    pass1.beginDraw();
    pass1.beginShape();
    pass1.texture(c3);
    pass1.pushMatrix();
    //pass1.translate(img.width,img.height);

    //pass1.rotate(PI);
    //pass1.scale((float)(width)/img.width, 
    //  -1*(float)(height)/img.height);

    pass1.image(c3, 0, 0);
    pass1.shader(mean);
    pass1.endShape();
    pass1.popMatrix();
    pass1.endDraw();

    variance.set("Mean", pass1);
    variance.set("Img", c3);
    variance.set("mult", t.getSlider(0, 3).value);
    variance.set("range", t.getSlider(0, 4).value);
    variance.set("type", t.getSlider(0, 5).value);
    variance.set("mr", t.getSlider(0, 6).value);
    variance.set("mg", t.getSlider(0, 7).value);
    variance.set("mb", t.getSlider(0, 8).value);
    variance.set("ma", t.getSlider(0, 9).value);
    //variance.set("range", 2);
    c1.beginDraw();
    c1.pushMatrix();
    //c1.translate(0, -(img.height)/6);
    c1.beginShape();
    c1.texture(c3);
    c1.image(c3, 0, 0);
    c1.shader(variance);
    c1.endShape();
    c1.popMatrix();
    c1.endDraw();
    //c1 = pass1;
    c3 = c1;
    return c1;
  };

  //public PGraphics variance() {
  //  //{"mult", "range", "type", "mult1", "range","mr","mg","mb","ma"};
  //  tab t = shaderSliders.states.get(2);
  //  t.set(0, 0, -50, 50);
  //  t.setInt(0, 1, 0, 4);
  //  t.setInt(0, 2, 0, 20);
  //  t.set(0, 3, 0, 200);
  //  t.setInt(0, 4, 0, 7);
  //  t.setInt(0, 5, 0, 20);
  //  t.set(0, 6, 0, 10);
  //  t.set(0, 7, 0, 10);
  //  t.set(0, 8, 0, 10);
  //  t.set(0, 9, 0, 10);
  //  mean.set("mult", t.getSlider(0, 0).value);
  //  mean.set("range", (float) t.getSlider(0, 1).value);
  //  //if (t.getSlider(0, 2).mdown)
  //  mean.set("type", (float)t.getSlider(0, 2).value);
  //  //mean.set("mult", t.getSlider(0, 3).value);
  //  //mean.set("mr", t.getSlider(0, 5).value);
  //  //mean.set("mg", t.getSlider(0, 6).value);
  //  //mean.set("mb", t.getSlider(0, 7).value);
  //  //mean.set("ma", t.getSlider(0, 8).value);
  //  pass1.beginDraw();
  //  pass1.pushMatrix();
  //  //pass1.translate(img.width,img.height);

  //  //pass1.rotate(PI);
  //  //pass1.scale((float)(width)/c3.width, -2);
  //  //pass1.translate(0, -(c3.height));
  //  pass1.scale((float)(width)/currentImage.width, 
  //    -1*(float)(height)/currentImage.height);
  //  pass1.translate(0, -(currentImage.height));
  //  pass1.image(currentImage, 0, 0);
  //  //if(!workFlow1.toggle){
  //  //    pass1.image(img, 0, 0);
  //  //  }else{
  //  //    pass1.image(c3, 0, 0);
  //  //  }
  //  pass1.shader(mean);
  //  pass1.popMatrix();
  //  pass1.endDraw();

  //  c1.beginDraw();
  //  variance.set("Mean", pass1);
  //  variance.set("Img", currentImage);
  //  variance.set("mult", t.getSlider(0, 3).value);
  //  variance.set("range", (float)t.getSlider(0, 4).value);
  //  variance.set("type", (float)t.getSlider(0, 5).value);
  //  variance.set("mr", t.getSlider(0, 6).value);
  //  variance.set("mg", t.getSlider(0, 7).value);
  //  variance.set("mb", t.getSlider(0, 8).value);
  //  variance.set("ma", t.getSlider(0, 9).value);
  //  //c2.image(c3,0,0);
  //  c1.shader(variance);

  //  c1.endDraw();

  //  if (workFlow.toggle)currentImage = pass1.get();
  //  c1 = pass1;
  //  //currentCanvas = c1;
  //  //if(workflow&&saveWorkflowImages)workflowImg.add(c1.get());
  //  return c1;
  //};

  public PGraphics sobel() {
    tab t = workFlow1.tabs.get(currentShader);
    t.set(0, 0, 0, 1);
    t.setInt(0, 1, 0, 10);
    sobel.set("mult", t.getSlider(0, 0).value);
    sobel.set("type", t.getSlider(0, 1).value);
    c1.beginDraw();
    c1.beginShape();
    c1.texture(c3);
    c1.image(c3, 0, 0);
    c1.endShape();
    c1.shader(sobel);
    c1.endDraw();

    //c3.beginDraw();
    //c3.image(c1, 0, 0);
    //c3.endDraw();
    //c1 = c3;
    c3 = c1;
    //if(workFlow.toggle)
    //currentImage = c1.get();
    return c1;
  };

  public void shaderCollection() {
    //setShaderParameters();
  };

  public PGraphics sharpen() {
    return c1;
  };

  public PGraphics poissonDist() {
    return c1;
  };

  public PGraphics dither() {
    return c1;
  };

  public void shaderLogic() {

    if (function==0) {
      tempShader = mean;
    }
    if (function==1) {
    }
    if (function==2) {
    }
    if (function==3) {
    }
    if (function==4) {
    }
    if (function==0) {
    }
  }

  public void setBms(BMS bms) {
    Bms = bms;
    p = bms.applet;
  };

  public void setBms(tab bms) {
    Bms = bms.Bms;
    p = bms.Bms.applet;
  };

  public void setVideoDLocation(String s) {
    videoLocation = s;
    dataFolder = true;
  };

  public void setVideoLocation(String s) {
    videoLocation = s;
  };

  public void set(String a) {
    img = p.loadImage(a);
    currentImage = p.loadImage(a);
  };

  public void set(PImage a) {
    img = a;
    currentImage = a;
  };
  public void set(PGraphics a) {
    img = a.get();
    currentImage = a;
  };

  public void cast() {
    c3.beginDraw();
    c3.background(255);
    c3.image(img, 0, 0);
    //set(c3);
    c3.endDraw();
    set(c3.get());
  };

  public void reset() {
    set("circle.jpg");
    initCanvasesP2D();
    reset = false;
    t1.getButton(0, 5).toggle = false;
  };
};
