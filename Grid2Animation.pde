import processing.video.*;
import java.util.Timer;
import java.util.TimerTask;

public class Grid2Animation implements Animation {

  private int STEPS = 5;
  private float DURATION = 1;
  private Movie movie;
  private int currentStep = 1;

  private Timer timer = new Timer();

  public Grid2Animation(PApplet applet, String filename) {
    this.movie = new Movie(applet, filename);
    this.movie.loop();

    // Set up timer for animation
    TimerTask task = new TimerTask() {
      public void run() {
        playNext();
      }
    };
    timer.scheduleAtFixedRate(task, 1000, (long)(DURATION * 1000));    
  }

  public void start() {
    movie.play();
  }

  public void stop() {
    movie.stop();
  }

  public void display(Rect rect) {

    float w = 1.0 / currentStep;
    float h = 1.0 / currentStep;

    ArrayList<Slot> slots = new ArrayList<Slot>();
    for (int rows = 0; rows < currentStep; rows++) {
      for (int cols = 0; cols < currentStep; cols++) {
        Rect frame = new Rect(rows * w, cols * h, w, h);
        Slot slot = new Slot(frame, color(255, 0, 0), movie);
        slots.add(slot);
      }
    }

    for (int i = 0; i < slots.size(); i ++) {
      Slot slot = slots.get(i);
      slot.display(rect);
    }
  }

  void playNext() {
    currentStep++;
    if (currentStep >= STEPS) {
      currentStep = 1;
    }
  }
}
