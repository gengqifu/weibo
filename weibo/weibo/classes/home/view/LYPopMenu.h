//
//  YGPopMenu.h
//  微博模拟
//
//  Created by Mac-c on 16/1/19.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPopMenu : UIImageView
/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

// 内容视图
@property (nonatomic, weak) UIView *contentView;

@end
