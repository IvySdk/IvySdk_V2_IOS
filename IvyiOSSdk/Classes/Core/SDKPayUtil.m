//
//  SDKPayUtil.m
//  IvyiOSSdk
//
//  Created by ivy on 2025/3/5.
//

#import <Foundation/Foundation.h>
#include <IvyiOSSdk/SDKNetworkHelper.h>
#include <IvyiOSSdk/SDKFacade.h>
#include "SDKPayUtil.h"

@implementation SDKPayUtil

- (id)initWithVerifyUrl:(NSString *)url
{
    if (self = [super init]) {
        verifyUrl = url;
        if (![verifyUrl hasSuffix:@"/"]) {
            verifyUrl = [NSString stringWithFormat:@"%@%@", verifyUrl, @"/"];
        }
    }
    return self;
}

- (void)preOrder:(nonnull NSMutableDictionary *)product callback:(void (^__strong)(NSString *__strong))callback {
    NSString* url = [NSString stringWithFormat:@"%@%@", verifyUrl, @"pre_apple"];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:@NO forKey:@"is_encrypt"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_APP_ID] forKey:@"app_id"];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_COUNTRY] forKey:@"country"];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_UUID] forKey:@"uuid"];
    [data setObject:@NO forKey:@"is_sendbox"];
    [data setObject:product forKey:@"sku_json"];
    [params setObject:data forKey:@"data"];
    [[SDKNetworkHelper sharedHelper] POST:url parameters:params jsonRequest:TRUE jsonResponse:TRUE success:^(id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            if (data) {
                NSNumber* code = [data objectForKey:@"code"];
                if (code.intValue == 0) {
                    NSDictionary* body = [data objectForKey:@"data"];
                    NSString* merchant_transaction_id = [body objectForKey:@"merchant_transaction_id"];
                    if (merchant_transaction_id) {
                        if (callback) {
                            callback(merchant_transaction_id);
                        }
                    } else {
                        NSString* reason = @"invalid merchant_transaction_id";
                        NSLog(@"PayUtil -- pre order failed:%@", reason);
                        if (callback) {
                            callback(nil);
                        }
                    }
                }
            } else{
                NSString* reason = @"empty response";
                NSLog(@"PayUtil -- pre order failed:%@", reason);
                if (callback) {
                    callback(nil);
                }
            }
        } else {
            NSString* reason = @"invalid response";
            NSLog(@"PayUtil -- pre order failed:%@", reason);
            if (callback) {
                callback(nil);
            }
        }
        
        } failure:^(NSError * _Nullable error) {
            NSString* reason = error ? @"" : error.localizedDescription;
            NSLog(@"PayUtil -- pre order failed:%@", reason);
            if (callback) {
                callback(nil);
            }
        }];
}

- (void)verifyOrder:(NSString *)merchant_transaction_id receipt:(NSString *)receipt transactionIdentifier:(NSString *)transactionIdentifier productIdentifier:(NSString *)productIdentifier callback:(void (^)(BOOL))callback
{
    if (merchant_transaction_id == nil || receipt == nil || transactionIdentifier == nil || productIdentifier == nil) {
        if (callback) {
            callback(FALSE);
        }
        return;
    }
    NSString* appid =[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_APP_ID];
    if (appid == nil) {
        if (callback) {
            callback(FALSE);
        }
        return;
    }
    NSString* country = [[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_COUNTRY];
    if (country == nil) {
        if (callback) {
            callback(FALSE);
        }
        return;
    }
    NSString* uuid = [[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_UUID] ;
    if (uuid == nil) {
        if (callback) {
            callback(FALSE);
        }
        return;
    }
    NSString* url = [NSString stringWithFormat:@"%@%@", verifyUrl, @"verify_apple"];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:@NO forKey:@"is_encrypt"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:appid forKey:@"app_id"];
    [data setObject:country forKey:@"country"];
    [data setObject:uuid forKey:@"uuid"];
    [data setObject:productIdentifier forKey:@"product_identifier"];
    [data setObject:transactionIdentifier forKey:@"transaction_identifier"];
    [data setObject:merchant_transaction_id forKey:@"merchant_transaction_id"];
    [data setObject:receipt forKey:@"receipt"];
    [params setObject:data forKey:@"data"];
    [[SDKNetworkHelper sharedHelper] POST:url parameters:params jsonRequest:TRUE jsonResponse:TRUE success:^(id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            if (data) {
                NSNumber* code = [data objectForKey:@"code"];
                if (code.intValue == 0) {
                    NSNumber* verifyResult = [data objectForKey:@"data"];
                    NSLog(@"PayUtil -- verify result:%d", [verifyResult boolValue]);
                    if (callback) {
                        callback([verifyResult boolValue]);
                    }
                } else {
                    if (callback) {
                        callback(FALSE);
                    }
                }
            } else{
                NSString* reason = @"empty response";
                NSLog(@"PayUtil -- verify failed:%@", reason);
                if (callback) {
                    callback(FALSE);
                }
            }
        } else {
            NSString* reason = @"invalid response";
            NSLog(@"PayUtil -- verify failed:%@", reason);
            if (callback) {
                callback(FALSE);
            }
        }
        } failure:^(NSError * _Nullable error) {
            NSString* reason = error ? @"" : error.localizedDescription;
            NSLog(@"PayUtil -- verify failed:%@", reason);
            if (callback) {
                callback(FALSE);
            }
        }];
}

