import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nothing_gyro/axisPainter.dart';
import 'package:nothing_gyro/glpyh.dart';
import 'package:nothing_gyro/tilt.dart';
import 'package:tilt/tilt.dart' as tlt;
import 'package:flutter_tilt/flutter_tilt.dart';

void main() {
  runApp(const MyApp());
}

const thresh = 0.5;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "NothingFont"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NOTHING LEVEL',
            style: TextStyle(
                color: Colors.white, fontFamily: "NothingFont", fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black45,
        body: Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: AxesPainter(),
                  ),
                ),
                Center(
                  child: StreamBuilder<tlt.Tilt>(
                    stream: getTilt(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        double x = transformAngle(snapshot.data!.xDegrees);
                        double y = transformAngle(snapshot.data!.yDegrees);
                        toggleChannels(x, y, thresh);
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
                                          color: Colors.white, fontSize: 24),
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
                                              fontSize: 24),
                                        )
                                      : Container(),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 200,
                                  height: 400,
                                  child: Tilt(
                                    borderRadius: BorderRadius.circular(24),
                                    tiltConfig: const TiltConfig(
                                        angle: 30,
                                        enableGestureTouch: false,
                                        enableSensorRevert: false,
                                        sensorFactor: 10,
                                        enableReverse: true),
                                    lightConfig: const LightConfig(
                                        minIntensity: 0.1,
                                        enableReverse: true,
                                        disable: true),
                                    shadowConfig: const ShadowConfig(
                                        minIntensity: 0.05,
                                        maxIntensity: 0.4,
                                        offsetFactor: 0.08,
                                        minBlurRadius: 10,
                                        maxBlurRadius: 15,
                                        enableReverse: true),
                                    child: Image.asset(
                                        'assets/images/NPfront.png'),
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
                                          ),
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
                                          color: Colors.white, fontSize: 24),
                                    )
                                  : Container(),
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
