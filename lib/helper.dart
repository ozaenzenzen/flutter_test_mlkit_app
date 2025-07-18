import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class Helper {
  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (var plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static ByteData concatenatePlanesByteData(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (var plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done();
  }

  static List<ByteData> concatenatePlanesByteData2(List<Plane> planes) {
    List<ByteData> conv = planes.map((e) {
      return ByteData.view(e.bytes.buffer);
    }).toList();

    return conv;

    // List<Uint8List> conv = planes.map((e) {
    //   return e.bytes;
    // }).toList();

    // final WriteBuffer allBytes = WriteBuffer();
    // for (var plane in conv) {
    //   allBytes.putUint8List(plane);
    // }
    // return [allBytes.done()];
  }

  Future<XFile?> takePicture(CameraController? cameraController) async {
    try {
      final CameraController? controller = cameraController;
      if (controller == null || !controller.value.isInitialized) {
        return null;
      }

      if (controller.value.isTakingPicture) {
        return null;
      }

      XFile file = await controller.takePicture();
      return file;
    } on CameraException {
      return null;
    }
  }
}
