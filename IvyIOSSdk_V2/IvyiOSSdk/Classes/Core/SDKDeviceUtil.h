//
//  DeviceUtil.h
//  Pods
//
//  Created by ivy on 2024/10/31.
//

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6+ plus系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断iPHoneXr
#define IS_IPHONE_12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_12_PRO ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_12_MIN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_14_PRO ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1290, 2796), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_15 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1179, 2556), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_16_PRO ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1206, 2622), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_16_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1320, 2868), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


// 判断是否是刘海机型
#define IS_IPHONE_X_S_Max_R (IS_IPHONE_X || IS_IPHONE_Xs || IS_IPHONE_Xs_Max || IS_IPHONE_Xr || IS_IPHONE_12 || IS_IPHONE_12_PRO || IS_IPHONE_12_MIN || IS_IPHONE_14_PRO || IS_IPHONE_15 || IS_IPHONE_16_PRO || IS_IPHONE_16_MAX)


//刘海机型safearea
#define StatusBar_Height (IS_IPHONE_X_S_Max_R ? 44.0 : 0.0)
#define NavBar_Height (IS_IPHONE_X_S_Max_R ? 88.0 : 64.0)
#define TabBar_Height (IS_IPHONE_X_S_Max_R ? 83.0 : 49.0)

