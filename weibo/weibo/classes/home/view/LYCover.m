//
//  YGCover.m
//  微博模拟
//
//  Created by Mac-c on 16/1/19.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import "LYCover.h"

@implementation LYCover

+(instancetype)show
{
    LYCover *cover = [[LYCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [LYKeyWindow addSubview:cover];
    
    return cover;
}
// 点击蒙板的时候做事情
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClick:)]) {
        
        [_delegate coverDidClick:self];
    }
}

@end
