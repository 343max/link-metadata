#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(LinkMetadataModule, NSObject)

RCT_EXTERN_METHOD(fetchURLPreview:(NSString)url
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
