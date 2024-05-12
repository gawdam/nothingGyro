import 'package:nothing_glyph_interface/nothing_glyph_interface.dart';

void toggleChannels(double x, double y, double thresh) {
  NothingGlyphInterface glyphInterfacePlugin = NothingGlyphInterface();
  if (x.abs() < thresh && y.abs() < thresh) {
    glyphInterfacePlugin.buildGlyphFrame(GlyphFrameBuilder()
        .buildChannel(2)
        .buildChannel(3)
        .buildChannel(4)
        .buildChannel(5)
        .build());
  } else if (x.abs() < thresh) {
    if (y > 0) {
      glyphInterfacePlugin.buildGlyphFrame(
          GlyphFrameBuilder().buildChannel(4).buildChannel(3).build());
    } else {
      glyphInterfacePlugin.buildGlyphFrame(
          GlyphFrameBuilder().buildChannel(2).buildChannel(5).build());
    }
  } else if (y.abs() < thresh) {
    if (x > 0) {
      glyphInterfacePlugin.buildGlyphFrame(
          GlyphFrameBuilder().buildChannel(4).buildChannel(5).build());
    } else {
      glyphInterfacePlugin.buildGlyphFrame(
          GlyphFrameBuilder().buildChannel(2).buildChannel(3).build());
    }
  } else if (x > 0) {
    if (y > 0) {
      glyphInterfacePlugin
          .buildGlyphFrame(GlyphFrameBuilder().buildChannel(4).build());
    } else {
      glyphInterfacePlugin
          .buildGlyphFrame(GlyphFrameBuilder().buildChannel(5).build());
    }
  } else {
    if (y > 0) {
      glyphInterfacePlugin
          .buildGlyphFrame(GlyphFrameBuilder().buildChannel(3).build());
    } else {
      glyphInterfacePlugin
          .buildGlyphFrame(GlyphFrameBuilder().buildChannel(2).build());
    }
  }
  glyphInterfacePlugin.toggle();
}
