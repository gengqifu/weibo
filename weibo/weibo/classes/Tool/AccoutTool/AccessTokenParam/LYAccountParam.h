//
//  LYAccountParam.h
//  weibo
//
//  Created by 耿启富 on 2019/2/8.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAccountParam : NSObject

/**
 *  AppKey
 */
@property (nonatomic, copy) NSString *client_id;
/**
 *  AppSecret
 */
@property (nonatomic, copy) NSString *client_secret;
/**
 *  请求的类型,填写authorization_code
 */
@property (nonatomic, copy) NSString *grant_type;
/**
 *  调用authorize获得的code值
 */
@property (nonatomic, copy) NSString *code;
/**
 *  回调地址
 */
@property (nonatomic, copy) NSString *redirect_uri;

@end

NS_ASSUME_NONNULL_END
