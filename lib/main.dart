import 'package:flutter/material.dart';
import 'package:nothing_gyro/glpyh.dart';
import 'package:nothing_gyro/tilt.dart';
import 'package:tilt/tilt.dart';

void main() {
  runApp(const MyApp());
}

const thresh = 0.5;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nothing"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nothing Tilt Level',
            style: TextStyle(color: Colors.white, fontFamily: "Nothing"),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black45,
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: StreamBuilder<Tilt>(
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
                        Text(
                          "X: $x",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("Y: $y", style: TextStyle(color: Colors.white)),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
