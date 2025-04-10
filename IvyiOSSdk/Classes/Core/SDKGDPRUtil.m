//
//  SDKGDPRUtil.m
//  IvyiOSSdk
//
//  Created by ivy on 2024/9/19.
//

#import <IvyiOSSdk/SDKGDPRUtil.h>
#import <UserMessagingPlatform/UserMessagingPlatform.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <IvyiOSSdk/SDKFacade.h>

@implementation SDKGDPRUtil

+ (void)setupGDPR:(BOOL)priorityLocalGuide vc:(UIViewController *)vc
{
    if (priorityLocalGuide) {
        if (@available(iOS 14, *)) {
            ATTrackingManagerAuthorizationStatus status = [ATTrackingManager trackingAuthorizationStatus];
            if (status == ATTrackingManagerAuthorizationStatusDenied || status == ATTrackingManagerAuthorizationStatusRestricted) {
                //[[SDKFacade sharedInstance] callInitAd];
                [SDKGDPRUtil checkAdmobGDPR:vc];
            } else if (status == ATTrackingManagerAuthorizationStatusAuthorized){
//                [self checkAdmobGDPR:vc];
                [SDKGDPRUtil checkAdmobGDPR:vc];
            } else if (status == ATTrackingManagerAuthorizationStatusNotDetermined){
                [[SDKFacade sharedInstance] callClientRequestATT];
            }
        } else {
            // Fallback on earlier versions
            [SDKGDPRUtil checkAdmobGDPR:vc];
        }
    } else {
        [SDKGDPRUtil checkAdmobGDPR:vc];
    }
}

+ (void)checkAdmobGDPR:(UIViewController *)vc
{
    
    [[SDKFacade sharedInstance] callInitAd];
    return;
    
    if ([UMPConsentInformation.sharedInstance canRequestAds]) {
        [[SDKFacade sharedInstance] callInitAd];
        return;
    }
//    UMPRequestParameters *parameter = [[UMPRequestParameters alloc] init];
//    parameter.tagForUnderAgeOfConsent = FALSE;
//    UMPDebugSettings *debugSettings = [[UMPDebugSettings alloc] init];
//    debugSettings.geography = UMPDebugGeographyNotEEA;
//    parameter.debugSettings = debugSettings;
    [UMPConsentInformation.sharedInstance requestConsentInfoUpdateWithParameters:nil completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"gdpr request error::%@", error.localizedDescription);
            if ([UMPConsentInformation.sharedInstance canRequestAds]) {
                [[SDKFacade sharedInstance] callInitAd];
                return;
            }
            return;
        }
        [UMPConsentForm loadAndPresentIfRequiredFromViewController:vc completionHandler:^(NSError * _Nullable error) {
            if ([UMPConsentInformation.sharedInstance canRequestAds]) {
                [[SDKFacade sharedInstance] callInitAd];
            }
        }];
    }];
   
}

@end
