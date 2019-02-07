//
//  LYAccountTool.h
//  weibo
//
//  Created by 耿启富 on 2019/2/7.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LYAccount;

@interface LYAccountTool : NSObject

+ (void)saveAccount:(LYAccount *)account;

+ (LYAccount *)account;

@end

NS_ASSUME_NONNULL_END
