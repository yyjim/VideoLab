import processing.video.*;
import de.looksgood.ani.*;
import java.util.Timer;
import java.util.TimerTask;

public class GridAnimation implements Animation {

  private PApplet applet;
  private Grid grid;
  private float DURATION = 1;
  private ArrayList<Movie> movies = new ArrayList<Movie>();

  Rect[][] ANIMATION_RECTS = {
    // A, B, C
    {new Rect(0.00, 0.00, 1.00, 1.00), new Rect(0.00, 1.00, 0.50, 0.50), new Rect(0.50, 1.00, 0.50, 0.50)}, 
    {new Rect(0.00, 0.00, 1.00, 0.50), new Rect(0.00, 0.50, 0.50, 0.50), new Rect(0.50, 0.50, 0.50, 0.50)}, 
    {new Rect(0.00, -0.5, 1.00, 0.50), new Rect(0.00, 0.00, 0.50, 1.00), new Rect(0.50, 0.00, 0.50, 1.00)}, 
    {new Rect(-1.5, 0.50, 1.00, 0.50), new Rect(0.00, 0.00, 0.50, 0.50), new Rect(0.50, 0.00, 0.50, 0.50)}, 
    {new Rect(0.00, 0.50, 1.00, 0.50), new Rect(0.00, 0.00, 0.50, 0.50), new Rect(0.50, 0.00, 0.50, 0.50)}, 
    {new Rect(0.00, 0.00, 1.00, 1.00), new Rect(0.00, -0.5, 0.50, 0.50), new Rect(0.50, -0.5, 0.50, 0.50)}, 
  };

  private int index = 0;
  Timer timer = new Timer();

  public GridAnimation(PApplet applet) {
    this.applet = applet;

    movies.add(new Movie(applet, "json1.mp4"));
    movies.add(new Movie(applet, "json1.mp4")); 
    movies.add(new Movie(applet, "json1.mp4")); 

    // Create grid
    ArrayList<Slot> slotList = new ArrayList();

    slotList.add(new Slot(ANIMATION_RECTS[0][0], color(255, 0, 0), movies.get(0)));
    slotList.add(new Slot(ANIMATION_RECTS[0][1], color(0, 255, 0), movies.get(1)));
    slotList.add(new Slot(ANIMATION_RECTS[0][2], color(0, 0, 255), movies.get(2)));

    Slot[] slots = slotList.toArray(new Slot[0]);
    grid = new Grid(slots);

    for (Movie m : movies) {
      m.loop();
      //movie.jump(random(movie.duration()));
    }

    // Set up timer for animation
    TimerTask task = new TimerTask() {
      public void run() {
        playNextAnimation();
      }
    };
    timer.scheduleAtFixedRate(task, 1000, (long)(DURATION * 1000));
  }

  public void start() {
    for (Movie m : movies) {
      m.play();
      //movie.jump(random(movie.duration()));
    }
  }

  public void stop() {
    for (Movie m : movies) {
      m.stop();
    }
  }

  public void display(Rect rect) {

    for (int i = 0; i < grid.slots.length; i ++) {
      Slot slot = grid.slots[i];
      slot.display(rect);
    }
  }

  void playAnimation(int idx) {
    AniSequence seq = new AniSequence(applet);
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
}
