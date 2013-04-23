public class Person{
  private int type;
  private int jumptime;//0<=jumptime<=16
  private int falltime;
  private int actiontime;
  private float Sz;
  private float x,y,z;
  private float x0,y0,z0;
  private int angle;
  private int life;
  private boolean muteki;
  public Person(){
    type=0;
    jumptime=0;
    falltime=0;
    actiontime=0;
    x=0;y=0;z0=0;
    x=0;y=0;z=Sz=0;
    angle=0;
    life=50;
    muteki=false;
  }
  public Person(float a,float b){
    this();
    x=a;y=-b;
    z=z0=Sz=maped(x,y);
  }
  public Person(float a,float b,float c){
    this();
    x=a;y=-b;z=c;
    
  }
  public void getData(){
        println("x:"+x);
        println("y:"+y);
        println("z:"+z);
        println("x0:"+x0);
        println("y0:"+y0);
        println("z0:"+z0);
        println("angle:"+angle);
        println("Sz:"+Sz);
        println("type:"+type);
        println("jumptime:"+jumptime);
        println("falltime:"+falltime);
        println("actiontime:"+actiontime);
        println("");
  }
  public int getType(){
    return type;
  }
  public void setType(int n){
    type=n;
  }
  public int getAngle(){
    return angle;
  } 
  public void setAngle(int n){
    angle=n;
    //println(n);
  }
  public void setAngleDiff(int n){
    angle+=n;
  }
  public int getJumptime(){
    return jumptime;
  }
  public void setJumptime(int n){
    jumptime=n;
  }
  public int getFalltime(){
    return falltime;
  }
  public void setFalltime(int n){
    falltime=n;
  }
  public int getActiontime(){
    return actiontime;
  }
  public void setActiontime(int n){
    actiontime=n;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getZ(){
    return z;
  }
  public void setX(float n){
    x=n;
  }
  public void setY(float n){
    y=n;
  }
  public void setZ(float n){
    z=n;
  }
  public void setXDiff(float n){
    x+=n;
  }
  public void setYDiff(float n){
    y+=n;
  }
  public void setZDiff(float n){
    z+=n;
  }
  public float getSZ(){
    return Sz;
  }
  public void setSZ(float n){
    Sz=n;
  }
  public boolean Ifmuteki(){
    return muteki;
  }
  public void muteki(){
    muteki=true;
  }
  public void noMuteki(){
    muteki=false;
  }
  public float[] getXYZ(){
    float n[]={x,y,z};
    return n;
  }
  public float getX0(){
    return x0;
  }
  public float getY0(){
    return y0;
  }
  public float getZ0(){
    return z0;
  }
  public void setX0(float n){
    x0=n;
  }
  public void setY0(float n){
    y0=n;
  }
  public void setZ0(float n){
    z0=n;
  }
  public float[] getXYZ0(){
    float n[]={x0,y0,z0};
    return n;
  }
  public void damage(){
    life--;
  }
  public int getLife(){
    return life;
  }
  public void update(){
    x0=x;
    y0=y;
  }
  void standing(){
    rotate(radians(180),0,1,0);
    translate(0,58,0);
    line(0,0,0,0,-28,0);
        pushMatrix();
          translate(0,-28,0);
          line(0,0,0,-1,-15,-5);
          line(-1,-15,-5,-2.5,-30,-2);
          line(0,0,0,10,-15,0);
          line(10,-15,0,7.5,-30,0);
        popMatrix();
        line(0,0,0,-15,-13,0);
        line(-15,-13,0,-2,-22.5,0);
        line(-2,-22.5,0,-3,-24,0);
        
        line(0,0,0,17.5,-5,0);
        line(17.5,-5,0,24,10,0);
        //pushMatrix();translate(0,10,0);sphere(10);popMatrix();
        translate(0,10,0);sphere(10);
  }
  
  void jumping(){
    translate(0,61,0);
    rotate(3.1415,0,1,0);
    pushMatrix();translate(0,10,0);sphere(10);popMatrix();
    translate(0,-1,0);
    line(0,0,0,0,-30,0);
    
    line(0,0,0,20,5,0);
    line(20,5,0,33,0,0);
    line(0,0,0,-20,6,0);
    line(-20,6,0,-30,-3,0);
    
    translate(0,-30,0);
    line(0,0,0,15,-3,-3);
    line(15,-3,-3,10,-30,-2);
    line(0,0,0,-15,-7,-5);
    line(-15,-7,-5,-3,-13,0);
  }
  
  void walking(){
    translate(0,63,0);
    rotate(radians(180),0,1,0);
    //rotate(radians(180),1,0,0);
  
    line(0,0,0,0,-35,0);
        pushMatrix();
        
          translate(0,-35,0);
          
          line(0,0,0,-2,-15+sin(radians(loopcount*10*sousa))*3,cos(radians(loopcount*10*sousa))*8-8);
          line(-2,-15+sin(radians(loopcount*10*sousa))*3,cos(radians(loopcount*10*sousa))*8-8,-1,-30+cos(radians(loopcount*10*sousa+60))*5,-sin(radians(loopcount*10*sousa))*15+5);
          line(0,0,0,2,-15+sin(radians(loopcount*10*sousa+180))*3,cos(radians(loopcount*10*sousa+180))*8-8);
          line(2,-15+sin(radians(loopcount*10*sousa+180))*3,cos(radians(loopcount*10*sousa+180))*8-8,1,-30+cos(radians(loopcount*10*sousa+240))*5,-sin(radians(loopcount*10*sousa+180))*15+5);
          
        popMatrix();
        line(0,0,0,-20,13,2);
        line(-20,13,2,-4,18,5);
        line(0,0,0,20,13,2);
        line(20,13,2,4,18,5);
        
        pushMatrix();translate(0,10,0);sphere(10);popMatrix();
  }
  
  void kick(){
    translate(0,50,0);
    pushMatrix();translate(0,10,0);sphere(10);popMatrix();
    translate(0,-1,0);
    line(0,0,0,0,-30,0);
    
    line(0,0,0,10,-15,-5);
    line(10,-15,-5,-6,-10,-7);
    line(0,0,0,-15,-8,0);
    line(-15,-8,0,-25,2,0);
    
    translate(0,-30,0);
    line(0,0,0,15,-7,-3);
    line(15,-7,-3,5,-20,-2);
    line(0,0,0,-30,7,0);
  }
  
  public void draw(){
    
    if((type==3)||(jumptime>0)){
      //ジャンプ時の処理はちょっとめんどくさいので
      //こっちに分けて書く
      z=z0-jumptime*jumptime+jumptime*16;
      jumptime++;
      if((z<=Sz)&&(jumptime>=8))jumptime=0;
    }else if(Sz<z){
      z-=2*falltime;
      falltime++;
    }
    
    if(abs(Sz-z)<=5){
      //ellipse(0,0,10,10);
      z=Sz;//誤差は許す 5m。
      falltime=0;
    }
    if((Sz>z)&&(abs(Sz-z)<=16)){
      //沈んでる場合は16mも許しちゃう
      z=Sz;//誤差は許す 5m。
      falltime=0;
    }
    
    translate(x,z,y);
    rotate(radians(angle),0,1,0);
    
    if((jumptime>0)||(falltime>0)){
        jumping();
    }else{
      switch(type){
        case 0:
          standing();
          break;
        case 1:
          walking();
          break;
        case 2:
          rotate(3.14,0,1,0);
          walking();
          break;
        case 4:
          kick();
          actiontime--;
          break;
      }
    }
    type=0;
    if(jumptime>0)type=3;
    if(actiontime>0)type=4;
  } 
}
