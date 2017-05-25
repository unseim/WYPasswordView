//
//  WYPasswordInputView.h
//  WYPasswordViewDemo
//
//  Created by 汪年成 on 17/5/25.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYPasswordInputView : UIView


@property (nonatomic, copy) NSString *title;

/** 删除所有密码 */
- (void)removeNumber;

@end
