//
//  LYUnreadTool.h
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYUnreadResult;

NS_ASSUME_NONNULL_BEGIN

@interface LYUnreadTool : NSObject

+(void)unreadWithSuccess:(void(^)(LYUnreadResult *result)) success failure:(void(^)(NSError *error)) failure;

@end

NS_ASSUME_NONNULL_END
