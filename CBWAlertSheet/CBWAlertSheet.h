//
//  CBWAlertSheet.h
//  alertView
//
//  Created by 陈博文 on 16/6/27.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CBWAlertSheetTypeNormal = 0,
    CBWAlertSheetTypeCancelButton,//默认有取消按钮且在最下面
} CBWAlertSheetType;

@class CBWAlertSheet;
typedef void(^CBWAlertSheetHandler) (CBWAlertSheet *alertView);

@interface CBWAlertSheet : UIView
/** 处理button 点击的block*/
@property (nonatomic ,strong) void (^buttonClickActionBlock)(CBWAlertSheet *alertView,NSUInteger index);

/** 标题文字颜色*/
@property (nonatomic ,strong) UIColor *titleTextColor;

/** 内容文字颜色*/
@property (nonatomic ,strong) UIColor *messageTextColor;

/** cancleButtonColor*/
@property (nonatomic ,strong) UIColor *cancleButtonColor;

/** cancleButtonTextColor*/
@property (nonatomic ,strong) UIColor *cancleButtonTextColor;

/** 取消按钮与下方是否有间隙*/
@property (nonatomic ,assign) CBWAlertSheetType type;

/** title-- 标题*/
@property (nonatomic ,copy) NSString *title;

/** 内容*/
@property (nonatomic ,copy) NSString *message;

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message;

- (void)addSheetWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertSheetHandler )handler;

- (void)show;
- (void)dismiss;
@end
