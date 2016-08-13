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

- (IBAction)customTypeAction:(UIButton *)sender {
    
    [self customAlertSheet];
}


- (IBAction)customTypeNoTitleTypeAction:(UIButton *)sender {
    
    [self customAlertSheetNoTitleType];
}


- (IBAction)customNoCancelAction:(UIButton *)sender {
    
    [self customAlertSheetNoCancelType];
}


- (IBAction)systemTypeAtion:(UIButton *)sender {
    
    [self alertSheet];
}


- (void)customAlertSheet{
    
    //关闭或者修改手势密码
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.type = CBWAlertSheetTypeCancelButton;
    sheet.title = @"标题😄";
    sheet.message = @"这个 alertSheet模仿微信的样式,尺寸,文字大小,布局都是跟微信一样的;可以自定义title/message/button/取消按钮等颜色哦.但是文字的大小,布局不可以改变,感觉微信的布局真心不错呢!";
    sheet.titleTextColor = [UIColor redColor];
    sheet.messageTextColor = [UIColor greenColor];
    sheet.cancleButtonColor = [UIColor redColor];
    sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"好的,去点个赞!" color:nil handler:nil];
    [sheet addSheetWithTitle:@"去意已决" color:nil handler:nil];
    [sheet show];
}

- (void)customAlertSheetNoTitleType{
    
    //关闭或者修改手势密码
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.type = CBWAlertSheetTypeCancelButton;
      sheet.titleTextColor = [UIColor redColor];
    sheet.messageTextColor = [UIColor greenColor];
    sheet.cancleButtonColor = [UIColor redColor];
    sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"胖子,快去减肥啦!" color:[UIColor blackColor] handler:nil];
    [sheet addSheetWithTitle:@"黑子,你又变胖啦!" color:[UIColor blackColor] handler:nil];
    [sheet show];

}


- (void)customAlertSheetNoCancelType{
    
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.titleTextColor = [UIColor redColor];
    sheet.messageTextColor = [UIColor greenColor];
    sheet.cancleButtonColor = [UIColor redColor];
    sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"羊小年" color:[UIColor blackColor] handler:nil];
    [sheet addSheetWithTitle:@"陈小黑" color:[UIColor blackColor] handler:nil];
    [sheet addSheetWithTitle:@"The next..." color:[UIColor blackColor] handler:nil];

    [sheet show];

    
}

- (void)alertSheet{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"啦啦啦啦...." message:@"哈哈哈哈..." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"😢😢" style:UIAlertActionStyleDefault handler:nil];
    
     UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"😊😊" style:UIAlertActionStyleDefault handler:nil];
    
    [alertVc addAction:action1];
    [alertVc addAction:action2];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}
@end
