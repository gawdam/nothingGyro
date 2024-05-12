import 'package:tilt/tilt.dart';

Stream<Tilt> getTilt() {
  return DeviceTilt(
    samplingRateMs: 20,
    initialTilt: const Tilt(0, 0),
    filterGain: 1,
  ).stream;
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
