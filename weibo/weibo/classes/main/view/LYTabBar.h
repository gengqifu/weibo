//
//  LYUITabBar.h
//  weibo
//
//  Created by 耿启富 on 2018/12/30.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTabBar;
@protocol LYTabBarDelegate <NSObject>

@optional
-(void)tabBar:(LYTabBar*)tabBar didClickButton:(NSInteger)index;

@end

@interface LYTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property(nonatomic,weak) id <LYTabBarDelegate> delegate;
@end
