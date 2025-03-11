//
// Copyright (C) 2015 Google, Inc.
//
// SampleCustomEventInterstitial.m
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

#import "ApsCustomEventInterstitial.h"
#include <stdatomic.h>
#import "ApsCustomEventConstants.h"
#import "ApsCustomEventUtils.h"

#import <Foundation/Foundation.h>

@interface ApsCustomEventInterstitial()<DTBAdCallback, GADMediationInterstitialAd, DTBAdInterstitialDispatcherDelegate> {
  /// The sample interstitial ad.
//  SampleInterstitial *_interstitialAd;
    DTBAdInterstitialDispatcher* dispatcher;
  /// The completion handler to call when the ad loading succeeds or fails.
  GADMediationInterstitialLoadCompletionHandler _loadCompletionHandler;

  /// The ad event delegate to forward ad rendering events to the Google Mobile Ads SDK.
  id<GADMediationInterstitialAdEventDelegate> _adEventDelegate;
}

@end

@implementation ApsCustomEventInterstitial

- (void)loadInterstitialForAdConfiguration:
            (GADMediationInterstitialAdConfiguration *)adConfiguration
                         completionHandler:
                             (GADMediationInterstitialLoadCompletionHandler)completionHandler {
  __block atomic_flag completionHandlerCalled = ATOMIC_FLAG_INIT;
  __block GADMediationInterstitialLoadCompletionHandler originalCompletionHandler =
      [completionHandler copy];

  _loadCompletionHandler = ^id<GADMediationInterstitialAdEventDelegate>(
      _Nullable id<GADMediationInterstitialAd> ad, NSError *_Nullable error) {
    // Only allow completion handler to be called once.
    if (atomic_flag_test_and_set(&completionHandlerCalled)) {
      return nil;
    }

    id<GADMediationInterstitialAdEventDelegate> delegate = nil;
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
        DTBAdSize* adSize = [[DTBAdSize alloc] initInterstitialAdSizeWithSlotUUID:adUnit];
        DTBAdLoader* adLoader = [DTBAdLoader new];
        [adLoader setSizes:adSize, nil];
        [adLoader loadAd:self];
    } else {
        NSError* error = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdLoadedError, @"invalid adunit");
        _adEventDelegate = _loadCompletionHandler(nil, error);
    }
}

- (void)impressionFired { 
    if (_adEventDelegate) {
        [_adEventDelegate reportImpression];
    }
}


- (void)interstitialDidPresentScreen:(DTBAdInterstitialDispatcher * _Nullable)interstitial { 
   
}

- (void)interstitial:(DTBAdInterstitialDispatcher * _Nullable)interstitial didFailToLoadAdWithErrorCode:(DTBAdErrorCode)errorCode { 
    NSError* error = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdNotLoaded, @"load failed");
    _adEventDelegate = _loadCompletionHandler(nil, error);
}


- (void)interstitialDidDismissScreen:(DTBAdInterstitialDispatcher * _Nullable)interstitial { 
    if (_adEventDelegate) {
        [_adEventDelegate didDismissFullScreenView];
    }
}


- (void)interstitialDidLoad:(DTBAdInterstitialDispatcher * _Nullable)interstitial {
    dispatcher = interstitial;
    _adEventDelegate = _loadCompletionHandler(self, nil);
}


- (void)interstitialWillDismissScreen:(DTBAdInterstitialDispatcher * _Nullable)interstitial { 
    if (_adEventDelegate) {
        [_adEventDelegate willDismissFullScreenView];
    }
}


- (void)interstitialWillLeaveApplication:(DTBAdInterstitialDispatcher * _Nullable)interstitial { 
  
}


- (void)interstitialWillPresentScreen:(DTBAdInterstitialDispatcher * _Nullable)interstitial { 
    if (_adEventDelegate) {
        [_adEventDelegate willPresentFullScreenView];
    }
}

- (void)showFromRootViewController:(UIViewController * _Nonnull)controller { 
    
}

- (void)onSuccess:(DTBAdResponse *)adResponse {
    NSDictionary* mediationHints = [adResponse mediationHints];
    DTBAdInterstitialDispatcher* dispatcher = [[DTBAdInterstitialDispatcher alloc] initWithDelegate:self];
    [dispatcher fetchAdWithParameters:mediationHints];
}

- (void)onFailure:(DTBAdError)error {
    NSError* err = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdLoadedError, @"invalid adunit");
    _adEventDelegate = _loadCompletionHandler(nil, err);
}

- (void)presentFromViewController:(nonnull UIViewController *)viewController {
    if (dispatcher) {
        [dispatcher showFromController:viewController];
    } else {
        NSError *error = ApsCustomEventErrorWithCodeAndDescription(ApsCustomEventErrorAdNotLoaded, @"had not loaded");
        [_adEventDelegate didFailToPresentWithError:error];
    }
}

@end
