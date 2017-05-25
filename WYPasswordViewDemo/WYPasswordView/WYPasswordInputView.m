//
//  WYPasswordView
//  WYKit
//  简书地址：http://www.jianshu.com/u/8f8143fbe7e4
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "WYPasswordInputView.h"
#import "WYConst.h"
#import "UIView+Extension.h"

#define kNumCount 6

@interface WYPasswordInputView ()

/** 保存用户输入的数字集合 */
@property (nonatomic, strong) NSMutableArray *inputNumArray;
/** 关闭按钮 */
@property (nonatomic, weak) UIButton *btnClose;
/** 忘记密码 */
@property (nonatomic, weak) UIButton *btnForgetPWD;

@end

@implementation WYPasswordInputView


#pragma mark  - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        /** 注册通知 */
        [self setupNotification];
        /** 添加子控件 */
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置关闭按钮的坐标
    self.btnClose.width = WYPasswordViewCloseButtonWH;
    self.btnClose.height = WYPasswordViewCloseButtonWH;
    self.btnClose.x = WYPasswordViewCloseButtonMarginLeft;
    self.btnClose.centerY = WYPasswordViewTitleHeight * 0.5;
    
    // 设置忘记密码按钮的坐标
    self.btnForgetPWD.x = WYScreenWith - (WYScreenWith - WYPasswordViewTextFieldWidth) * 0.5 - self.btnForgetPWD.width;
    self.btnForgetPWD.y = WYPasswordViewTitleHeight + WYPasswordViewTextFieldMarginTop + WYPasswordViewTextFieldHeight + WYPasswordViewForgetPWDButtonMarginTop;
}

- (void)dealloc
{
    NSLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 添加子控件 */
- (void)setupSubViews
{
    /** 关闭按钮 */
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnCancel];
    [btnCancel setBackgroundImage:[UIImage imageNamed:WYPasswordViewSrcName(@"password_close")] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.btnClose = btnCancel;
    [self.btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 忘记密码按钮 */
    UIButton *btnForgetPWD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnForgetPWD];
    [btnForgetPWD setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [btnForgetPWD setTitleColor:WYColor(0, 125, 227) forState:UIControlStateNormal];
    btnForgetPWD.titleLabel.font = WYFont(13);
    [btnForgetPWD sizeToFit];
    self.btnForgetPWD = btnForgetPWD;
    [self.btnForgetPWD addTarget:self action:@selector(btnForgetPWD_Click:) forControlEvents:UIControlEventTouchUpInside];
}

/** 注册通知 */
- (void)setupNotification {
    // 用户按下删除键通知
    [WYNotificationCenter addObserver:self selector:@selector(delete) name:WYPasswordViewDeleteButtonClickNotification object:nil];
    // 用户按下数字键通知
    [WYNotificationCenter addObserver:self selector:@selector(number:) name:WYPasswordViewNumberButtonClickNotification object:nil];
    [WYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:WYPasswordViewDisEnabledUserInteractionNotification object:nil];
    [WYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:WYPasswordViewEnabledUserInteractionNotification object:nil];
}



// 按钮点击
- (void)btnClose_Click:(UIButton *)sender {
    [WYNotificationCenter postNotificationName:WYPasswordViewCancleButtonClickNotification object:self];
    [self.inputNumArray removeAllObjects];
}

- (void)btnForgetPWD_Click:(UIButton *)sender {
    [WYNotificationCenter postNotificationName:WYPasswordViewForgetPWDButtonClickNotification object:self];
}

- (void) disEnalbeCloseButton:(NSNotification *)notification{
    BOOL flag = [[notification.object valueForKeyPath:@"enable"] boolValue];
    self.btnClose.userInteractionEnabled = flag;
    self.btnForgetPWD.userInteractionEnabled = flag;
}

- (void)drawRect:(CGRect)rect {
    // 画图
    UIImage *imgBackground = [UIImage imageNamed:WYPasswordViewSrcName(@"password_background")];
    UIImage *imgTextfield = [UIImage imageNamed:WYPasswordViewSrcName(@"password_textfield")];
    
    [imgBackground drawInRect:rect];
    
    
    CGFloat textfieldY = WYPasswordViewTitleHeight + WYPasswordViewTextFieldMarginTop;
    CGFloat textfieldW = WYPasswordViewTextFieldWidth;
    CGFloat textfieldX = (WYScreenWith - textfieldW) * 0.5;
    CGFloat textfieldH = WYPasswordViewTextFieldHeight;
    [imgTextfield drawInRect:CGRectMake(textfieldX, textfieldY, textfieldW, textfieldH)];
    
    // 画标题
    NSString *title = self.title ? self.title : @"输入交易密码";
    
    NSDictionary *arrts = @{NSFontAttributeName:WYFontB(18)};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = (WYPasswordViewTitleHeight - titleH) * 0.5;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = WYFontB(18);
    attr[NSForegroundColorAttributeName] = WYColor(102, 102, 102);
    [title drawInRect:titleRect withAttributes:attr];
    
    // 画点
    UIImage *pointImage = [UIImage imageNamed:WYPasswordViewSrcName(@"password_point")];
    CGFloat pointW = WYPasswordViewPointnWH;
    CGFloat pointH = WYPasswordViewPointnWH;
    CGFloat pointY =  textfieldY + (textfieldH - pointH) * 0.5;
    __block CGFloat pointX;
    
    // 一个格子的宽度
    CGFloat cellW = textfieldW / kNumCount;
    CGFloat padding = (cellW - pointW) * 0.5;
    [self.inputNumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        pointX = textfieldX + (2 * idx + 1) * padding + idx * pointW;
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }];
}

- (void)removeNumber
{
    [self.inputNumArray removeAllObjects];
    [self setNeedsDisplay];
    
}


#pragma mark  - 懒加载
- (NSMutableArray *)inputNumArray {
    if (_inputNumArray == nil) {
        _inputNumArray = [NSMutableArray array];
    }
    return _inputNumArray;
}

#pragma mark  - 私有方法
// 响应用户按下删除键事件
- (void)delete {
    [self.inputNumArray removeLastObject];
    [self setNeedsDisplay];
}

// 响应用户按下数字键事件
- (void)number:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSString *numObj = userInfo[WYPasswordViewKeyboardNumberKey];
    if (numObj.length >= kNumCount) return;
    [self.inputNumArray addObject:numObj];
    [self setNeedsDisplay];
}



@end
