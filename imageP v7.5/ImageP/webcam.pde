public class Webcam {
  public BMS Bms;
  public String[] cameras;
  public Capture cam;
  public PApplet applet;
  public PImage t;

  public Webcam(BMS b) {
    Bms = b;
    applet.println("webcam",b);
    applet = b.applet;
    Bms.cameras = Capture.list();
    //Bms.setCams();
    applet.println("cameras",Bms.cameras);
    
    
    cameras = Bms.cameras;
    //applet.println(cameras);
    if (cameras.length == 0) {
      applet.println("There are no cameras available for capture.");
      //exit();
    } else {
      applet.println(cameras.length + " Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        applet.println(i + " " + cameras[i]);
      }

      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(applet, cameras[26]);
//      cam.start();
    }
    t = applet.createImage(applet.width,applet.height,applet.ARGB);
  };
  
  public Webcam(BMS b,int w,int h) {
    Bms = b;
    applet = b.applet;
    cameras = Bms.cameras;
    if (cameras.length == 0) {
      applet.println("There are no cameras available for capture.");
      //exit();
    } else {
      applet.println(cameras.length + " Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        applet.println(i + " " + cameras[i]);
      }

      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(applet, cameras[26]);
//      cam.start();
    }
    t = applet.createImage(w,h,applet.ARGB);
  };
  
  public Webcam(BMS b,String []s) {
    Bms = b;
    applet = b.applet;
    cameras = s;
    if (cameras.length == 0) {
      applet.println("There are no cameras available for capture.");
      //exit();
    } else {
      applet.println(cameras.length + " Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        applet.println(i + " " + cameras[i]);
      }

      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(applet, cameras[26]);
//      cam.start();
    }
    t = applet.createImage(applet.width,applet.height,applet.ARGB);
  };
  
  public Webcam(BMS b,String []s,int w,int h) {
    Bms = b;
    applet = b.applet;
    cameras = s;
    if (cameras.length == 0) {
      applet.println("There are no cameras available for capture.");
      //exit();
    } else {
      applet.println(cameras.length + " Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        applet.println(i + " " + cameras[i]);
      }

      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(applet, cameras[26]);
//      cam.start();
    }
    t = applet.createImage(applet.width,applet.height,applet.ARGB);
  };

  public void read(){
    if (cam.available() == true) {
      cam.read();
    }
  };

  public void display() {
    if (cam.available() == true) {
      cam.read();
    }
    applet.image(cam, 0, 0);
  };

  public void display(float x, float y) {
    if (cam.available() == true)cam.read();
    else applet.println("no Cam");
    applet.image(cam, x, y);
  };

  public void display(PGraphics c) {
    if (cam.available() == true){
      cam.read();
      t = cam;
    }
    //else applet.println("no cam");
    c.beginDraw();
    c.image(t, 0, 0);
    c.endDraw();
  };
  
  void displayC(PGraphics c) {
    if (cam.available() == true)cam.read();
    
    //if (show) {
      c.beginDraw();
      c.image(cam, 0, 0);
      c.endDraw();
    //}
    println("webcam disp");
  };

  public PImage get() {
    return cam;
  };

  public PImage getCam() {
    if (!cam.available())cam.start();
    cam.read();
    return cam;
  };

  public void set(int a, int b, PImage img) {
    
  };
  
  public void stop() {
    if(cam.available())cam.stop();
    println("webcam stop");
  };
};
