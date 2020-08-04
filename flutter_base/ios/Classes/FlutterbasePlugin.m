#import "FlutterbasePlugin.h"
#if __has_include(<flutterbase/flutterbase-Swift.h>)
#import <flutterbase/flutterbase-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterbase-Swift.h"
#endif

@implementation FlutterbasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterbasePlugin registerWithRegistrar:registrar];
}
@end
