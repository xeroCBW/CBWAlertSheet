# CBWAlertSheet
###自己写的 AlertSheet,总共有3种样式

###1.有标题,有取消按钮

![IMG_3864.PNG](http://upload-images.jianshu.io/upload_images/874748-befa3cbe4aa8e9c1.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
- (void)customAlertSheet{
    
    //关闭或者修改手势密码
    CBWAlertSheet *sheet = [[CBWAlertSheet alloc]init];
    sheet.type = CBWAlertSheetTypeCancelButton;
    sheet.title = @"关闭手势密码";
    sheet.message = @"自己学东西容易忘,也不会总结.总是一路捡起东西,走了几步捡到东西又把旧的东西扔掉,写这个让自己保持一个好的习惯.";
    sheet.titleTextColor = [UIColor redColor];
    sheet.messageTextColor = [UIColor greenColor];
    sheet.cancleButtonColor = [UIColor redColor];
    sheet.cancleButtonTextColor = [UIColor yellowColor];
    [sheet addSheetWithTitle:@"好的,去点个赞!" color:nil handler:nil];
    [sheet addSheetWithTitle:@"去意已决" color:nil handler:nil];
    [sheet show];
}

```

###2.没有标题,有取消按钮

![IMG_3865.PNG](http://upload-images.jianshu.io/upload_images/874748-22eb0ad6ebff790e.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
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
```
###3.没有取消按钮,没有标题

![IMG_3866.PNG](http://upload-images.jianshu.io/upload_images/874748-e5af25925b1a2463.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```

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
```

使用方法:
1. 直接拖'CBWAlertSheet'的. h 和 .m 文件
2.使用   `pod 'CBWAlertSheet'`

[github 地址](https://github.com/xeroxmx/CBWAlertSheet.git)

如果喜欢帮我 start 一下哦!