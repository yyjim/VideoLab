import processing.video.*;
import de.looksgood.ani.*;

ArrayList<Animation> animations = new ArrayList<Animation>();
int index = 0;

void setup() {
  // Init ani library
  Ani.init(this);

  // Set up canvas
  size(320, 480, P3D);
  
  // Set up animations
  animations.add(new GridAnimation(this));
  animations.add(new Grid2Animation(this, "json1.mp4"));
  
  animations.get(0).start();
}

void draw() {
  background(255);
  stroke(0);

  Animation animation = animations.get(index);
  animation.display(new Rect(0, 0, width, height));
}

// I/O callbacks

void mouseReleased() {
  // Stop current animation
  Animation ani = animations.get(index);
  ani.stop();
  
  index++;
  if (index >= animations.size()) {
    index = 0;
  }
  
  // Start new animation
  Animation newAni = animations.get(index);
  newAni.start();
}

// Movie callbacks
void movieEvent(Movie m) {
  m.read();
}
