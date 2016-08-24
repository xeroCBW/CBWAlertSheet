# CBWAlertSheet
###自己写的 AlertSheet,总共有3种样式

这个 alertSheet模仿微信的样式,尺寸,文字大小,布局都是跟微信一样的;可以`自定义title/message/button/取消按钮等颜色`哦.但是`文字的大小,布局不可以改变`,感觉微信的布局真心不错呢!"

###1.有标题,有取消按钮--可以自定义 title/message 文字颜色



![有标题和取消按钮样式](http://upload-images.jianshu.io/upload_images/874748-9460567c021f0d47.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)


```
- (void)customAlertSheet{
    
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

```

###2.没有标题,有取消按钮--可以自定取消按钮的文字颜色/背景颜色

![没有标题,有取消按钮样式](http://upload-images.jianshu.io/upload_images/874748-22eb0ad6ebff790e.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)

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

![没有取消按钮,没有标题样式](http://upload-images.jianshu.io/upload_images/874748-e5af25925b1a2463.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)

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
