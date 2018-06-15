import processing.video.*;
import de.looksgood.ani.*;
import java.util.Timer;
import java.util.TimerTask;

Grid grid;
ArrayList<AniSequence> animations = new ArrayList();
float DURATION = 0.5;
Rect[][] ANIMATION_RECTS = {
  {new Rect(0.00, 0.0, 1.0, 0.25), new Rect(0.0, 0.25, 0.50, 0.75), new Rect(0.50, 0.25, 0.50, 0.75)}, 
  {new Rect(0.00, 0.0, 1.0, 0.50), new Rect(0.0, 0.50, 0.50, 0.50), new Rect(0.50, 0.50, 0.50, 0.50)}, 
  {new Rect(0.50, 0.0, 0.5, 0.25), new Rect(0.0, 0.00, 0.50, 1.00), new Rect(0.50, 0.25, 0.50, 0.75)}, 
  {new Rect(0.75, 0.0, 0.25, 0.25), new Rect(0.0, 0.00, 0.75, 1.00), new Rect(0.75, 0.25, 0.25, 0.75)}      
};
int index = 0;

Timer timer = new Timer();

void setup() {
  // Init ani library
  Ani.init(this);

  size(320, 480, P3D);
  grid = createGrid();

  TimerTask task = new TimerTask() {
    public void run() {
      playNextAnimation();
    }
  };
  timer.scheduleAtFixedRate(task, 1000, (long)(DURATION * 1000));
}

Grid createGrid() {

  ArrayList<Slot> slotList = new ArrayList();

  slotList.add(new Slot(new Rect(0.0, 0.0, 1.0, 0.5), color(255, 0, 0), new Movie(this, "v1.mp4")));
  slotList.add(new Slot(new Rect(0.0, 0.5, 0.5, 0.5), color(0, 255, 0), new Movie(this, "v1.mp4")));
  slotList.add(new Slot(new Rect(0.5, 0.5, 0.5, 0.5), color(0, 0, 255), new Movie(this, "v1.mp4")));

  Slot[] slots = slotList.toArray(new Slot[0]);
  return new Grid(slots);
}

//void setupAnimation(Grid grid) {
//  Rect[][] arrayOfRects = {
//    {new Rect(0.00, 0.0, 1.0, 0.25), new Rect(0.0, 0.25, 0.50, 0.75), new Rect(0.5, 0.25, 0.50, 0.75)}, 
//    {new Rect(0.00, 0.0, 1.0, 0.50), new Rect(0.0, 0.50, 0.50, 0.50), new Rect(0.5, 0.5, 0.50, 0.50)}, 
//    {new Rect(0.50, 0.0, 0.5, 0.25), new Rect(0.0, 0.00, 0.50, 1.00), new Rect(0.5, 0.25, 0.50, 0.75)}, 
//    {new Rect(0.75, 0.0, 0.25, 0.25), new Rect(0.0, 0.5, 0.75, 1.00), new Rect(0.75, 0.25, 0.25, 0.75)}      
//  };
//  float duration = 0.5;
//  for (Rect[] rects : arrayOfRects) {
//    AniSequence seq = new AniSequence(this);
//    seq.beginSequence();
//    seq.beginStep();
//    for (int i = 0; i < rects.length; i++) {
//      Slot slot = grid.slots[i];
//      Rect rect = rects[i];
//      Ani[] anis = Ani.to(slot.rect, duration, rect.getString());
//      seq.add(anis);
//    }
//    seq.endStep();
//    seq.endSequence();    
//    animations.add(seq);
//  }
//}

void draw() {
  background(255);
  stroke(0);

  for (int i = 0; i < grid.slots.length; i ++) {
    Slot slot = grid.slots[i];
    slot.display(new Rect(0, 0, width, height));
  }
}

void playAnimation(int idx) {
  AniSequence seq = new AniSequence(this);
  Rect[] rects = ANIMATION_RECTS[idx];
  seq.beginSequence();
  seq.beginStep();
  for (int i = 0; i < rects.length; i++) {
    Slot slot = grid.slots[i];
    Rect rect = rects[i];
    Ani[] anis = Ani.to(slot.rect, DURATION, rect.getString());
    seq.add(anis);
  }
  seq.endStep();
  seq.endSequence();
  seq.start();
}

void playNextAnimation() {
  playAnimation(index);
  index++;
  if (index >= ANIMATION_RECTS.length) {
    index = 0;
  }
}

void mouseReleased() {
  playAnimation(index);
  index++;
  if (index >= ANIMATION_RECTS.length) {
    index = 0;
  }
}

void movieEvent(Movie m) {
  m.read();
}
