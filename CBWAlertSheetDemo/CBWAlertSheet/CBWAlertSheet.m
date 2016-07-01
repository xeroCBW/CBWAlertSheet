//
//  CBWAlertSheet.m
//  alertView
//
//  Created by 陈博文 on 16/6/27.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWAlertSheet.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define defaultBlueColor [UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]
#define colorHighLight [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:0.9]
#define marginColor [UIColor colorWithRed:196.0/255 green:196.0/255 blue:201.0/255 alpha:1.0]

#define cancelButtonTitleColor [UIColor whiteColor]//取消按钮默认 title颜色
#define cancelButtonNormalColor [UIColor colorWithRed:0.510  green:0.745  blue:0.992 alpha:1]
#define cancelButtonSelectedColor colorHighLight
#define gapColor [UIColor colorWithWhite:1.0 alpha:0.6]

static float const margin = 1.0;
static float const dismisDuring = 0.2f;
static float const dismisDelay = 0.0f;
static float const buttonFont = 17.0;
static float const buttonHeight  = 50.0;
//取消按钮与上面的 gap
static float const gap = 10;



#pragma mark - AlertButtonItem
@interface AlertSheetItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) CBWAlertSheetHandler action;
@end
//一定要有实现,要不然不能运行
@implementation AlertSheetItem

#pragma mark - CBWAlertSheet

@end

@interface CBWAlertSheet ()

/** 内容的 View*/
@property (nonatomic ,weak) UIView *contentView;

/** items 数组*/
@property (nonatomic ,strong) NSMutableArray *items;

@end

@implementation CBWAlertSheet


#pragma mark - lifeCircle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        self.alpha = 0.0;
     
    }
    return self;
}

-(void)addSheetWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertSheetHandler)handler{
    
    AlertSheetItem *item = [[AlertSheetItem alloc] init];
    item.title = title;
    item.color = color;
    item.action = handler;
    [self.items addObject:item];
}


- (void)creatContainerView{
    
    float x = 0;
    float y = screenH;
    float w = screenW;
    float h = self.items.count * buttonHeight + (self.items.count - 1) * margin;
    if (self.type == CBWAlertSheetTypeGap) {h = h + gap + buttonHeight;}
    
    CGRect frame = CGRectMake(x,y,w,h);
    UIView *contentView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:contentView];
    
    if (self.type == CBWAlertSheetTypeGap) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        UIColor *itemColor = self.cancleButtonTextColor?self.cancleButtonTextColor:cancelButtonTitleColor;
        [button setTitleColor:itemColor forState:UIControlStateNormal];
        [button setTitleColor:itemColor forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        button.backgroundColor = [UIColor clearColor];
        UIColor *cancleButtonNormalColor = self.cancleButtonColor ? self.cancleButtonColor:cancelButtonNormalColor;
        [button setBackgroundImage:[self imageWithColor:cancleButtonNormalColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:cancelButtonSelectedColor] forState:UIControlStateHighlighted];
        float btnX = 0;
        float btnY = h - buttonHeight;
        float btnW = screenW;
        float btnH = buttonHeight;
        [button setFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        [button addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        
        UIView *gapView = [[UIView alloc]initWithFrame:CGRectMake(0, btnY - gap, screenW, gap)];
        gapView.backgroundColor = gapColor;
        [contentView addSubview:gapView];

    }
    
    self.contentView = contentView;
    
}

- (void)setUpButtons:(UIView *)contentView{
    
    for (int i = 0; i<self.items.count; i++) {
        
        AlertSheetItem *item = self.items[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:item.title forState:UIControlStateNormal];
        UIColor *itemColor = item.color?item.color:defaultBlueColor;
        [button setTitleColor:itemColor forState:UIControlStateNormal];
        [button setTitleColor:itemColor forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        button.backgroundColor = [UIColor clearColor];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:colorHighLight] forState:UIControlStateHighlighted];
        float btnX = 0;
        float btnY = (i == 0 ) ? 0 : i * (buttonHeight + margin);
        float btnW = screenW;
        float btnH = buttonHeight;
        [button setFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        
        //设置分割线
        if (i > 0)
        {
            float sepratorViewX = 0;
            float sepratorViewY = (i - 1) * (buttonHeight + margin) + buttonHeight;
            float sepratorViewW = screenW;
            float sepratorViewH = margin;
            CGRect sepratorFrame = CGRectMake(sepratorViewX, sepratorViewY, sepratorViewW, sepratorViewH);
            UIView *sepratorView = [[UIView alloc]initWithFrame:sepratorFrame];
            sepratorView.backgroundColor = marginColor;
            [contentView addSubview:sepratorView];
        }
        
    }
}


- (void)cancelButtonAction{
    
    [self dismiss];
}

- (void)buttonAction:(UIButton *)button{
    
    AlertSheetItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismiss];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [self dismiss];
}

#pragma mark - show && dismiss

- (void)show{
    
    [self creatContainerView];
    
    [self setUpButtons:self.contentView];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
       
    //进行转场动画
    CGRect toRect = CGRectMake(0, screenH - self.contentView.frame.size.height, screenW,self.contentView.frame.size.height );
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.frame = toRect;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss{
    
    CGRect fromRect = CGRectMake(0, screenH, screenW,self.contentView.frame.size.height );
    
  [UIView animateWithDuration:dismisDuring delay:dismisDelay usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                         
                     self.contentView.frame = fromRect;
                         self.alpha = 0.0;
                         
                     } completion:^(BOOL finished) {
                         
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         
                         [self removeFromSuperview];
                     }];

    
}

#pragma mark - private
/**
 *   颜色转换为背景图片
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - setter && getter
-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
