ArrayList<Flue> flueListe = new ArrayList<Flue>(); // laver en arrayliste
float flysize = 0;

void setup(){
  size(500,500); //størrelsen på vinduet
}

void draw(){
     clear();
  for(int i=0; i<flueListe.size(); i++){ //et for-loop der køre lige så længe der er fluer
    Flue f = flueListe.get(i); //henter fluer fra classen
    f.tegnFlue(); //tegner fluer
    f.flyt(); //flytter på fluen
  }
}

void keyPressed(){
  if(key == 'e'){
    flysize = 10;
  }
  flueListe.add(new Flue(flysize)); //tilføjer ny flue til flue listen 
  flysize = 0;
}

void mousePressed(){
  flueListe.add(new Flue(mouseX, mouseY, flysize)); //her tilføjer den både en ny flue til listen og fortæller hvor den skal være henne
}

/////////////////////////////////////////////////////////
class Flue{
  
  //variabler
  float positionX,positionY; 
  float distanceFlyttet;
  float vinkel   = 0; 
  float fluesize = 0;
  float x, y = 0;
  float speed = 0.6;
  
  //krunstruktør der laver fluer et random steder på skærmen
  Flue(float s){
    positionX  = random(0,height);
    positionY  = random(0,width);
    vinkel     = random(0,2*PI);
    fluesize   = s;
  }
  
  //kronstruktør der laver en flue udfra musens position 
  Flue(float a, float b, float s){
    positionX = a;
    positionY = b;
    vinkel    = random(0,2*PI);
    fluesize  = s;
  }
  
 
  //bruges til at flytte fluen, ved at flytte dens koordinat
  void flyt(){
    distanceFlyttet = distanceFlyttet + speed;
    if (cos(vinkel) * (distanceFlyttet * fluesize) + positionX > width ||
      (cos(vinkel) * (distanceFlyttet * fluesize) + positionX < 0)) {
      speed = speed * -1; 
      distanceFlyttet = 0;
      vinkel += PI;
    }
    if ((sin(vinkel) * (distanceFlyttet * fluesize)  + positionY) > height ||
      (sin(vinkel) * (distanceFlyttet * fluesize)  + positionY) < 0) {
      speed = speed * -1; 
      distanceFlyttet = 0;
      vinkel += PI;
    }
  }
  

//gemmer koordinatsystemet, drejer koordinatsystemet, og tegner derefter fluen på det nye og gendanner det gamle koordinatsystem
  void tegnFlue(){
    pushMatrix();
      translate(positionX,positionY);
      rotate(vinkel);
      translate(distanceFlyttet,0);
        scale(1+fluesize/10);
        ellipse(x,y,20,8);
        ellipse(x,y-8,15,10);
        ellipse(x,y+8,15,10);
        ellipse(x+6,y,8,8);
    popMatrix();
  } 
}
