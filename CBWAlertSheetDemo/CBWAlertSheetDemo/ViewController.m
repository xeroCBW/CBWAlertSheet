//
//  ViewController.m
//  CBWAlertSheetDemo
//
//  Created by 陈博文 on 16/7/1.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "CBWAlertSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   }

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //关闭或者修改手势密码
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.type = CBWAlertSheetTypeGap;
    sheet.cancleButtonColor = [UIColor redColor];
     sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"关闭手势密码" color:[UIColor blackColor] handler:^(CBWAlertSheet *alertView) {
        
        NSLog(@"关闭手势密码");
        
    }];
    
    [sheet addSheetWithTitle:@"修改手势密码" color:[UIColor blackColor]  handler:^(CBWAlertSheet *alertView) {
        
        NSLog(@"修改手势密码");
        
    }];
    
    [sheet show];
}

@end
