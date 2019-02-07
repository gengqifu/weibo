//
//  LYAccountTool.m
//  weibo
//
//  Created by 耿启富 on 2019/2/7.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYAccountTool.h"
#import "LYAccount.h"

@implementation LYAccountTool

#define LYAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

// 类方法一般用静态变量代替成员属性

static LYAccount *_account;
+ (void)saveAccount:(LYAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:LYAccountFileName];
}

+ (LYAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:LYAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    return _account;
}

@end
