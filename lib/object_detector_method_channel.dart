import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'object_detector_platform_interface.dart';

/// An implementation of [ObjectDetectorPlatform] that uses method channels.
class MethodChannelObjectDetector extends ObjectDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('object_detector');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<dynamic> runDetectorOnImage(
      {required String modelPath, required String imagePath}) async {
    final result = await methodChannel
        .invokeMethod('run_on_image', [modelPath, imagePath]);
    return result;
  }
}
