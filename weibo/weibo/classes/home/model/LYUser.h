//
//  YGUser.h
//  微博模拟
//
//  Created by Mac-c on 16/1/25.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

@end
