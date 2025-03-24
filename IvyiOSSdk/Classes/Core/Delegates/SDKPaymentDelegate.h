//
//  SDKPaymentDelegate.h
//  Pods
//
//  Created by 余冰星 on 2017/7/14.
//
//
#ifndef SDKPaymentDelegate_h
#define SDKPaymentDelegate_h
#import <Foundation/Foundation.h>

@protocol SDKPaymentDelegate<NSObject>

@required

- (void)onPaymentSuccess:(int)paymentId merchantTransactionId:(nullable NSString*)merchantTransactionId;

- (void)onPaymentSuccess:(int)paymentId payload:(nullable NSString *)payload merchantTransactionId:(nullable NSString*)merchantTransactionId;

- (void)onPaymentSuccess:(int)paymentId payload:(nullable NSString *)payload merchantTransactionId:(nullable NSString*)merchantTransactionId orderInfo:(nonnull NSString *)orderInfo;

- (void)onPaymentFailure:(int)paymentId forError:(nullable NSString *)error merchantTransactionId:(nullable NSString*)merchantTransactionId;

- (void)onAppStorePayRequest:(int)paymentId;

@optional

- (void)onPaymentReady;

- (void)onCheckSubscriptionResult:(int)paymentId remainSeconds:(long)seconds;

- (void)onRestoreSuccess:(int)paymentId;

- (void)onRestoreFailure:(nullable NSString *)error;

-(void)onShippingGoods:(nullable NSString*)merchant_transaction_id status:(BOOL)status;

@end
#endif /* SDKPaymentDelegate_h */