- (void)shippngGoods:(nonnull NSString *)merchant_transaction_id callback:(void (^__strong)(BOOL))callback {
    NSString* url = [NSString stringWithFormat:@"%@%@", verifyUrl, @"consume_apple"];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:@NO forKey:@"is_encrypt"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_APP_ID] forKey:@"app_id"];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_COUNTRY] forKey:@"country"];
    [data setObject:[[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_UUID] forKey:@"uuid"];
    [data setObject:merchant_transaction_id forKey:@"merchant_transaction_id"];
    [params setObject:data forKey:@"data"];
    [[SDKNetworkHelper sharedHelper] POST:url parameters:params jsonRequest:TRUE jsonResponse:TRUE success:^(id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            if (data) {
                NSNumber* code = [data objectForKey:@"code"];
                if (code.intValue == 0) {
                    BOOL shippingResult = [data objectForKey:@"data"];
                    NSLog(@"PayUtil -- shipping result:%d", shippingResult);
                    if (callback) {
                        callback(shippingResult);
                    }
                }
            } else{
                NSString* reason = @"empty response";
                NSLog(@"PayUtil -- shipping failed:%@", reason);
                if (callback) {
                    callback(FALSE);
                }
            }
        } else {
            NSString* reason = @"invalid response";
            NSLog(@"PayUtil -- shipping failed:%@", reason);
            if (callback) {
                callback(FALSE);
            }
        }
        } failure:^(NSError * _Nullable error) {
            NSString* reason = error ? @"" : error.localizedDescription;
            NSLog(@"PayUtil -- shipping failed:%@", reason);
            if (callback) {
                callback(FALSE);
            }
        }];
}

- (void)unShippingGoodsCheck:(void (^)(NSArray * _Nullable))callback
{
    NSString* appid = [[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_APP_ID];
    NSString* uuid = [[SDKFacade sharedInstance] getConfig:SDK_CONFIG_KEY_UUID];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:appid forKey:@"app_id"];
    [dict setObject:uuid forKey:@"uuid"];
    NSString* url = [NSString stringWithFormat:@"%@%@", verifyUrl, @"unconsume_apple"];
    [[SDKNetworkHelper sharedHelper] GET:url parameters:dict jsonRequest:TRUE jsonResponse:TRUE success:^(id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            if (data) {
                NSNumber* code = [data objectForKey:@"code"];
                if (code.intValue == 0) {
                    NSArray* unShippingData = [data objectForKey:@"data"];
                    if (callback) {
                        callback(unShippingData);
                    }
                }
            } else {
                NSString* reason = @"empty response";
                NSLog(@"PayUtil -- load unshipping data failed:%@", reason);
                if (callback) {
                    callback(nil);
                }
            }
        } else {
            NSString* reason = @"invalid response";
            NSLog(@"PayUtil -- load unshipping data failed:%@", reason);
            if (callback) {
                callback(nil);
            }
        }
        } failure:^(NSError * _Nullable error) {
            if (callback) {
                callback(nil);
            }
        }];
}

@end
