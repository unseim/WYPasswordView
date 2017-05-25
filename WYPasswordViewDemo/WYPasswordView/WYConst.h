//
//  WYPasswordView
//  WYKit
//  简书地址：http://www.jianshu.com/u/8f8143fbe7e4
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

/** RGB颜色 */
#define WYColor(r, g, b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** RGB颜色带透明度 */
#define WYColor_A(r, g, b, a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


/** 字体大小 */
#define WYLabelFont [UIFont boldSystemFontOfSize:13]
#define WYFont(f)   [UIFont systemFontOfSize:(f)]
#define WYFontB(f)  [UIFont boldSystemFontOfSize:(f)]

/** 图片路径 */
#define WYPasswordViewSrcName(file) [@"WYPasswordView.bundle" stringByAppendingPathComponent:file]

/** 屏幕的宽高 */
#define WYScreen                [UIScreen mainScreen]
#define WYScreenWith            [UIScreen mainScreen].bounds.size.width
#define WYScreenHeight          [UIScreen mainScreen].bounds.size.height

/** 通知 */
#define WYNotificationCenter    [NSNotificationCenter defaultCenter]


/*****************  常量  *****************/


/** 密码框的高度 */
UIKIT_EXTERN const CGFloat WYPasswordInputViewHeight;
/** 密码框标题的高度 */
UIKIT_EXTERN const CGFloat WYPasswordViewTitleHeight;
/** 密码框显示或隐藏时间 */
UIKIT_EXTERN const CGFloat WYPasswordViewAnimationDuration;
/** 关闭按钮的宽高 */
UIKIT_EXTERN const CGFloat WYPasswordViewCloseButtonWH;
/** 关闭按钮的左边距 */
UIKIT_EXTERN const CGFloat WYPasswordViewCloseButtonMarginLeft;
/** 输入点的宽高 */
UIKIT_EXTERN const CGFloat WYPasswordViewPointnWH;
/** TextField图片的宽 */
UIKIT_EXTERN const CGFloat WYPasswordViewTextFieldWidth;
/** TextField图片的高 */
UIKIT_EXTERN const CGFloat WYPasswordViewTextFieldHeight;
/** TextField图片向上间距 */
UIKIT_EXTERN const CGFloat WYPasswordViewTextFieldMarginTop;
/** 忘记密码按钮向上间距 */
UIKIT_EXTERN const CGFloat WYPasswordViewForgetPWDButtonMarginTop;

UIKIT_EXTERN NSString *const WYPasswordViewKeyboardNumberKey;



/*****************       通知      *****************/
UIKIT_EXTERN NSString *const WYPasswordViewCancleButtonClickNotification;
UIKIT_EXTERN NSString *const WYPasswordViewDeleteButtonClickNotification;
UIKIT_EXTERN NSString *const WYPasswordViewNumberButtonClickNotification;
UIKIT_EXTERN NSString *const WYPasswordViewForgetPWDButtonClickNotification;
UIKIT_EXTERN NSString *const WYPasswordViewEnabledUserInteractionNotification;
UIKIT_EXTERN NSString *const WYPasswordViewDisEnabledUserInteractionNotification;




