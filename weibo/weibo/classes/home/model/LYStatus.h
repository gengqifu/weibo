//
//  YGStatus.h
//  微博模拟
//
//  Created by Mac-c on 16/1/25.
//  Copyright © 2016年 Mac-c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "LYUser.h"
#import "LYPhoto.h"

@interface LYStatus : NSObject<MJKeyValue>


//created_at	string	微博创建时间
//idstr	string	字符串型的微博ID
//text	string	微博信息内容
//source	string	微博来源
//user	object	微博作者的用户信息字段 详细
//retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
//reposts_count	int	转发数
//comments_count	int	评论数
//attitudes_count		int	表态数
//pic_urls  配图数组

/**
 *  微博创建时间
 */
@property (nonatomic,copy)  NSString *created_at;
/**
 *  字符串类型的微博ID
 */
@property(nonatomic,copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property(nonatomic,copy) NSString *text;
/**
 *  微博来源
 */
@property(nonatomic,copy) NSString *source;
/**
 *  转发数
 */
@property(nonatomic,assign)int reposts_count;
/**
 *  评论数
 */
@property(nonatomic,assign)int comments_count;
/**
 *  表态数
 */
@property(nonatomic,assign)int attitudes_count;
/**
 *  配图数组(YGPhoto)
 */
@property(nonatomic,strong) NSArray *pic_urls;
/**
 *  用户
 */
@property(nonatomic,strong)LYUser *user;
/**
 *  被转发的原微博信息字段
 */
@property(nonatomic,strong)LYStatus *retweeted_status;

@end
