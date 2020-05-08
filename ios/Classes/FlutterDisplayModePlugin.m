#import "FlutterDisplayModePlugin.h"
#if __has_include(<flutter_display_mode/flutter_display_mode-Swift.h>)
#import <flutter_displaymode/flutter_displaymode-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_displaymode-Swift.h"
#endif

@implementation FlutterDisplayModePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDisplayModePlugin registerWithRegistrar:registrar];
}
@end
