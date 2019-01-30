//
//  UIImage+image.h
//  微博模拟
//
//  Created by Mac-c on 16/1/16.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
