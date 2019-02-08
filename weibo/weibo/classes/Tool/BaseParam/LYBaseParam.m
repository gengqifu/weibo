//
//  LYBaseParam.m
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYBaseParam.h"
#import "LYAccount.h"
#import "LYAccountTool.h"

@implementation LYBaseParam

+(instancetype)param
{
    LYBaseParam *param = [[self alloc]init];
    param.access_token =[LYAccountTool account].access_token;
    return param;
}

@end
