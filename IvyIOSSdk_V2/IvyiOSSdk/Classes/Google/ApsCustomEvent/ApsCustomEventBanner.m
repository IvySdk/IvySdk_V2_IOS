//
// Copyright (C) 2015 Google, Inc.
//
// SampleCustomEventBanner.m
// Sample Ad Network Custom Event
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "ApsCustomEventBanner.h"
#include <stdatomic.h>
#import "ApsCustomEventConstants.h"
#import "ApsCustomEventUtils.h"
#import <Foundation/Foundation.h>

@interface ApsCustomEventBanner()<DTBAdCallback, GADMediationBannerAd, DTBAdBannerDispatcherDelegate> {
  /// The sample banner ad.
    UIView* uiView;

  /// The completion handler to call when the ad loading succeeds or fails.
  GADMediationBannerLoadCompletionHandler _loadCompletionHandler;

  /// The ad event delegate to forward ad rendering events to the Google Mobile Ads SDK.
  id<GADMediationBannerAdEventDelegate> _adEventDelegate;
}

@end

@implementation ApsCustomEventBanner

- (void)loadBannerForAdConfiguration:(GADMediationBannerAdConfiguration *)adConfiguration
                   completionHandler:(GADMediationBannerLoadCompletionHandler)completionHandler {
  __block atomic_flag completionHandlerCalled = ATOMIC_FLAG_INIT;
  __block GADMediationBannerLoadCompletionHandler originalCompletionHandler =
      [completionHandler copy];

  _loadCompletionHandler = ^id<GADMediationBannerAdEventDelegate>(
      _Nullable id<GADMediationBannerAd> ad, NSError *_Nullable error) {
    // Only allow completion handler to be called once.
    if (atomic_flag_test_and_set(&completionHandlerCalled)) {
      return nil;
    }

    id<GADMediationBannerAdEventDelegate> delegate = nil;
    if (originalCompletionHandler) {
      // Call original handler and hold on to its return value.
      delegate = originalCompletionHandler(ad, error);
    }

    // Release reference to handler. Objects retained by the handler will also be released.
    originalCompletionHandler = nil;

    return delegate;
  };

    NSString *adUnit = adConfiguration.credentials.settings[@"parameter"];
    if (adUnit) {
        DTBAdSize* adSize = [[DTBAdSize alloc] initBannerAdSizeWithWidth:320 height:50 andSlotUUID:adUnit];
        DTBAdLoader* adLoader = [DTBAdLoader new];
        [adLoader setSizes:adSize, nil];
        [adLoader loadAd:self];
    } else {
        NSError* error = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdLoadedError, @"invalid adunit");
        _adEventDelegate = _loadCompletionHandler(nil, error);
    }
}

#pragma mark GADMediationBannerAd implementation

- (nonnull UIView *)view {
    return uiView;
}


- (void)onSuccess:(DTBAdResponse *)adResponse { 
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0f, 50.0f);
    DTBAdBannerDispatcher* dispatcher = [[DTBAdBannerDispatcher alloc] initWithAdFrame:rect delegate:self];
}

- (void)onFailure:(DTBAdError)error {
    NSError* err = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdNotLoaded, @"load failed");
    _adEventDelegate = _loadCompletionHandler(nil, err);
}

- (void)adDidLoad:(UIView * _Nonnull)adView { 
    uiView = adView;
    _adEventDelegate = _loadCompletionHandler(self, nil);
}

- (void)adFailedToLoad:(UIView * _Nullable)banner errorCode:(NSInteger)errorCode {
    if (_adEventDelegate) {
        NSError* err = ApsCustomEventErrorWithCodeAndDescription(errorCode, @"load failed");
        _adEventDelegate = _loadCompletionHandler(nil, err);
    }
}

- (void)bannerWillLeaveApplication:(nonnull UIView *)adView { 
    if (_adEventDelegate) {
        [_adEventDelegate reportClick];
    }
}

- (void)impressionFired {
    if (_adEventDelegate) {
        [_adEventDelegate reportImpression];
    }
}

@end
