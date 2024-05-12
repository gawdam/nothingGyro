import 'package:flutter/material.dart';
import 'package:nothing_glyph_interface/nothing_glyph_interface.dart';
import 'package:tilt/tilt.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

double transformAngle(double angle) {
  if (angle < -90) {
    return (180 + angle);
  }
  if (angle > 90) {
    return (angle - 180);
  }
  return angle;
}

void toggleChannels(double x, double y) {
  NothingGlyphInterface glyphInterfacePlugin = NothingGlyphInterface();
  if (x > 0) {
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nothing Tilt Level'),
        ),
        body: Center(
          child: StreamBuilder<Tilt>(
            stream: DeviceTilt(
              samplingRateMs: 20,
              initialTilt: const Tilt(0, 0),
              filterGain: 0.7,
            ).stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                double x = transformAngle(snapshot.data!.xDegrees);
                double y = transformAngle(snapshot.data!.yDegrees);
                toggleChannels(x, y);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("X: $x"),
                    Text("Y: $y"),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
