//
//  YGCover.h
//  微博模拟
//
//  Created by Mac-c on 16/1/19.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYCover;
@protocol LYCoverDelegate <NSObject>

@optional
//点击蒙板时调用
-(void)coverDidClick:(LYCover*)cover;

@end

@interface LYCover : UIView
/**
 *  显示蒙板
 */
+(instancetype)show;
@property(nonatomic,weak)id<LYCoverDelegate> delegate;

@end
