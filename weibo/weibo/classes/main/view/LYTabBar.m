//
//  LYUITabBar.m
//  weibo
//
//  Created by 耿启富 on 2018/12/30.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import "LYTabBar.h"
#import "LYTabBarButton.h"

@interface LYTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic,strong) NSMutableArray *buttons;

@property (nonatomic,weak) UIButton *selectedButton;

@end

@implementation LYTabBar

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

#pragma  mark - 添加一个按钮的懒加载方法
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}
#pragma mark - 重写items的set方法，创建YGTabBarButton
-(void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        LYTabBarButton *btn = [LYTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
            
        }
        NSLog(@"this is one button%@",btn);
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}
// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    NSLog(@"this is all button%@",self.buttons);
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    // 调整系统自带的tabBar上的按钮位置
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        i++;
    }
    
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}

@end
