/*
ダメージ判定なしの、マーカー間座標変換仕様のアクションゲーム。
いらん使ってない変数あるかも。消せ。
*/
import codeanticode.gsvideo.*;
import jp.nyatla.nyar4psg.*;
import java.awt.event.*;

color[] pixelBuffer = null;            // 描画内容を一時保存しておくためのバッファ
color   key_color = color(0, 255, 0);  // クロマキー合成用の背景色
boolean ifdraw=true;
int loopcount=0;
int sousa=5;//操作の速さ
Person p=new Person(0,0,50);
Table ARBox=new Table();
GSCapture cam;
MultiMarker nya;//Boxのマーカー
int id;
MultiMarker pat;//全体座標のマーカー
int patid;

void setup(){
  size(800,600,P3D);
  sphereDetail(10);
  cam=new GSCapture(this,width,height);
  pat=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  patid=pat.addARMarker("twittericon.pat",80);
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  id=nya.addARMarker("hakohako.pat",40);
  //id=nya.addNyIdMarker(7,30);
  
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }}); 
  pixelBuffer = new color[width * height];
  cam.start();
}

void draw(){
  if(cam.available()==false)return;
  cam.read();
  nya.detect(cam);  
  pat.detect(cam);
  background(key_color);//オクルージョンよう
  if(!pat.isExistMarker(patid)){
    pat.drawBackground(cam);
    return;//写ってないなら処理しない
  }
  pat.beginTransform(patid);
  //各々で違う処理は強引にswitch文へ・・・
  //FineTuning(i);
  ObjectSetting();
  pat.endTransform();
  loopcount++;
  //return;
  if(loopcount==2147483600){
    loopcount=0;
    println("");
    println("reset loopcount");
    println("");
  }
  loadPixels();                    // pixelsに画面データをロード
  arrayCopy(pixels, pixelBuffer);  // バッファにコピー
  background(0);
  nya.drawBackground(cam);//frustumを考慮した背景描画
  pat.drawBackground(cam);//frustumを考慮した背景描画
  loadPixels();                     // pixelsに画面データをロード  
  for (int i = 0; i < width * height; i++) {
    if (pixelBuffer[i] != key_color) {
      pixels[i] = pixelBuffer[i];   // キーカラーでないピクセルだけ書き換え
    }
  }
  updatePixels();                   // pixelsのデータを画面に反映
  serial();
}

void ObjectSetting(){
  mapdiff();//箱の位置を更新  
  pushMatrix();
  mapdraw();
  popMatrix();
  strokeWeight(3);
  noFill();
  rotate(HALF_PI,1,0,0);
  rotate(PI,0,1,0);  
  p.setSZ(maped(p.getX(),p.getY()));//基本z座標をマップと同期
  stroke(255,0,0);
  p.draw();
  //操作入力を書く
  cont();
}

int simdeg(int deg){
  //０～３６０に変更
  if((deg>=0)&&(deg<360))return deg;
  if(deg<0)simdeg(deg+360);
  if(deg>=360)return (deg%360);
  return -1;
}



void cont(){
  //棒人間の移動
  if(p.getActiontime()==0){
    if(mouseX<width/5){
      //左
      p.setAngleDiff(-sousa*2);
    }
    if(mouseX>width*4/5){
      //右
      p.setAngleDiff(sousa*2);
    }
  }
  if(p.getActiontime()==0){
    p.update();
    if(mouseY<height/5){
      //上
      p.setSZ(maped(p.getX(),p.getY()));//基本z座標をマップと同期
          p.setXDiff(sin(radians(p.getAngle()))*sousa);
          p.setYDiff(cos(radians(p.getAngle()))*sousa);
          if(p.getSZ()>p.getZ()){
            p.setX(p.getX0());
            p.setY(p.getY0());
          }else{
            if(p.getType()!=3)p.setType(1);
          }
    }
    if(mouseY>height*4/5){
      //下
      p.setSZ(maped(p.getX(),p.getY()));//基本z座標をマップと同期
          p.setXDiff(-sin(radians(p.getAngle()))*sousa);
          p.setYDiff(-cos(radians(p.getAngle()))*sousa);
          if(p.getSZ()<p.getZ()){
            p.setX(p.getX0());
            p.setY(p.getY0());
          }else{
            if(p.getType()!=3)p.setType(2);
          }
    }
  }
}


void mouseWheel(int delta) {
  if(p.getActiontime()==0){
    p.update();
    if(delta==-1){
      //上
      p.setSZ(maped(p.getX(),p.getY()));//基本z座標をマップと同期
          p.setXDiff(sin(radians(p.getAngle()))*sousa);
          p.setYDiff(cos(radians(p.getAngle()))*sousa);
          if(p.getSZ()>p.getZ()){
            p.setX(p.getX0());
            p.setY(p.getY0());
          }else{
            if(p.getType()!=3)p.setType(1);
          }
    }
    if(delta==1){
      //下
      p.setSZ(maped(p.getX(),p.getY()));//基本z座標をマップと同期
          p.setXDiff(-sin(radians(p.getAngle()))*sousa);
          p.setYDiff(-cos(radians(p.getAngle()))*sousa);
          if(p.getSZ()<p.getZ()){
            p.setX(p.getX0());
            p.setY(p.getY0());
          }else{
            if(p.getType()!=3)p.setType(2);
          }
    }
  }
  
}


void mousePressed() {
  if ((mouseButton == LEFT)&&(p.getJumptime()==0)&&(p.getActiontime()==0)) {
    //ジャンプ
    p.setType(3);
    p.setZ0(p.getZ());
  } else if ((mouseButton == RIGHT)&&(p.getActiontime()==0)) {
    //攻撃
    p.setType(4);
    p.setActiontime(4);
  }
}

void keyPressed() {
  if(key==' '){
    if(ifdraw){
      ifdraw=false;
    }else{
      ifdraw=true;
    }
    println("changed");
    
  }
    if(key==ENTER){
        println("player1:");
        p.getData();
        println("box:");
        ARBox.getdata();
    }
}

void serial(){
  println("angle:"+ARBox.servoAngle(p));
  println("dir:"+ARBox.servoDir());
}
