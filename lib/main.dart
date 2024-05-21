import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nothing_gyro/axisPainter.dart';
import 'package:nothing_gyro/glpyh.dart';
import 'package:nothing_gyro/tilt.dart';
import 'package:nothing_gyro/tiltDisplay.dart';

void main() {
  runApp(const MyApp());
}

const thresh = 0.5;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _glyphEnabled = true;
  bool _cameraMode = false;

  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Color(0xffD71921);
      }
      // Material color when switch is disabled.
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      // Otherwise return null to set default material color
      // for remaining states such as when the switch is
      // hovered, or focused.
      return null;
    },
  );
  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Track color when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Color(0xffD71921);
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "NDot"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NOTHING LEVEL',
            style: TextStyle(
                color: Colors.white, fontFamily: "NDot", fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black45,
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Color(0xff1B1B1D),
                      border: Border.all(
                        color: Color(0xffD71921),
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Glpyh",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Ntype82"),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Switch(
                              thumbColor: const MaterialStatePropertyAll<Color>(
                                  Colors.black),
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              value: _glyphEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _glyphEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Camera mode",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Ntype82"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Switch(
                              thumbColor: const MaterialStatePropertyAll<Color>(
                                  Colors.black),
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              value: _cameraMode,
                              onChanged: (value) {
                                setState(() {
                                  _cameraMode = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 550,
                    decoration: BoxDecoration(
                      color: Color(0xff1B1B1D),
                      border: Border.all(
                        color: Color(0xffD71921),
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: AxesPainter(),
                          ),
                        ),
                        Center(
                          child: StreamBuilder(
                            stream: getTilt(_cameraMode
                                ? OrientationType.camera
                                : OrientationType.level),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                double x =
                                    transformAngle(snapshot.data!.xDegrees);
                                double y =
                                    transformAngle(snapshot.data!.yDegrees);

                                return TiltDisplay(
                                    x: x,
                                    y: y,
                                    glyphEnabled: _glyphEnabled,
                                    orientation: _cameraMode
                                        ? OrientationType.camera
                                        : OrientationType.level);
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
