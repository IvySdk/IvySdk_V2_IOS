//
//  SDKAIHelp.m
//  Pods
//
//  Created by iOS打包3 on 2023/7/7.
//

#import "SDKAIHelp.h"
#import <IvyiOSSdk/SDKFacade.h>
#import <IvyiOSSdk/SDKGCDTimer.h>
#import <AIHelpSupportSDK/AIHelpSupportSDK.h>


@interface SDKAIHelp ()
@end

@implementation SDKAIHelp
{
    NSString* appId;
    NSString* key;
    NSString* url;
    BOOL isInited;
    NSString* AIHelpTimer;
    BOOL onlyOnce;
}

static SDKAIHelp* helper;

-(void)showAIHelp:(nonnull NSString*) entranceId message:(nonnull NSString*)meta tag:(nullable NSString*) tags welcome:(nullable NSString*) wMsg{
    AIHelpUserConfigBuilder *userBuilder = [[AIHelpUserConfigBuilder alloc] init];

//    userBuilder.userId = [SDKHelper getIDFVString];//[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    userBuilder.userTags = [self parseArray:tags];
    userBuilder.customData = [self parseDictionary:meta];
    [AIHelpSupportSDK updateUserInfo:userBuilder.build];
    
    AIHelpApiConfigBuilder *builder = [[AIHelpApiConfigBuilder alloc] init];
    builder.entranceId = entranceId;
    builder.welcomeMessage = wMsg;
    [AIHelpSupportSDK showWithApiConfig:builder.build];
    
}

-(NSArray*) parseArray:(nullable NSString*) tags {
    if(tags == nil){
        return  nil;
    }
    NSArray* data = nil;
    NSError* err = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[tags dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    if(!err) {
        data = jsonObject;
    }
    return data;
}

-(NSDictionary*) parseDictionary:(nonnull NSString*)meta{
    NSDictionary* data = nil;
    NSError* err = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[meta dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    if(!err) {
        data = jsonObject;
    }
    return data;
}

-(void)showSignleFAQ:(nonnull NSString*) faqId momemt:(int)mnt{
    
}

-(BOOL)isAIHelpInitialized{
    return self->isInited;
}

//void AIHelp_unreadMessageArrived(const int count)  {
//    [[SDKFacade sharedInstance] unreadMessageCount:count];
//}

- (BOOL)isOnlyOnce
{
    return self->onlyOnce;
}

void AIHelp_unreadMessageArrived(const char* eventData, void(*acknowledge)(const char* ackData)) {
//    [[SDKFacade sharedInstance] unreadMessageCount:count];
    @try {
        NSString* str = [NSString stringWithFormat:@"%s", eventData];
        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error = nil;
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            
        } else {
            int count = [[dict objectForKey:@"taskCount"] intValue];
            [[SDKFacade sharedInstance] unreadMessageCount:count];
        }
       
    } @catch (NSException *exception) {
        
    }
}

-(void)loadAIHelpUnreadMessageCount:(BOOL) onlyOnce{
    self->onlyOnce = onlyOnce;
//    [AIHelpSupportSDK startUnreadMessageCountPolling:AIHelp_unreadMessageArrived];
    [AIHelpSupportSDK registerAsyncListener:AIHelp_unreadMessageArrived eventType:AIHelpEventMessageArrival];
//    static dispatch_once_t loadUnread;
//    dispatch_once(&loadUnread, ^{
//        [[SDKGCDTimer sharedInstance] scheduleGCDTimerWithName:self->AIHelpTimer interval:5*60
//                                                         queue:dispatch_get_main_queue() repeats:!onlyOnce
//                                                        option:SDKGCDTimerOptionCancelPrevAction action:^{
//            [AIHelpSupportSDK startUnreadMessageCountPolling:AIHelp_unreadMessageArrived];
//        }];
//    });
}

-(void)stopLoadAIHelpUnreadMessageCount{
    [[SDKGCDTimer sharedInstance] cancelTimerWithName:self->AIHelpTimer];
}


-(void)closeAIHelp{
    [AIHelpSupportSDK close];
}

-(void)switchLanguage:(nonnull NSString*) lang{
    [AIHelpSupportSDK updateSDKLanguage:lang];
}

void AIHelp_onInitializationCallback(const char* eventData, void(*acknowledge)(const char* ackData)) {
    helper->isInited = TRUE;
    [AIHelpSupportSDK unregisterAsyncListenerWithEvent:AIHelpEventInitialization];
}

- (nonnull id)initWithkey:(nonnull NSString *)key withAppId:(nonnull NSString *)appId withUrl:(nonnull NSString *)url {
    if(self = [super init]){
#ifdef DEBUG
        [AIHelpSupportSDK enableLogging:YES];
#endif
        self->key = key;
        self->appId = appId;
        self->url = url;
        self->isInited = FALSE;
        helper = self;
//        [AIHelpSupportSDK initWithApiKey:key
//                                  domainName:url
//                                          appId:appId];
//        [AIHelpSupportSDK setOnInitializedCallback:AIHelp_onInitializationCallback];
//        
//
        [AIHelpSupportSDK registerAsyncListener:AIHelp_onInitializationCallback eventType:AIHelpEventInitialization];
        [AIHelpSupportSDK initializeWithDomainName:url appId:appId];
        
        self->AIHelpTimer =@"query unread message";
      
    }
    return self;
}

@end
