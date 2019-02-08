//
//  LYUnreadTool.m
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYUnreadTool.h"
#import "LYUnreadResult.h"
#import "LYAccountTool.h"
#import "LYUnreadMsgParam.h"
#import "LYHttpTool.h"
#import "MJExtension.h"
#import "LYAccount.h"

@implementation LYUnreadTool

+(void)unreadWithSuccess:(void (^)(LYUnreadResult *))success failure:(void (^)(NSError *))failure
{
    LYUnreadMsgParam *param =[LYUnreadMsgParam param];
    param.uid    =  [LYAccountTool account].uid;
    [LYHttpTool   GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        // 字典转模型
        LYUnreadResult *result = [LYUnreadResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
