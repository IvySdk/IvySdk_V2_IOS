//
//  UacLTV.m
//  IvyiOSSdk
//
//  Created by ivy on 2024/11/19.
//
#import <Foundation/Foundation.h>
#import <IvyiOSSdk/UacLTV.h>
#import <IvyiOSSdk/SDKFacade.h>
#import <IvyiOSSdk/SDKNetworkHelper.h>
#import <IvyiOSSdk/SDKJSONHelper.h>
@implementation UacLTV
static NSString *KEY_UAC_UPDATE_TIME = @"uac_update_time";
static NSString *KEY_UAC_TOP10 = @"_uac_top_10";
static NSString *KEY_UAC_TOP20 = @"_uac_top_20";
static NSString *KEY_UAC_TOP30 = @"_uac_top_30";
static NSString *KEY_UAC_TOP40 = @"_uac_top_40";
static NSString *KEY_UAC_TOP50 = @"_uac_top_50";
static NSString *KEY_UAC_TOP60 = @"_uac_top_60";
static NSString *KEY_UAC_TOP70 = @"_uac_top_70";
static NSString *KEY_UAC_TOP80 = @"_uac_top_80";
static NSString *KEY_UAC_TOP90 = @"_uac_top_90";
static NSString *KEY_UAC_DAY3_TOP10 = @"_uac_day3_top_10";
static NSString *KEY_UAC_DAY3_TOP20 = @"_uac_day3_top_20";
static NSString *KEY_UAC_DAY3_TOP30 = @"_uac_day3_top_30";
static NSString *KEY_UAC_PREFIX_TODAY = @"_uac_rev_";
static NSString *PREFIX_EVENT_UAC = @"AdLtv_OneDay_Top";
NSString * const KEY_TOTAL_AD_REVENUE = @"mkv_total_ad_revenue";
 
