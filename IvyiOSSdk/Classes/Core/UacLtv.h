//
//  UacLTV.h
//  IvyiOSSdk
//
//  Created by ivy on 2024/11/19.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UacLTV : NSObject
extern NSString * _Nonnull const KEY_TOTAL_AD_REVENUE;
+(void)setupToday;
+(void)checkAndUpdateUacTop:(nonnull NSString *)apiUrl;
+(void)logUacConversionEvent:(int)top dayRevenue:(double)dayRevenue totalRevenue:(double)totalRevenue;
+(void)logFirstThreeDaysLTV:(nonnull NSString *)tag totalRevenue:(double)totalRevenue hours:(int)hours;
+(void)checkFirstThreeDaysLTV:(double)totalRevenue;
+(void)checkUacLtvConversion:(double)revenue totalRevenue:(double)totalRevenue;
@end
