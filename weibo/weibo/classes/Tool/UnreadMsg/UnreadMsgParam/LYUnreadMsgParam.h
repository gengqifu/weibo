//
//  LYUnreadMsgParam.h
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYUnreadMsgParam : LYBaseParam

/**
 *  当前用户唯一标识符
 */
@property(nonatomic,copy)NSString* uid;

@end

NS_ASSUME_NONNULL_END
