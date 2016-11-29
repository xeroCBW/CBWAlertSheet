//
//  CBWAlertSheet.m
//  alertView
//
//  Created by 陈博文 on 16/6/27.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWAlertSheet.h"

static float const titleFont = 14.0;
static float const lrMargin = 20;
static float const normalMargin = 20.0;
static float const titleLabelBottomMargin = 5;
static float const messageFont = 13.0;
static float const margin = 0.5;
static float const dismisDuring = 0.3f;
static float const dismisDelay = 0.0f;
static float const buttonFont = 17.0;
static float const buttonHeight  = 50.0;
static float const gap = 10;//取消按钮与上面的 gap
static int const cancelButtonTag = 999;
static int const cancelGapViewtag = 1000;
static int const sheetButtonMarginViewTag = 1999;

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define defaultBlackColor [UIColor blackColor]
#define colorHighLight [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:0.9]
#define marginColor [UIColor colorWithRed:196.0/255 green:196.0/255 blue:201.0/255 alpha:1.0]

#define cancelButtonTitleColor [UIColor whiteColor]//取消按钮默认 title颜色
#define cancelButtonNormalColor [UIColor colorWithRed:0.510  green:0.745  blue:0.992 alpha:1]
#define cancelButtonSelectedColor colorHighLight
#define gapColor [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:238.0/255.0 alpha:1.0]
#define textDefaultColor [UIColor lightGrayColor]

#pragma mark - CBWAlertSheetLabel

@interface CBWAlertSheetLabel : UILabel

@end

@implementation CBWAlertSheetLabel

//给 label 增加左右 padding
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, lrMargin, 0, lrMargin};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end

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

/** 标题的 label*/
@property (nonatomic, strong)CBWAlertSheetLabel *titleLabel;

/** message的 label*/
@property (nonatomic, strong)CBWAlertSheetLabel *messageLabel;

@property (nonatomic, strong)UIView *marginView;

@property (nonatomic, assign) CGSize titleSize;

@property (nonatomic, assign) CGSize messageSize;

@property (nonatomic, assign)CGRect cancelButtonFrame;

@end

@implementation CBWAlertSheet


#pragma mark - lifeCircle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initBase];
    }
    return self;
}


- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        
        [self initBase];
        
    }
    return self;
}

- (void)initBase{

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置尺寸跟随屏幕
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;//设置尺寸跟随屏幕
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    self.alpha = 0.0;

}

#pragma mark - subView

-(void)addSheetWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertSheetHandler)handler{
    
    AlertSheetItem *item = [[AlertSheetItem alloc] init];
    item.title = title;
    item.color = color;
    item.action = handler;
    [self.items addObject:item];
}


- (void)creatContainerView{
    
    if (self.contentView == nil) {
        
        [self setUpDefaultView];
    }
    
    if (self.type == CBWAlertSheetTypeCancelButton)
    {
        [self setUpcancelButton];
    }
    
}


- (void)setUpDefaultView{
    
    [self setUpContentView];
    
    [self setUpTitleAndMessageView];
    
}

- (void)setUpContentView{
    
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = [self calculateContentViewFrameWithRatate:NO];
    
    
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    self.contentView = contentView;
    
}

- (void)setUpTitleAndMessageView{
   
    NSString *title = self.title;
    NSString *message = self.message;
    
    if (![self isBlankString:title]) {
        
        [self.contentView addSubview:self.titleLabel];
    }
    
    if (![self isBlankString:message]) {
       
        [self.contentView addSubview:self.messageLabel];
    }
    
    if (![self isBlankString:title]||![self isBlankString:message]) {

        [self.contentView addSubview:self.marginView];
    }

}