static NSString * todayKey = @"";
+ (void)setupToday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *currentDate = [NSDate date];
    todayKey = [dateFormatter stringFromDate:currentDate];
}
+ (void)checkAndUpdateUacTop:(NSString *)apiUrl
{
    long lastUpdateTime = [[SDKFacade sharedInstance] mmGetLongValue:KEY_UAC_UPDATE_TIME defaultValue:0];
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
    if (current - lastUpdateTime < 2 * 60 * 60) {
        return;
    }
    NSString* url = [NSString stringWithFormat:@"%@?appId=%@&packageName=%@", apiUrl, [[SDKFacade sharedInstance] appid], [[NSBundle mainBundle] bundleIdentifier]];
    [[SDKNetworkHelper sharedHelper] GET:url parameters:nil jsonRequest:TRUE jsonResponse:TRUE success:^(id  _Nullable responseObject) {
        @try {
            if (responseObject) {
//                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSMutableDictionary* data = [SDKJSONHelper toArrayOrNSDictionary:str];
                NSDictionary* data = nil;
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    data = [[NSDictionary alloc] initWithDictionary:responseObject];
                }
                if (data.count > 0) {
                    NSString* status = [data objectForKey:@"status"];
                    if (status && [status isEqualToString:@"success"]) {
                        NSDictionary* topData = [data objectForKey:@"data"];
                        if (topData && [topData isKindOfClass:[NSDictionary class]] && topData.count > 0) {
                            double top10 = [[topData objectForKey:@"t10"] doubleValue];
                            double top20 = [[topData objectForKey:@"t20"] doubleValue];
                            double top30 = [[topData objectForKey:@"t30"] doubleValue];
                            double top40 = [[topData objectForKey:@"t40"] doubleValue];
                            double top50 = [[topData objectForKey:@"t50"] doubleValue];
                            double top60 = [[topData objectForKey:@"t60"] doubleValue];
                            double top70 = [[topData objectForKey:@"t70"] doubleValue];
                            double top80 = [[topData objectForKey:@"t80"] doubleValue];
                            double top90 = [[topData objectForKey:@"t90"] doubleValue];
                            
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP10 value:top10];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP20 value:top20];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP30 value:top30];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP40 value:top40];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP50 value:top50];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP60 value:top60];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP70 value:top70];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP80 value:top80];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_TOP90 value:top90];
                            
                            [[SDKFacade sharedInstance] mmSetLongValue:KEY_UAC_UPDATE_TIME value:[NSDate date].timeIntervalSince1970];
                        }
                        
                        NSDictionary* top3Data = [data objectForKey:@"day3_data"];
                        if (top3Data && [top3Data isKindOfClass:[NSDictionary class]] && top3Data.count > 0) {
                            double day3Top10 = [[top3Data objectForKey:@"t10"] doubleValue];
                            double day3Top20 = [[top3Data objectForKey:@"t20"] doubleValue];
                            double day3Top30 = [[top3Data objectForKey:@"t30"] doubleValue];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_DAY3_TOP10 value:day3Top10];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_DAY3_TOP20 value:day3Top20];
                            [[SDKFacade sharedInstance] mmSetDoubleValue:KEY_UAC_DAY3_TOP30 value:day3Top30];
                        }
                        
                    }
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"update uac config failed");
        }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"update uac config failed");
        }];
}
+ (void)logFirstThreeDaysLTV:(NSString *)tag totalRevenue:(double)totalRevenue hours:(int)hours
{
    NSString* sendFlag = [NSString stringWithFormat:@"AdLtv_day3_top%@_gen", tag];
    bool alreadySent = [[SDKFacade sharedInstance] mmGetBoolValue:sendFlag defaultValue:false];
    if (alreadySent) {
        return;
    }
    NSString* eventName = [NSString stringWithFormat:@"AdLtv_day3_top%@", tag];
    [[SDKFacade sharedInstance] logEvent:eventName withData:@{@"total_revenue" : [NSNumber numberWithDouble:totalRevenue], @"hours" : [NSNumber numberWithInt:hours], @"catalog" : @"day3"}];
    [[SDKFacade sharedInstance] mmSetBoolValue:sendFlag value:true];
}
+ (void)checkFirstThreeDaysLTV:(double)totalRevenue
{
    long firstOpenTime = [[SDKFacade sharedInstance] firstOpenTime];
    long duration = [[NSDate date] timeIntervalSince1970] - firstOpenTime;
    if (duration <= 0) {
        return;
    }
    int hours = (int)(duration / 60 / 60);
    double day3Top30 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_DAY3_TOP30 defaultValue:0.0];
    if (day3Top30 > 0) {
        if (totalRevenue >= day3Top30) {
            [UacLTV logFirstThreeDaysLTV:@"30" totalRevenue:totalRevenue hours:hours];
        } else {
            return;
        }
    }
    double day3Top20 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_DAY3_TOP20 defaultValue:0.0];
    if (day3Top20 > 0) {
        if (totalRevenue >= day3Top20) {
            [UacLTV logFirstThreeDaysLTV:@"20" totalRevenue:totalRevenue hours:hours];
        } else {
            return;
        }
    }
    double day3Top10 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_DAY3_TOP10 defaultValue:0.0];
    if (day3Top10 > 0) {
        if (totalRevenue >= day3Top10) {
            [UacLTV logFirstThreeDaysLTV:@"10" totalRevenue:totalRevenue hours:hours];
        } else {
            return;
        }
    }
}
+ (void)logUacConversionEvent:(int)top dayRevenue:(double)dayRevenue totalRevenue:(double)totalRevenue
{
    NSString* sendFlagKey = [NSString stringWithFormat:@"%@%@%d_gen", KEY_UAC_PREFIX_TODAY, todayKey, top];
    bool alreadySent = [[SDKFacade sharedInstance] mmGetBoolValue:sendFlagKey defaultValue:false];
    if (alreadySent) {
        return;
    }
    NSString* eventName = [NSString stringWithFormat:@"%@%d", PREFIX_EVENT_UAC, top];
    [[SDKFacade sharedInstance] logEvent:eventName withData:@{@"total_revenue" : [NSNumber numberWithDouble:totalRevenue], @"day_revenue" : [NSNumber numberWithDouble:dayRevenue], @"label" : todayKey, @"catalog" : [NSNumber numberWithInt:top]}];
    [[SDKFacade sharedInstance] mmSetBoolValue:sendFlagKey value:true];
}
+ (void)checkUacLtvConversion:(double)revenue totalRevenue:(double)totalRevenue
{
    NSString* todayRevenueKey = [NSString stringWithFormat:@"%@%@", KEY_UAC_PREFIX_TODAY, todayKey];
    double todayRevenue = [[SDKFacade sharedInstance] mmGetDoubleValue:todayRevenueKey defaultValue:0.0] + revenue;
    [[SDKFacade sharedInstance] mmSetDoubleValue:todayRevenueKey value:todayRevenue];
    double top90 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP90 defaultValue:0.0];
    if (top90 > 0) {
        if (todayRevenue >= top90) {
            [UacLTV logUacConversionEvent:90 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top80 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP80 defaultValue:0.0];
    if (top80 > 0) {
        if (todayRevenue >= top80) {
            [UacLTV logUacConversionEvent:80 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top70 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP70 defaultValue:0.0];
    if (top70 > 0) {
        if (todayRevenue >= top70) {
            [UacLTV logUacConversionEvent:70 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top60 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP60 defaultValue:0.0];
    if (top60 > 0) {
        if (todayRevenue >= top60) {
            [UacLTV logUacConversionEvent:60 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top50 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP50 defaultValue:0.0];
    if (top50 > 0) {
        if (todayRevenue >= top50) {
            [UacLTV logUacConversionEvent:50 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top40 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP40 defaultValue:0.0];
    if (top40 > 0) {
        if (todayRevenue >= top40) {
            [UacLTV logUacConversionEvent:40 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
 
    double top30 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP30 defaultValue:0.0];
    if (top30 > 0) {
        if (todayRevenue >= top30) {
            [UacLTV logUacConversionEvent:30 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top20 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP20 defaultValue:0.0];
    if (top20 > 0) {
        if (todayRevenue >= top20) {
            [UacLTV logUacConversionEvent:20 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
    
    double top10 = [[SDKFacade sharedInstance] mmGetDoubleValue:KEY_UAC_TOP10 defaultValue:0.0];
    if (top10 > 0) {
        if (todayRevenue >= top10) {
            [UacLTV logUacConversionEvent:10 dayRevenue:todayRevenue totalRevenue:totalRevenue];
        } else {
            return;
        }
    }
}
@end
