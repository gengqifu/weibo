//
//  LYStatusResult.h
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;

@end

NS_ASSUME_NONNULL_END
