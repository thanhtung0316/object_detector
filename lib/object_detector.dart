import 'object_detector_platform_interface.dart';

class ObjectDetector {
  Future<String?> getPlatformVersion() {
    return ObjectDetectorPlatform.instance.getPlatformVersion();
  }

  Future<dynamic> runDetectorOnImage({
    required String modelPath,
    required String imagePath,
    double threshold = .5,
  }) {
    return ObjectDetectorPlatform.instance.runDetectorOnImage(
      modelPath: modelPath,
      imagePath: imagePath,
      threshold: threshold,
    );
  }
}
