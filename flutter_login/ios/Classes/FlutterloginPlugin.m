#import "FlutterloginPlugin.h"
#if __has_include(<flutterlogin/flutterlogin-Swift.h>)
#import <flutterlogin/flutterlogin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterlogin-Swift.h"
#endif

@implementation FlutterloginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterloginPlugin registerWithRegistrar:registrar];
}
@end
