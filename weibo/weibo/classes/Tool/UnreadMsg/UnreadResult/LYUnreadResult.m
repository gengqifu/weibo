//
//  LYUnreadResult.m
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYUnreadResult.h"

@implementation LYUnreadResult

-(int)messageCount
{
    
    return _cmt+_mention_cmt+_mention_status;
    
}
-(int)totalCount
{
    return _status+_dm+_follower+_cmt+_mention_cmt+_mention_status;
}

@end
