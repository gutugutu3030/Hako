/*
マップの情報はこちら。
ある程度プログラムができたらここだけをいじればいいようにしたよ。
*/

public float maped(float x,float y){
  //地形データ (x,y)からz座標を特定
  float a=0;
  a=max(ARBox.judge(x,y,a),a);
  return a;
}

public void mapdraw(){
  strokeWeight(1);
  stroke(0);
  //オクルージョンするか否か
  if(ifdraw){
    fill(128,128,255);
  }else{
    noStroke();
    fill(key_color);
  }
  ARBox.draw(true);
}

public void mapdiff(){
  ARBox.update(pat,nya,patid,id);
}
