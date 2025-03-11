//
//  SDKThinkingDataAnalyse.m
//  IvyiOSSdk
//
//  Created by ivy on 2025/3/3.
//

#import <Foundation/Foundation.h>
#import "SDKThinkingdataAnalyse.h"
//#import <IvyiOSSdk/SDKTimer.h>
//#import <IvyiOSSdk/SDKConstants.h>
//#import <IvyiOSSdk/SDKCache.h>
#import <IvyiOSSdk/SDKConstants.h>
#import <IvyiOSSdk/ThinkingSDK.h>

@implementation SDKThinkingdataAnalyse

- (void)setup:(NSDictionary *)conf
{
    _platform = SDK_ANALYSE_IVY;
    NSString* appid = [conf objectForKey:@"id"];
    NSString* serverUrl = [conf objectForKey:@"srverUrl"];
    NSLog(@"thinkingData init start;%@,%@", appid, serverUrl);
    TDConfig* config = [[TDConfig alloc] init];
    config.appid = appid;
    config.serverUrl = serverUrl;
    config.mode = TDModeNormal;
    [TDAnalytics startAnalyticsWithConfig:config];
}

- (void)logEvent:(NSString *)eventId
{
    [TDAnalytics track:eventId];
}

- (void)logEvent:(NSString *)eventId action:(NSString *)action
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* body = [[NSMutableDictionary alloc] init];
    [body setObject:action forKey:@"action"];
    [extra setObject:body forKey:@"extra"];
    [TDAnalytics track:eventId properties:extra];
}

- (void)logEvent:(NSString *)eventId action:(NSString *)action label:(NSString *)label value:(long)value
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* body = [[NSMutableDictionary alloc] init];
    [body setObject:action forKey:@"action"];
    [body setObject:label forKey:@"label"];
    [body setObject:@(value) forKey:@"value"];
    [extra setObject:body forKey:@"extra"];
    [TDAnalytics track:eventId properties:extra];
}

- (void)logEvent:(NSString *)eventId withData:(NSDictionary *)data
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    [extra setObject:data forKey:@"extra"];
    [TDAnalytics track:eventId properties:extra];
}

- (void)logEvent:(NSString *)eventId valueToSum:(double)value parameters:(NSDictionary *)parameters
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    [extra setObject:parameters forKey:@"extra"];
    [TDAnalytics track:eventId properties:extra];
}

- (void)logPlayerLevel:(int)levelId
{
    
}

- (void)logPageStart:(NSString *)pageName
{
    
}

- (void)logPageEnd:(NSString *)pageName
{
    
}

- (void)logStartLevel:(NSString *)level
{
    
}

- (void)logFailLevel:(NSString *)level
{
    
}

- (void)logFinishLevel:(NSString *)level
{
    
}

- (void)logFinishTutorial:(NSString *)tutorial
{
    
}

- (void)logFinishAchievement:(NSString *)achievement
{
    
}

- (void)logRate:(CGFloat)star
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* body = [[NSMutableDictionary alloc] init];
    [body setObject:@(5) forKey:@"rate"];
    [extra setObject:body forKey:@"extra"];
    [TDAnalytics track:@"rate" properties:extra];
}

- (void)logAdImpression:(NSString *)eventName params:(NSDictionary *)params
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    [extra setObject:params forKey:@"extra"];
    [TDAnalytics track:eventName properties:extra];
}

- (void)logAdClick:(NSString *)eventName params:(NSDictionary *)params
{
    NSMutableDictionary* extra = [[NSMutableDictionary alloc] init];
    [extra setObject:params forKey:@"extra"];
    [TDAnalytics track:eventName properties:extra];
}

- (void)logStartPay:(NSDictionary *)data
{
    
}

- (void)logSubscribe:(NSDictionary *)data
{
    
}

- (void)logPay:(NSString *)payId price:(NSNumber *)price name:(NSString *)itemName number:(int)number currency:(NSString *)currency first_purchase:(BOOL)first_purchase
{
    
}

- (void)logBuy:(NSString *)itemName itemType:(NSString *)itemType count:(int)count price:(double)price
{
    
}

- (void)logBonus:(NSString *)itemName number:(int)number price:(double)price trigger:(int)trigger
{
    
}

- (void)trackScreen:(NSString *)screenClass screenName:(NSString *)screenName
{
    
}



@end
