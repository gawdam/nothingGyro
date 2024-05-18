import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:stream_transform/stream_transform.dart';

enum OrientationType { level, camera }

Stream<Tilt> getTilt(OrientationType orientationType) {
  return DeviceTilt(
          samplingRateMs: 20,
          initialTilt: const Tilt(0, 0),
          orientation: orientationType)
      .stream;
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

class DeviceTilt {
  final int samplingRateMs;
  final Tilt initialTilt;

  /// A value between 0 and 1 that determines how much of gyroscope and accelerometer data
  /// is added to final [Tilt]. If [filterGain] is 1, [Tilt] will be based entirely of gyroscope data,
  /// while a value of 0 means that [Tilt] is estimated based on accelerometer data only

  final Enum orientation;

  /// Emits current [Tilt] every [samplingRateMs] milliseconds.
  late final Stream<Tilt> stream;

  late Tilt _tilt;

  DeviceTilt({
    this.samplingRateMs = 20,
    this.initialTilt = const Tilt(0, 0),
    this.orientation = OrientationType.level,
    Stream<GyroscopeEvent>? gyroscope,
    Stream<AccelerometerEvent>? accelerometer,
  }) {
    _tilt = initialTilt;
    stream = (accelerometer ?? accelerometerEventStream())
        .buffer(Stream.periodic(Duration(milliseconds: samplingRateMs)))
        .map(
      (listOfPairs) {
        final length = listOfPairs.length;
        var a = AccelerometerEvent(0, 0, 0);
        for (var i = 0; i < length; i++) {
          a += listOfPairs[i];
        }

        a = a / length;

        double roll = 0;
        double pitch = 0;

        switch (orientation) {
          case OrientationType.level:
            roll = atan2(a.y, a.z);
            pitch = atan2(-a.x, a.z);
          case OrientationType.camera:
            roll = atan2(a.y, a.x);
        }

        // complemetary filtered tilt
        _tilt = Tilt(
          roll,
          pitch,
        );
        return _tilt;
      },
    );
  }
}

class Tilt {
  final double xRadian;

  final double yRadian;

  const Tilt(this.xRadian, this.yRadian);

  double get xDegrees => xRadian * 180 / pi;

  double get yDegrees => yRadian * 180 / pi;

  @override
  String toString() => 'Tilt:\nx: $xDegrees\ny: $yDegrees';
}

extension on GyroscopeEvent {
  GyroscopeEvent operator +(GyroscopeEvent other) {
    return GyroscopeEvent(x + other.x, y + other.y, z + other.z);
  }

  GyroscopeEvent operator /(int divider) {
    return GyroscopeEvent(x / divider, y / divider, z / divider);
  }
}

extension on AccelerometerEvent {
  AccelerometerEvent operator +(AccelerometerEvent other) {
    return AccelerometerEvent(x + other.x, y + other.y, z + other.z);
  }

  AccelerometerEvent operator /(int divider) {
    return AccelerometerEvent(x / divider, y / divider, z / divider);
  }
}
