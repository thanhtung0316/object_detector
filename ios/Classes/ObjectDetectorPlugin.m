#import "ObjectDetectorPlugin.h"
#if __has_include(<object_detector/object_detector-Swift.h>)
#import <object_detector/object_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "object_detector-Swift.h"
#endif

@implementation ObjectDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftObjectDetectorPlugin registerWithRegistrar:registrar];
}
@end
