public class Tableau {
  private final MainApp ctx; // le context

  public UnionType unionType = UnionType.UNION_LISSE;

  // Liste des formes à dessiner
  private final ArrayList<SDFShape> shapes = new ArrayList<>();

  public Tableau(MainApp ctx) {
    this.ctx = ctx;

    reset();
  }

  // Simple fonction reset
  // Bien regarder de quoi sont composer les objects.
  public void reset() {
    shapes.clear();
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{-.1f, .1f, .15f}, color(50, 50, 255)));
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{0f, -.1f, .15f}, color(255, 255, 255)));
    shapes.add(new SDFShape(SDFType.CIRCLE, new float[]{.1f, .1f, .15f}, color(255, 50, 50)));
  }

  // fonction draw à lancer dans le draw du ctx principale
  void draw() {
    ctx.loadPixels();

    int w = ctx.width;
    int h = ctx.height;
    if (ctx.pixels.length != w * h) return; // éviter les pb en cas de redimensionnement de la fenêtre

    // Si aucune shape, remplir avec du noir (ou transparent)
    if (shapes.isEmpty()) {
      for (int i = 0; i < ctx.pixels.length; i++) {
        ctx.pixels[i] = color(0); // noir
      }
      ctx.updatePixels();
      return;
    }

    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        int i = x + y * w;
        float px = (x - w/2f) / (float)h;
        float py = (y - h/2f) / (float)h;
        // Init avec la première shape
        float d = shapes.get(0).compute(px, py);
        color c = shapes.get(0).myColor;
        // Toutes les shapes avec color blending
        for (int s = 1; s < shapes.size(); s++) {
          SDFShape shape = shapes.get(s);
          float d2 = shape.compute(px, py);
          // Blend factor for smooth union
          float k = ctx.lissage;
          float t = constrain(0.5f + 0.5f * (d2 - d) / k, 0.0f, 1.0f);
          // Blend colors
          c = lerpColor(c, shape.myColor, 1.0f - t);
          // Apply union
          d = unionType.apply(d, d2, ctx.lissage);
        }
        // Shading
        float shade = map(d, -0.01f, 0.01f, 1, 0);
        shade = constrain(shade, 0, 1);
        ctx.pixels[i] = color(
          red(c) * shade,
          green(c) * shade,
          blue(c) * shade
          );
      }
    }
    ctx.updatePixels();
  }
}
