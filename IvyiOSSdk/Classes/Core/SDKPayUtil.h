//
//  SDKPayUtil.h
//  Pods
//
//  Created by ivy on 2025/3/5.
//

#import <Foundation/Foundation.h>

@interface SDKPayUtil : NSObject
{
@private
    NSString* verifyUrl;

}

-(id _Nullable )initWithVerifyUrl:(nonnull NSString*)url;

-(void)preOrder:(nonnull NSMutableDictionary *)product callback:(void(^_Nullable)(NSString * _Nullable merchant_transaction_id))callback;

-(void)verifyOrder:(nonnull NSString*)merchant_transaction_id receipt:(nonnull NSString*)receipt transactionIdentifier:(nonnull NSString *)transactionIdentifier productIdentifier:(nonnull NSString*)productIdentifier callback:(void(^_Nullable)(BOOL status, BOOL netError))callback;

-(void)shippngGoods:(nonnull NSString*)merchant_transaction_id callback:(void(^_Nullable)(BOOL status))callback;

-(void)unShippingGoodsCheck:(void(^_Nullable)(NSArray * _Nullable data))callback;

@end
