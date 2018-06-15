import processing.video.*;

class Grid {
  Slot[] slots;  

  public Grid(Slot[] slots) {
    this.slots = slots;
  }
}

class Slot {
  Rect rect;
  color backgroundColor;
  Movie movie; 

  public Slot(Rect rect, color backgroundColor, Movie movie) {
    this.rect = rect;
    this.backgroundColor = backgroundColor;
    this.movie = movie;

    this.movie.play();
    this.movie.loop();
  }

  void vertext(Point vertex, Point uv) {
    vertex(vertex.x, vertex.y, uv.x, uv.y);
  }

  void display(Rect bounds) {
    float sx = bounds.width;
    float sy = bounds.height;
    fill(backgroundColor);
    rect(rect.x * sx, rect.y * sy, rect.width * sx, rect.height * sy);

    Rect frame = new Rect(rect.x * sx, rect.y * sy, rect.width * sx, rect.height * sy);
    textureMode(NORMAL);
    beginShape();
    texture(movie);

    // Calculate UV 
    Size movieSize = new Size(movie.width, movie.height).normalized();
    Size slotSize = new Size(rect.width * sx, rect.height * sy).normalized();
    movieSize = movieSize.scaleToFill(slotSize);
    Rect uvRect = new Rect(0, 0, movieSize).centered(slotSize);
    
    // top-left
    Point vTL = frame.topLeft();
    Point uvTL = uvRect.topLeft().scaleBy(1 / movieSize.width, 1 / movieSize.height);
    vertext(vTL, uvTL);
    
    // top-right
    Point vTR = frame.topRight();
    Point uvTR = uvRect.topRight().scaleBy(1 / movieSize.width, 1 / movieSize.height);
    vertext(vTR, uvTR);
    
    // bottom-right
    Point vBR = frame.bottomRight();
    Point uvBR = uvRect.bottomRight().scaleBy(1 / movieSize.width, 1 / movieSize.height);
    vertext(vBR, uvBR);
    
    // bottom-left
    Point vBL = frame.bottomLeft();
    Point uvBL = uvRect.bottomLeft().scaleBy(1 / movieSize.width, 1 / movieSize.height);
    vertext(vBL, uvBL);
    
    endShape();
  }
}
