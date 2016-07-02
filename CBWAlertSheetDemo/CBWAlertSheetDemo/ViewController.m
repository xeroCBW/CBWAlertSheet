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
    
    [self customAlertSheet];
}

- (void)customAlertSheet{
    
    //关闭或者修改手势密码
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.type = CBWAlertSheetTypeCancelButton;
    sheet.title = @"关闭手势密码";
    sheet.message = @"自己学东西容易忘,也不会总结.总是一路捡起东西,走了几步捡到东西又把旧的东西扔掉,写这个让自己保持一个好的习惯.";
//    sheet.titleTextColor = [UIColor greenColor];
//    sheet.messageTextColor = [UIColor redColor];
//    sheet.cancleButtonColor = [UIColor redColor];
//    sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"考虑考虑" color:[UIColor blackColor] handler:nil];
    [sheet addSheetWithTitle:@"不要吧" color:[UIColor blackColor] handler:nil];
    [sheet addSheetWithTitle:@"去意已决" color:[UIColor blackColor] handler:nil];
    [sheet show];
}


- (void)alertSheet{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"1231313231232关闭手势密码关闭手势密码关闭手势密码关闭手势密码关闭手势密码关闭手势密码关闭手势密码" message:@"3123123212321关闭手势密码关闭手势密码关闭手势密码关闭手势密码关闭手势密码" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"werwerew" style:UIAlertActionStyleDefault handler:nil];
    
     UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"werwerew" style:UIAlertActionStyleDefault handler:nil];
    
    [alertVc addAction:action1];
    [alertVc addAction:action2];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}
@end