- (void)setUpcancelButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = cancelButtonTag;
    [button setTitle:@"取消" forState:UIControlStateNormal];
    UIColor *itemColor = self.cancleButtonTextColor?self.cancleButtonTextColor:cancelButtonTitleColor;
    [button setTitleColor:itemColor forState:UIControlStateNormal];
    [button setTitleColor:itemColor forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
    button.backgroundColor = [UIColor clearColor];
    UIColor *cancleButtonNormalColor = self.cancleButtonColor ? self.cancleButtonColor:cancelButtonNormalColor;
    [button setBackgroundImage:[self imageWithColor:cancleButtonNormalColor] forState:UIControlStateNormal];

    [button setFrame:self.cancelButtonFrame];//开始预设宽度,后面屏幕旋转会UIViewAutoresizingFlexibleWidth进行跟随
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置宽度屏幕跟随
    [button addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
    UIView *gapView = [[UIView alloc]initWithFrame:CGRectMake(0, self.cancelButtonFrame.origin.y - gap, screenW, gap)];//开始预设宽度,后面屏幕旋转会UIViewAutoresizingFlexibleWidth进行跟随
    gapView.tag = cancelGapViewtag;
    gapView.backgroundColor = gapColor;
    gapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置宽度屏幕跟随
    [self.contentView addSubview:gapView];
}

- (void)setUpButtons:(UIView *)contentView{
    
    for (int i = 0; i<self.items.count; i++) {
        
        AlertSheetItem *item = self.items[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:item.title forState:UIControlStateNormal];
        UIColor *itemColor = item.color?item.color:defaultBlackColor;
        [button setTitleColor:itemColor forState:UIControlStateNormal];
        [button setTitleColor:itemColor forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        button.backgroundColor = [UIColor clearColor];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:colorHighLight] forState:UIControlStateHighlighted];
        
        float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
        gap + buttonHeight:
        0;
        float base =self.contentView.bounds.size.height - (self.items.count * buttonHeight + (self.items.count - 1) * margin) - delta;
        float btnX = 0;
        float btnY = base +i * (buttonHeight + margin);
        float btnW = screenW;//先预设值,后面屏幕旋转用UIViewAutoresizingFlexibleWidth
        float btnH = buttonHeight;
        
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        button.tag = i;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        
        //设置分割线
        if (i > 0)
        {
            
            float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
            gap + buttonHeight:
            0;
            float base =self.contentView.bounds.size.height - (self.items.count * buttonHeight + (self.items.count - 1) * margin) - delta;

            float sepratorViewX = 0;
            float sepratorViewY = base + (i - 1) * (buttonHeight + margin) + buttonHeight;
            float sepratorViewW = screenW;//先预设值,后面屏幕旋转用UIViewAutoresizingFlexibleWidth
            float sepratorViewH = margin;
            CGRect sepratorFrame = CGRectMake(sepratorViewX, sepratorViewY, sepratorViewW, sepratorViewH);
            UIView *sepratorView = [[UIView alloc]initWithFrame:sepratorFrame];
            sepratorView.tag = sheetButtonMarginViewTag + i;
            
            sepratorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置宽度屏幕跟随
            
            sepratorView.backgroundColor = marginColor;
            [contentView addSubview:sepratorView];
        }
        
    }
}


- (void)cancelButtonAction{
    
    [self dismiss];
}

- (void)buttonAction:(UIButton *)button{
    
    [self dismiss];

    AlertSheetItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
}


#pragma mark - show && dismiss

