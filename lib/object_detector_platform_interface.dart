import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'object_detector_method_channel.dart';

abstract class ObjectDetectorPlatform extends PlatformInterface {
  /// Constructs a ObjectDetectorPlatform.
  ObjectDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static ObjectDetectorPlatform _instance = MethodChannelObjectDetector();

  /// The default instance of [ObjectDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelObjectDetector].
  static ObjectDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ObjectDetectorPlatform] when
  /// they register themselves.
  static set instance(ObjectDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<dynamic> runDetectorOnImage({
    required String modelPath,
    required String imagePath,
    double? threshold,
  }) {
    throw UnimplementedError('runDetectorOnImage() has not been implemented.');
  }
}
