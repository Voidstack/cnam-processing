public class Tableau {
  private final MainApp main;

  public UnionType unionType = UnionType.UNION_LISSE;

  // Liste des formes à dessiner
  private final ArrayList<SDFShape> shapes = new ArrayList<>();

  public Tableau(MainApp main) {
    this.main = main;

    reset();
  }

  public void reset() {
    shapes.clear();
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{-.1f, .1f, .15f}, color(50, 50, 255)));
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{0f, -.1f, .15f}, color(255, 255, 255)));
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{.1f, .1f, .15f}, color(255, 50, 50)));
  }

  void draw() {
    main.loadPixels();

    int w = main.width;
    int h = main.height;
    if (main.pixels.length != w * h) return;

    // Si aucune shape, remplir avec du noir (ou transparent)
    if (shapes.isEmpty()) {
      for (int i = 0; i < main.pixels.length; i++) {
        main.pixels[i] = color(0); // noir
      }
      main.updatePixels();
      return;
    }

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        int i = x + y * w;
        float px = (x - w/2f) / (float)h;
        float py = (y - h/2f) / (float)h;
        // Initialize with first shape
        float d = shapes.get(0).compute(px, py);
        color c = shapes.get(0).myColor;
        // Combine all shapes with color blending
        for (int s = 1; s < shapes.size(); s++) {
          SDFShape shape = shapes.get(s);
          float d2 = shape.compute(px, py);
          // Blend factor for smooth union
          float k = main.lissage;
          float t = constrain(0.5f + 0.5f * (d2 - d) / k, 0.0f, 1.0f);
          // Blend colors
          c = lerpColor(c, shape.myColor, 1.0f - t);
          // Apply union
          d = unionType.apply(d, d2, main.lissage);
        }
        // Shading based on final distance
        float shade = map(d, -0.01f, 0.01f, 1, 0);
        shade = constrain(shade, 0, 1);
        main.pixels[i] = color(
          red(c) * shade,
          green(c) * shade,
          blue(c) * shade
          );
      }
    }
    main.updatePixels();
  }
}
