//
//  LYStatusParam.m
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYStatusResult.h"
#import "LYStatus.h"

@implementation LYStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[LYStatus class]};
}

@end
