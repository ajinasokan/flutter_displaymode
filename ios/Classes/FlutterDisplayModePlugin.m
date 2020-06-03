#import "FlutterDisplayModePlugin.h"

@implementation DisplayModePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.ajinasokan.com/flutter_displaymode"
                                  binaryMessenger:[registrar messenger]];
  DisplayModePlugin* instance = [[DisplayModePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  result(FlutterMethodNotImplemented);
}

@end