//
//  SDKGDPRUtil.h
//  IvyiOSSdk
//
//  Created by ivy on 2024/9/19.
//

#import <Foundation/Foundation.h>

@interface SDKGDPRUtil : NSObject

+(void)setupGDPR:(BOOL)priorityLocalGuide vc:(UIViewController * _Nonnull)vc;

+(void)checkAdmobGDPR:( UIViewController * _Nonnull )vc;

@end
