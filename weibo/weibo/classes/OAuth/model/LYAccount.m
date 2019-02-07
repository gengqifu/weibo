//
//  LYAccount.m
//  weibo
//
//  Created by 耿启富 on 2019/2/7.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYAccount.h"

#define LYAccountTokenKey @"token"
#define LYUidKey @"uid"
#define LYExpires_inKey @"exoires"
#define LYExpires_dateKey @"date"
#define LYIsRealNameKey @"isRealName"

@implementation LYAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    LYAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:LYAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:LYExpires_inKey];
    [aCoder encodeObject:_uid forKey:LYUidKey];
    [aCoder encodeObject:_expires_date forKey:LYExpires_dateKey];
    [aCoder encodeBool:_isRealName forKey:LYIsRealNameKey];
}

// 解档的时候调用：告诉系统哪个属性需要解档，如何解档

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        // 一定要记得赋值
        _access_token =  [aDecoder decodeObjectForKey:LYAccountTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:LYExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:LYUidKey];
        _expires_date = [aDecoder decodeObjectForKey:LYExpires_dateKey];
        _isRealName = [aDecoder decodeBoolForKey:LYIsRealNameKey];
    }
    return self;
}

@end
