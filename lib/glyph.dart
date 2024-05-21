import 'package:nothing_glyph_interface/nothing_glyph_interface.dart';
import 'package:nothing_gyro/tilt.dart';

class Glyph {
  NothingGlyphInterface glyphInterfacePlugin = NothingGlyphInterface();

  void turnOff() {
    glyphInterfacePlugin.turnOff();
  }

  void toggleChannels(double x, double y, double thresh, bool cameraMode) {
    print("$x, $y, $thresh, $cameraMode");
    if (!cameraMode) {
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
    } else {
      if (x.abs() > 45) {
        if (90 - x.abs() > thresh) {
          if (x > 0)
            glyphInterfacePlugin
                .buildGlyphFrame(GlyphFrameBuilder().buildChannel(1).build());
          else
            glyphInterfacePlugin
                .buildGlyphFrame(GlyphFrameBuilder().buildChannel(0).build());
        } else
          glyphInterfacePlugin.buildGlyphFrame(
              GlyphFrameBuilder().buildChannel(0).buildChannel(1).build());
      } else {
        if (x.abs() > thresh) {
          if (x < 0)
            glyphInterfacePlugin.buildGlyphFrame(
                GlyphFrameBuilder().buildChannelE().buildChannelD().build());
          else
            glyphInterfacePlugin.buildGlyphFrame(
                GlyphFrameBuilder().buildChannel(0).buildChannel(1).build());
        } else
          glyphInterfacePlugin.buildGlyphFrame(GlyphFrameBuilder()
              .buildChannel(0)
              .buildChannel(1)
              .buildChannelE()
              .buildChannelD()
              .build());
      }
    }
    glyphInterfacePlugin.toggle();
  }
}
