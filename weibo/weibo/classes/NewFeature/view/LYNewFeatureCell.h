//
//  LYNewFeatureCell.h
//  weibo
//
//  Created by 耿启富 on 2019/2/4.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end

NS_ASSUME_NONNULL_END
