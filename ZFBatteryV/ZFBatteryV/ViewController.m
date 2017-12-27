//
//  ViewController.m
//  ZFBatteryV
//
//  Created by 张帆 on 2017/12/21.
//  Copyright © 2017年 张帆. All rights reserved.
//

#import "ViewController.h"
#import "ZFBatteryView.h"

@interface ViewController () <ZFIPhoneBatteryViewDelegate>
@property (nonatomic, strong) ZFBatteryView *ba;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ba = [[ZFBatteryView alloc] initWithFrame:CGRectMake(30, 100, 50, 15)];
    self.ba.delegate = self;
    [self.view addSubview:self.ba];
    
}

- (IBAction)percentChanged:(UISlider *)sender {
    self.ba.percent = (int)sender.value;
}

- (IBAction)chargeBtn:(id)sender {
    self.ba.charging = !self.ba.charging;
}
- (void)zf_batteryLowPower {
    NSLog(@"--low power");
}
@end

