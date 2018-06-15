class Point {
  float x;
  float y;

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  Point scaleBy(float sx, float sy) {
    return new Point(this.x * sx, this.y * sy);
  }

  String toString() {
    return "Point: {" + this.x + "," + this.y + "}";
  }
}

class Size {
  float width;
  float height;

  public Size(float width, float height) {
    this.width = width;
    this.height = height;
  }

  /// 
  Size normalized() {
    float d = Math.max(width, height);
    return new Size(width / d, height / d);
  }

  /// Returns a new size that fit in the given size
  Size scaleToFit(Size size) {
    float scale = Math.min(size.width / width, size.height / height);
    return new Size(width * scale, height * scale);
  }

  /// Returns a new size that fill the given size
  Size scaleToFill(Size size) {
    float scale = Math.max(size.width / width, size.height / height);
    return new Size(width * scale, height * scale);
  }

  String toString() {
    return "Size: {" + this.width + "," + this.height + "}";
  }
}

class Rect {
  float x;
  float y;
  float width;
  float height;

  // Initializer
  public Rect(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  public Rect(float x, float y, Size size) {
    this.x = x;
    this.y = y;
    this.width = size.width;
    this.height = size.height;
  }

  /// Getters
  Point topLeft() {
    return new Point(x, y);
  }

  Point topRight() {
    return new Point(x + width, y);
  }

  Point bottomLeft() {
    return new Point(x, y + height);
  }

  Point bottomRight() {
    return new Point(x + width, y + height);
  }

  /// Returns a rect of the specified size centered in this rect.
  Rect centered(Size size) {
    float dx = this.width  - size.width;
    float dy = this.height - size.height;
    return new Rect(x + dx * 0.5, y + dy * 0.5, size.width, size.height);
  }

  /// Description
  String toString() {
    return "{" + this.x + "," + this.y + "," + this.width + "," + this.height + "}";
  }

  String getString() {
    return 
      "x:" + this.x + "," +
      "y:" + this.y + "," +
      "width:" + this.width + "," +
      "height:" + this.height;
  }
}
