//
//  SDKAppsflyerInit.m
//  Bolts
//
//  Created by 余冰星 on 2017/10/24.
//

#import "SDKAppsflyerInit.h"
#import <IvyiOSSdk/SDKCache.h>
#import <IvyiOSSdk/SDKFacade.h>
@implementation SDKAppsflyerInit
-(void)doInit:(NSDictionary *)data onComplete:(nullable dispatch_block_t)onComplete
{
    @try {
        DLog(@"%@", @"[init] init Appsflyer");
        NSString *key = [data valueForKey:@"key"];
        if(key) {
            NSString *appid = [data valueForKey:@"appid"];
            [AppsFlyerLib shared].appsFlyerDevKey = key;
            [AppsFlyerLib shared].appleAppID = appid;
            [AppsFlyerLib shared].delegate = self;
            NSString* inviteTemplateId = [data valueForKey:@"af.invite.template.id"];
            if (inviteTemplateId) {
                [AppsFlyerLib shared].appInviteOneLinkID =  inviteTemplateId;
                [AppsFlyerLib shared].deepLinkDelegate = self;
            }
            
#if DEBUG
            [AppsFlyerLib shared].isDebug = true;
            [AppsFlyerLib shared].useReceiptValidationSandbox = true;
            [AppsFlyerLib shared].useUninstallSandbox = NO;
#endif
            
            DLog(@"[init] Appsflyer init success, id = %@", key);
            if (onComplete) {
                onComplete();
            }
        } else {
            DLog(@"[init] Appsflyer init failure, please see the default.json analyse config.");
        }
    } @catch (NSException *exception) {
        DLog(@"[init] Appsflyer: %@", exception.description);
    } @finally {
    }
}
#pragma mark -
#pragma mark delegate
- (void)onConversionDataReceived:(NSDictionary *)installData
{
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        DLog(@"This is a none organic install. Media source: %@  Campaign: %@",sourceID,campaign);
    } else if([status isEqualToString:@"Organic"]) {
        DLog(@"This is an organic install.");
    }
}

- (void)onConversionDataRequestFailure:(NSError *)error
{
    DLog(@"%@",error);
}

- (void)onAppOpenAttribution:(NSDictionary *)attributionData
{
}

- (void)onAppOpenAttributionFailure:(NSError *)error
{
}

- (void)onConversionDataFail:(nonnull NSError *)error {
}

- (void)onConversionDataSuccess:(nonnull NSDictionary *)conversionInfo {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        for (id key in conversionInfo) {
            id value = [conversionInfo objectForKey:key];
            if (value) {
                [dict setObject:value forKey:key];
            }
        }
        [[SDKFacade sharedInstance] logEventToParfka:@"sdk_af_conversion" withData:dict];
    });
}

- (void)didResolveDeepLink:(AppsFlyerDeepLinkResult *)result
{
    @try {
        if (result.status == AFSDKDeepLinkResultStatusNotFound) {
            NSLog(@"Appsflyer DeepLink not found");
        } else if(result.status == AFSDKDeepLinkResultStatusFailure){
            NSLog(@"Appsflyer DeepLink failure");
        } else if(result.status == AFSDKDeepLinkResultStatusFound){
            NSLog(@"Appsflyer DeepLink found");
            NSString* inviteUserId = [result.deepLink.clickEvent objectForKey:@"deep_link_sub1"];
            if (inviteUserId != nil) {
                NSString* af_invite_current_user_id = (NSString *)[[SDKCache cache] objectForKey:@"af_invite_current_user_id"];
                if (af_invite_current_user_id != nil && inviteUserId == af_invite_current_user_id) {
                    NSLog(@"Appsflyer DeepLink can not invite your self");
                } else {
                    NSString* af_invite_app_id = [result.deepLink.clickEvent objectForKey:@"deep_link_sub2"];
                    if (af_invite_app_id != nil) {
                        inviteUserId = [NSString stringWithFormat:@"%@|%@", inviteUserId, af_invite_app_id];
                    }
                    [[SDKCache cache] setObject:inviteUserId forKey:@"af_invite_id"];
                }
            } else {
                NSLog(@"Appsflyer DeepLink no invite user id found");
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Appsflyer DeepLink err:%@", exception);
    }
}

@end
