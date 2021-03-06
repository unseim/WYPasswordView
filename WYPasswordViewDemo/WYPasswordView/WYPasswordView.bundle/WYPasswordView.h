//
//  WYPasswordView.h
//  WYPasswordViewDemo
//
//  Created by 汪年成 on 17/5/25.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPasswordInputView.h"
#import "WYConst.h"

@interface WYPasswordView : UIView

/** 正在请求时显示的文本 */
@property (nonatomic, copy) NSString *loadingText;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *password);

/** 密码框的标题 */
@property (nonatomic, copy) NSString *title;

/** 弹出密码框 */
- (void)showInView;

/** 隐藏键盘 */
- (void)hideKeyboard;

/** 隐藏密码框 */
- (void)hide;

/** 开始加载 */
- (void)startLoading;



/** 加载完成 */
- (void)stopLoading;

/** 请求完成 */
- (void)requestComplete:(BOOL)state;
- (void)requestComplete:(BOOL)state message:(NSString *)message;


@end