- (void)show{
    
   [self creatContainerView];
    
   [self setUpButtons:self.contentView];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    //如果发现键盘windows 出现,就选键盘下一个 windows
    if ([window isKindOfClass:[NSClassFromString(@"UIRemoteKeyboardWindow") class]]) {
        
        window = [[UIApplication sharedApplication].windows objectAtIndex:([UIApplication sharedApplication].windows.count -2)];
    }
    
    [window addSubview:self];
       
    //进行转场动画
    CGRect toRect = CGRectMake(0, screenH - self.contentView.frame.size.height, screenW,self.contentView.frame.size.height );
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.frame = toRect;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss{
    
    
    //下拉框可以实现比较顺滑的消失效果-->高度设置成0就可以
    
    //往上弹的实现的话改变 height-->直接在屏幕中间会一闪(由于 y 值没有变 height 变成0),直接在屏幕中了
    
    [UIView animateWithDuration:dismisDuring delay:dismisDelay usingSpringWithDamping:10.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect frame = self.contentView.frame ;
        
        frame.origin.y = screenH;
        
        self.contentView.frame = frame;
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        for (UIView *v in [self subviews]) {
            [v removeFromSuperview];
        }
        
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    BOOL isInContentView = CGRectContainsPoint(self.contentView.frame, point);
    
    if (!isInContentView) {
        
        [self dismiss];
    }
    
}

#pragma mark - resizing
/*
 系统会判断是否需要重新 layoutSubView
 例如:横屏-->竖屏
 例如:竖屏-->横屏
 横屏-->横屏:不会重新 layOut
 竖屏-->竖屏:不会重新 layOut
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //由于是设置了 autosizng;但是还是要设置下尺寸
    
    //重新设置 frame
    float w = [UIScreen mainScreen].bounds.size.width;
    float h = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, w, h);
    
    //布局 contentView
    float contentViewH = [self calculateContentViewFrameWithRatate:YES].size.height;//h
    float contentViewW = w;
    float contentViewX = 0;
    float contentViewY = h - contentViewH;
    self.contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
    
    //布局 titleLabel
    if (![self isBlankString:self.title]) {
        self.titleLabel.frame = CGRectMake( 0, normalMargin, self.contentView.frame.size.width, self.titleSize.height);
    }
    //布局 messageLabel
    if (![self isBlankString:self.message]) {
        
        float messageY = [self isBlankString:self.title] ?
        normalMargin :
        normalMargin + self.titleSize.height + titleLabelBottomMargin;
        self.messageLabel.frame = CGRectMake( 0, messageY, self.contentView.frame.size.width, self.messageSize.height);
    }
    //布局 gapView
    if (![self isBlankString:self.title]||![self isBlankString:self.message]) {
        
        float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
        gap + buttonHeight:0;
        float x = 0;
        float y = self.contentView.frame.size.height - delta - margin - (self.items.count * buttonHeight + (self.items.count - 1) * margin);
        self.marginView.frame = CGRectMake(x, y, w, margin);
    }
    
    //布局按钮
    [self layoutButtons];
}

- (void)layoutButtons{

    for (UIResponder *repsonse in self.contentView.subviews) {
        
        if ([repsonse isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)repsonse;
            
            [self resizingButton:btn];
            
        }else if ([repsonse isKindOfClass:[UIView class]]){
            
            UIView *view = (UIView *)repsonse;
            
            [self resizingMarginView:view];
            
        }
    }
}


- (void)resizingButton:(UIButton *)btn{
    
     NSLog(@"button.tag=%ld",(long)btn.tag);
    
    if (btn.tag == cancelButtonTag) {
        //处理取消按钮
        float btnX = 0;
        float btnY = self.contentView.frame.size.height - buttonHeight;
        float btnW = screenW;
        float btnH = buttonHeight;
        [btn setFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        
    }else{
        //处理正常按钮
        NSInteger i = btn.tag;

        float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
        gap + buttonHeight:
        0;
        float base =self.contentView.bounds.size.height - (self.items.count * buttonHeight + (self.items.count - 1) * margin) - delta;
        float btnX = 0;
        float btnY = base +i * (buttonHeight + margin);
        float btnW = screenW;//先预设值,后面屏幕旋转用UIViewAutoresizingFlexibleWidth
        float btnH = buttonHeight;
        [btn setFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        
    }

}

- (void)resizingMarginView:(UIView *)view{
    
    if (view.tag == cancelGapViewtag) {
        
        view.frame = CGRectMake(0, self.cancelButtonFrame.origin.y - gap, self.contentView.frame.size.width, gap);
     
    }
    
    if (view.tag > sheetButtonMarginViewTag) {
        
        NSInteger i = view.tag - sheetButtonMarginViewTag;
        
        //设置分割线
        if (i > 0)
        {
            
            float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
            gap + buttonHeight:
            0;
            float base =self.contentView.bounds.size.height - (self.items.count * buttonHeight + (self.items.count - 1) * margin) - delta;
            
            float sepratorViewX = 0;
            float sepratorViewY = base + (i - 1) * (buttonHeight + margin) + buttonHeight;
            float sepratorViewW = screenW;//先预设值,后面屏幕旋转用UIViewAutoresizingFlexibleWidth
            float sepratorViewH = margin;
            CGRect sepratorFrame = CGRectMake(sepratorViewX, sepratorViewY, sepratorViewW, sepratorViewH);
            view.frame = sepratorFrame;
            
        }
        
        
    }

}

#pragma mark - private

/**
 *  判断是否是空字符串
 */
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
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

/**
 *   计算 contentView 的高度
 */
- (CGRect )calculateContentViewFrameWithRatate:(BOOL )rotated{
    
    CGFloat x = 0;
    CGFloat y = rotated ? 0:[UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    NSString *title = self.title;
    NSString *message = self.message;
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:titleFont];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;//用粗体计算,否者会出现横线,不知道为什么
    UIFont *msgFont = [UIFont fontWithName:@"HelveticaNeue" size:messageFont];
    CGSize messageSize = [message boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:msgFont} context:nil].size;
    //h需要改变
    float h = 0;
    
    if (![self isBlankString:title]||![self isBlankString:message]) {
        h = h + 2 * normalMargin + margin;
        
    }
    
    if (![self isBlankString:title]) {
        h = h + titleSize.height;
    }
    
    if (![self isBlankString:message]) {
        h = h + messageSize.height;
    }
    
    if (![self isBlankString:message]&&![self isBlankString:title]) {
        h = h + titleLabelBottomMargin;
    }
    
    h = h + self.items.count * buttonHeight + (self.items.count - 1) * margin;
    if (self.type == CBWAlertSheetTypeCancelButton) {h = h + gap + buttonHeight;}
    
    return  CGRectMake(x, y, w, h);
}
#pragma mark - setter && getter
-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(CBWAlertSheetLabel *)titleLabel{
    if (_titleLabel == nil) {
        
        CBWAlertSheetLabel *titleLabel = [[CBWAlertSheetLabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:titleFont];
        titleLabel.textColor = self.titleTextColor?self.titleTextColor:textDefaultColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 0;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置宽度跟随屏幕
        titleLabel.frame = CGRectMake( 0, normalMargin, self.contentView.frame.size.width, self.titleSize.height);

        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(CBWAlertSheetLabel *)messageLabel{
    
    if (_messageLabel == nil) {
  
        // 初始化label
        CBWAlertSheetLabel *messageLabel = [[CBWAlertSheetLabel alloc]init];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = self.messageTextColor?self.messageTextColor:textDefaultColor;
        // label获取字符串
        messageLabel.text = self.message;
        messageLabel.backgroundColor = [UIColor whiteColor];
        // label获取字体
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:messageFont];
        // 设置无限换行
        messageLabel.numberOfLines = 0;
        float messageY = [self isBlankString:self.title] ?
        normalMargin :
        normalMargin + self.titleSize.height + titleLabelBottomMargin;
        messageLabel.frame = CGRectMake( 0, messageY, self.contentView.frame.size.width, self.messageSize.height);
        messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;//设置宽度跟随屏幕
        
        _messageLabel = messageLabel;
          }
    return _messageLabel;
}

-(UIView *)marginView{
    
    if (_marginView == nil) {
        
        float delta = (self.type == CBWAlertSheetTypeCancelButton) ?
        gap + buttonHeight:0;
        
        float x = 0;
        float y = self.contentView.frame.size.height - delta - margin - (self.items.count * buttonHeight + (self.items.count - 1) * margin);
        float w = screenW;
        float h = margin;
        
        UIView *margin = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        margin.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        margin.backgroundColor = marginColor;
        
        _marginView = margin;
    }
    return _marginView;
}
-(CGSize)titleSize{
    
  
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:titleFont];
    CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake( screenW - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;//用粗体计算,否者会出现横线,不知道为什么
    _titleSize = titleSize;
    
    return _titleSize;
}


-(CGSize)messageSize{
    
    UIFont *msgFont = [UIFont fontWithName:@"HelveticaNeue" size:messageFont];
    CGSize messageSize = [self.message boundingRectWithSize:CGSizeMake( screenW - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:msgFont} context:nil].size;
    
    _messageSize = messageSize;
    return _messageSize;
}


-(CGRect)cancelButtonFrame{
    
    float btnX = 0;
    float btnY = self.contentView.bounds.size.height - buttonHeight;
    float btnW = screenW;
    float btnH = buttonHeight;
    CGRect cancelButtonFrame = CGRectMake(btnX, btnY, btnW, btnH);
    
    _cancelButtonFrame = cancelButtonFrame;
    return _cancelButtonFrame;
}
@end

