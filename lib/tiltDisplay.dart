import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart' as imgTilt;
import 'package:nothing_gyro/glpyh.dart';
import 'package:nothing_gyro/tilt.dart';

class TiltDisplay extends StatelessWidget {
  TiltDisplay({
    super.key,
    required this.x,
    required this.y,
    required this.orientation,
    required this.glyphEnabled,
  });

  double x;
  double y;
  Enum orientation = OrientationType.level;
  bool glyphEnabled;

  Glyph glyph = Glyph();

  @override
  Widget build(BuildContext context) {
    if (glyphEnabled) {
      glyph.toggleChannels(x, y, 0.5, orientation);
    } else {
      glyph.turnOff();
    }
    if (orientation == OrientationType.level)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: x < 0
                ? Text(
                    "${x.abs().toStringAsFixed(1)}°",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Ntype82"),
                  )
                : Container(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                alignment: Alignment.centerRight,
                child: y < 0
                    ? Text(
                        "${y.abs().toStringAsFixed(1)}°",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Ntype82"),
                      )
                    : Container(),
              ),
              SizedBox(width: 10),
              Container(
                width: 130,
                height: 300,
                child: imgTilt.Tilt(
                  borderRadius: BorderRadius.circular(24),
                  tiltConfig: const imgTilt.TiltConfig(
                      angle: 30,
                      enableGestureTouch: false,
                      enableSensorRevert: false,
                      sensorFactor: 10,
                      enableReverse: true),
                  lightConfig: const imgTilt.LightConfig(
                      minIntensity: 0.1, enableReverse: true, disable: true),
                  shadowConfig: const imgTilt.ShadowConfig(
                      minIntensity: 0.05,
                      maxIntensity: 0.4,
                      offsetFactor: 0.08,
                      minBlurRadius: 10,
                      maxBlurRadius: 15,
                      enableReverse: true),
                  child: Image.asset('assets/images/NPfront.png'),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 70, // Fixed width
                alignment: Alignment.centerLeft,
                child: y > 0
                    ? Text(
                        "${y.toStringAsFixed(1)}°",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Ntype82"),
                      )
                    : Container(),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 50, // Fixed height
            child: x > 0
                ? Text(
                    "${x.toStringAsFixed(1)}°",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Ntype82"),
                  )
                : Container(),
          ),
        ],
      );
    return Text(
      "x = ${x.toString()}, y = ${y.toString()}",
      style: TextStyle(color: Colors.white),
    );
  }
}
