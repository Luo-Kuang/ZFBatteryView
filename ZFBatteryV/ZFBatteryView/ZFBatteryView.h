//
//  ZFBatteryView.h
//  ZFBatteryV
//
//  Created by 张帆 on 2017/12/21.
//  Copyright © 2017年 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFBatteryView : UIView
// 1- 100
@property (nonatomic, assign) int percent;

@property (nonatomic, assign) BOOL charging;
@end
