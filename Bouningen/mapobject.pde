//コイツのxはtranslate中心になってるから、考えるときは(-x)で考えるといいよ！！

public class Table{
  private float sx,sy,sz;//大きさ
  private boolean ifread;
  private float x,y;//座標（普通のxy座標）
  //private int tops[]=new int[4];
  private float pos[][]=new float[8][3];
  private float CenterX,CenterY,CenterZ;
  private float oldX,oldY;
  private float bux,buy;
  private PMatrix3D oldmat;
  private float fudgefactor;//誤差修正用の変数
  private PMatrix3D test,test2;//相対座標変換用の一時行列保存
  private int dir;
  public Table(float n){
    this();
    fudgefactor=n;
  }
  public Table(){
    ifread=false;
    oldmat=new PMatrix3D();
    fudgefactor=0.05;
    dir=0;
  }
  public void getdata(){
    println("x,y=");
    println(CenterZ+25);
    println("sz:"+sz);
  }
  public float judge(float a,float b,float c){//(a,b)座標
  if(!ifread)return c;
    if(ifin(a,b)){
      return sz;
    }
    return c;
  }
  public void draw(boolean ifdraw){
    if(!ifdraw)return;
    if(!ifread)return;
    fill(255,0,0);
    beginShape();
      vertex(-pos[0][0],pos[0][1],pos[0][2]);
      vertex(-pos[1][0],pos[1][1],pos[1][2]);
      vertex(-pos[2][0],pos[2][1],pos[2][2]);
      vertex(-pos[3][0],pos[3][1],pos[3][2]);
    endShape(CLOSE);
    fill(0,254,0);
    beginShape();
      vertex(-pos[1][0],pos[1][1],pos[1][2]);
      vertex(-pos[2][0],pos[2][1],pos[2][2]);
      vertex(-pos[5][0],pos[5][1],pos[5][2]);
      vertex(-pos[6][0],pos[6][1],pos[6][2]);
    endShape(CLOSE);
    fill(0,0,255);
    beginShape();
      vertex(-pos[2][0],pos[2][1],pos[2][2]);
      vertex(-pos[3][0],pos[3][1],pos[3][2]);
      vertex(-pos[4][0],pos[4][1],pos[4][2]);
      vertex(-pos[5][0],pos[5][1],pos[5][2]);
    endShape(CLOSE);
    fill(255,255,0);
    beginShape();
      vertex(-pos[0][0],pos[0][1],pos[0][2]);
      vertex(-pos[3][0],pos[3][1],pos[3][2]);
      vertex(-pos[4][0],pos[4][1],pos[4][2]);
      vertex(-pos[7][0],pos[7][1],pos[7][2]);
    endShape(CLOSE);
    fill(0,255,255);
    beginShape();
      vertex(-pos[0][0],pos[0][1],pos[0][2]);
      vertex(-pos[1][0],pos[1][1],pos[1][2]);
      vertex(-pos[6][0],pos[6][1],pos[6][2]);
      vertex(-pos[7][0],pos[7][1],pos[7][2]);
    endShape(CLOSE);
    fill(255,0,255);
    beginShape();
      vertex(-pos[4][0],pos[4][1],pos[4][2]);
      vertex(-pos[5][0],pos[5][1],pos[5][2]);
      vertex(-pos[6][0],pos[6][1],pos[6][2]);
      vertex(-pos[7][0],pos[7][1],pos[7][2]);
    endShape(CLOSE);
    
  }
  public void update(MultiMarker nya,MultiMarker ar,int id,int arid){
    if(!nya.isExistMarker(id))return;
    if(!ar.isExistMarker(arid))return;
    ifread=true;
    test=nya.getMarkerMatrix(id);
    test.invert();
    test2=ar.getMarkerMatrix(arid);
    test.apply(test2);
    
    if(oldmat.m00==test.m00&&oldmat.m01==test.m01&&oldmat.m02==test.m02&&
       oldmat.m10==test.m10&&oldmat.m11==test.m11&&oldmat.m12==test.m12&&
       oldmat.m20==test.m20&&oldmat.m21==test.m21&&oldmat.m22==test.m22&&
       abs(oldmat.m03-test.m03)<fudgefactor&&
       abs(oldmat.m13-test.m13)<fudgefactor&&
       abs(oldmat.m23-test.m23)<fudgefactor){}
    else{
      if(abs(oldmat.m03-test.m03)<fudgefactor&&
       abs(oldmat.m13-test.m13)<fudgefactor&&
       abs(oldmat.m23-test.m23)<fudgefactor)println("OUT");
       else println();
        CenterZ=-25*test.m22+test.m23;
        float vertexZ[]={25*test.m20+25*test.m21+test.m23,25*test.m20-25*test.m21+test.m23,-25*test.m20-25*test.m21+test.m23,-25*test.m20+25*test.m21+test.m23};//4すみの登録
        float vertexOld[]=vertexZ.clone();
        if(max(max(max(vertexZ[0],vertexZ[1]),vertexZ[2]),vertexZ[3])-min(min(min(vertexZ[0],vertexZ[1]),vertexZ[2]),vertexZ[3])<=40){
          //上面と判定
          println("0");
          //(25,25,0)
          pos[0][0]=-(25*test.m00+25*test.m01+test.m03);
          pos[0][1]=25*test.m10+25*test.m11+test.m13;
          pos[0][2]=25*test.m20+25*test.m21+test.m23;
          //(25,-25,0)
          pos[1][0]=-(25*test.m00-25*test.m01+test.m03);
          pos[1][1]=25*test.m10-25*test.m11+test.m13;
          pos[1][2]=25*test.m20-25*test.m21+test.m23;
          //(-25,-25,0)
          pos[2][0]=-(-25*test.m00-25*test.m01+test.m03);
          pos[2][1]=-25*test.m10-25*test.m11+test.m13;
          pos[2][2]=-25*test.m20-25*test.m21+test.m23;
          //(-25,25,0)
          pos[3][0]=-(-25*test.m00+25*test.m01+test.m03);
          pos[3][1]=-25*test.m10+25*test.m11+test.m13;
          pos[3][2]=-25*test.m20+25*test.m21+test.m23;
          //(25,25,-50)
          pos[7][0]=-(25*test.m00+25*test.m01-50*test.m02+test.m03);
          pos[7][1]=25*test.m10+25*test.m11-50*test.m12+test.m13;
          pos[7][2]=25*test.m20+25*test.m21-50*test.m22+test.m23;
          //(25,-25,-50)
          pos[6][0]=-(25*test.m00-25*test.m01-50*test.m02+test.m03);
          pos[6][1]=25*test.m10-25*test.m11-50*test.m12+test.m13;
          pos[6][2]=25*test.m20-25*test.m21-50*test.m22+test.m23;
          //(-25,-25,-50)
          pos[5][0]=-(-25*test.m00-25*test.m01-50*test.m02+test.m03);
          pos[5][1]=-25*test.m10-25*test.m11-50*test.m12+test.m13;
          pos[5][2]=-25*test.m20-25*test.m21-50*test.m22+test.m23;
          //(-25,25,-50)
          pos[4][0]=-(-25*test.m00+25*test.m01-50*test.m02+test.m03);
          pos[4][1]=-25*test.m10+25*test.m11-50*test.m12+test.m13;
          pos[4][2]=-25*test.m20+25*test.m21-50*test.m22+test.m23;
        }else{
          //側面と判定
          //大きい順に変更
          float max,t;
          int s;
          for(int i=0;i<3;i++){
            max=vertexZ[i];
            s=i;
            for(int j=i+1;j<4;j++){
              if(vertexZ[j]>max){
                max=vertexZ[j];
                s=j;
              }
            }
            t=vertexZ[i];vertexZ[i]=vertexZ[s];vertexZ[s]=t;
          }
          if((vertexZ[0]==vertexOld[2]&&vertexZ[1]==vertexOld[3])||(vertexZ[1]==vertexOld[2]&&vertexZ[0]==vertexOld[3])){
            println("1");
            //(25,25,0)
            pos[6][0]=-(25*test.m00+25*test.m01+test.m03);
            pos[6][1]=25*test.m10+25*test.m11+test.m13;
            pos[6][2]=25*test.m20+25*test.m21+test.m23;
            //(25,-25,0)
            pos[5][0]=-(25*test.m00-25*test.m01+test.m03);
            pos[5][1]=25*test.m10-25*test.m11+test.m13;
            pos[5][2]=25*test.m20-25*test.m21+test.m23;
            //(-25,-25,0)
            pos[2][0]=-(-25*test.m00-25*test.m01+test.m03);
            pos[2][1]=-25*test.m10-25*test.m11+test.m13;
            pos[2][2]=-25*test.m20-25*test.m21+test.m23;
            //(-25,25,0)
            pos[1][0]=-(-25*test.m00+25*test.m01+test.m03);
            pos[1][1]=-25*test.m10+25*test.m11+test.m13;
            pos[1][2]=-25*test.m20+25*test.m21+test.m23;
            //(25,25,-50)
            pos[7][0]=-(25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[7][1]=25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[7][2]=25*test.m20+25*test.m21-50*test.m22+test.m23;
            //(25,-25,-50)
            pos[4][0]=-(25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[4][1]=25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[4][2]=25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,-25,-50)
            pos[3][0]=-(-25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[3][1]=-25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[3][2]=-25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,25,-50)
            pos[0][0]=-(-25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[0][1]=-25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[0][2]=-25*test.m20+25*test.m21-50*test.m22+test.m23;
          }else if((vertexZ[0]==vertexOld[1]&&vertexZ[1]==vertexOld[2])||(vertexZ[1]==vertexOld[1]&&vertexZ[0]==vertexOld[2])){
            println("2");
            //(25,25,0)
            pos[4][0]=-(25*test.m00+25*test.m01+test.m03);
            pos[4][1]=25*test.m10+25*test.m11+test.m13;
            pos[4][2]=25*test.m20+25*test.m21+test.m23;
            //(25,-25,0)
            pos[3][0]=-(25*test.m00-25*test.m01+test.m03);
            pos[3][1]=25*test.m10-25*test.m11+test.m13;
            pos[3][2]=25*test.m20-25*test.m21+test.m23;
            //(-25,-25,0)
            pos[2][0]=-(-25*test.m00-25*test.m01+test.m03);
            pos[2][1]=-25*test.m10-25*test.m11+test.m13;
            pos[2][2]=-25*test.m20-25*test.m21+test.m23;
            //(-25,25,0)
            pos[5][0]=-(-25*test.m00+25*test.m01+test.m03);
            pos[5][1]=-25*test.m10+25*test.m11+test.m13;
            pos[5][2]=-25*test.m20+25*test.m21+test.m23;
            //(25,25,-50)
            pos[7][0]=-(25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[7][1]=25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[7][2]=25*test.m20+25*test.m21-50*test.m22+test.m23;
            //(25,-25,-50)
            pos[0][0]=-(25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[0][1]=25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[0][2]=25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,-25,-50)
            pos[1][0]=-(-25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[1][1]=-25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[1][2]=-25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,25,-50)
            pos[6][0]=-(-25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[6][1]=-25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[6][2]=-25*test.m20+25*test.m21-50*test.m22+test.m23;
          }else if((vertexZ[0]==vertexOld[0]&&vertexZ[1]==vertexOld[1])||(vertexZ[1]==vertexOld[0]&&vertexZ[0]==vertexOld[1])){
            println("3");
            //(25,25,0)
            pos[0][0]=-(25*test.m00+25*test.m01+test.m03);
            pos[0][1]=25*test.m10+25*test.m11+test.m13;
            pos[0][2]=25*test.m20+25*test.m21+test.m23;
            //(25,-25,0)
            pos[3][0]=-(25*test.m00-25*test.m01+test.m03);
            pos[3][1]=25*test.m10-25*test.m11+test.m13;
            pos[3][2]=25*test.m20-25*test.m21+test.m23;
            //(-25,-25,0)
            pos[4][0]=-(-25*test.m00-25*test.m01+test.m03);
            pos[4][1]=-25*test.m10-25*test.m11+test.m13;
            pos[4][2]=-25*test.m20-25*test.m21+test.m23;
            //(-25,25,0)
            pos[7][0]=-(-25*test.m00+25*test.m01+test.m03);
            pos[7][1]=-25*test.m10+25*test.m11+test.m13;
            pos[7][2]=-25*test.m20+25*test.m21+test.m23;
            //(25,25,-50)
            pos[1][0]=-(25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[1][1]=25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[1][2]=25*test.m20+25*test.m21-50*test.m22+test.m23;
            //(25,-25,-50)
            pos[2][0]=-(25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[2][1]=25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[2][2]=25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,-25,-50)
            pos[5][0]=-(-25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[5][1]=-25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[5][2]=-25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,25,-50)
            pos[6][0]=-(-25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[6][1]=-25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[6][2]=-25*test.m20+25*test.m21-50*test.m22+test.m23;
          }else{
            println("4");
            //(25,25,0)
            pos[0][0]=-(25*test.m00+25*test.m01+test.m03);
            pos[0][1]=25*test.m10+25*test.m11+test.m13;
            pos[0][2]=25*test.m20+25*test.m21+test.m23;
            //(25,-25,0)
            pos[7][0]=-(25*test.m00-25*test.m01+test.m03);
            pos[7][1]=25*test.m10-25*test.m11+test.m13;
            pos[7][2]=25*test.m20-25*test.m21+test.m23;
            //(-25,-25,0)
            pos[6][0]=-(-25*test.m00-25*test.m01+test.m03);
            pos[6][1]=-25*test.m10-25*test.m11+test.m13;
            pos[6][2]=-25*test.m20-25*test.m21+test.m23;
            //(-25,25,0)
            pos[1][0]=-(-25*test.m00+25*test.m01+test.m03);
            pos[1][1]=-25*test.m10+25*test.m11+test.m13;
            pos[1][2]=-25*test.m20+25*test.m21+test.m23;
            //(25,25,-50)
            pos[3][0]=-(25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[3][1]=25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[3][2]=25*test.m20+25*test.m21-50*test.m22+test.m23;
            //(25,-25,-50)
            pos[4][0]=-(25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[4][1]=25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[4][2]=25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,-25,-50)
            pos[5][0]=-(-25*test.m00-25*test.m01-50*test.m02+test.m03);
            pos[5][1]=-25*test.m10-25*test.m11-50*test.m12+test.m13;
            pos[5][2]=-25*test.m20-25*test.m21-50*test.m22+test.m23;
            //(-25,25,-50)
            pos[2][0]=-(-25*test.m00+25*test.m01-50*test.m02+test.m03);
            pos[2][1]=-25*test.m10+25*test.m11-50*test.m12+test.m13;
            pos[2][2]=-25*test.m20+25*test.m21-50*test.m22+test.m23;
          }
        }
        float max;
        boolean IFtops;
        sz=(pos[0][2]+pos[1][2]+pos[2][2]+pos[3][2])/4;
        CenterX=(pos[0][0]+pos[1][0]+pos[2][0]+pos[3][0])/4;
        CenterX=(pos[0][1]+pos[1][1]+pos[2][1]+pos[3][1])/4;
        if(ifin(p.getX(),p.getY())&&(((p.getZ()+68>CenterZ-25))||(p.getZ()>CenterZ+25))){
          p.setXDiff(CenterX-oldX);
          p.setYDiff(CenterY-oldY);
        }
        
        //old系変数にバックアップをとっておく
        oldmat=test;
        oldX=CenterX;
        oldY=CenterY;
        
       }
  }
  boolean ifin(float x,float y){
    float boxS=gaiseki(pos[0][0]-pos[1][0],pos[0][1]-pos[1][1],pos[2][0]-pos[1][0],pos[2][1]-pos[1][1]);
    float p=0.0;
    p+=gaiseki(pos[0][0]-x,pos[0][1]-y,pos[1][0]-x,pos[1][1]-y)/2;
    p+=gaiseki(pos[1][0]-x,pos[1][1]-y,pos[2][0]-x,pos[2][1]-y)/2;
    p+=gaiseki(pos[2][0]-x,pos[2][1]-y,pos[3][0]-x,pos[3][1]-y)/2;
    p+=gaiseki(pos[3][0]-x,pos[3][1]-y,pos[0][0]-x,pos[0][1]-y)/2;
    if(boxS+5>=p){
      return true;
    }
    return false;
  }
  float gaiseki(float ax,float ay,float bx,float by){
    return abs(ax*by-ay*bx);
  }
  float naiseki(float ax,float ay,float bx,float by){
    return ax*bx+ay*by;
  }
  int servoAngle(Person p){
    float ax=(pos[1][0]+pos[0][0])/2-(pos[2][0]+pos[3][0])/2;
    float ay=(pos[1][1]+pos[0][1])/2-(pos[2][1]+pos[3][1])/2;
    float bx=p.getX()-(pos[2][0]+pos[3][0])/2;
    float by=p.getY()-(pos[2][1]+pos[3][1])/2;
    
    int ang=(int)degrees(atan2((ax*by-ay*bx),(ax*bx+ay*by)));
    if(ang>=0){
      dir=0;
    }else{
      dir=1;
      ang+=180;
    }
    return ang;
  }
  int servoDir(){
    return dir;
  }
}


