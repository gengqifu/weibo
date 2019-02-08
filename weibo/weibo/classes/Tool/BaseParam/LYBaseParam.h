//
//  LYBaseParam.h
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseParam : NSObject

@property(nonatomic,copy)NSString* access_token;
+(instancetype)param;

@end

NS_ASSUME_NONNULL_END
