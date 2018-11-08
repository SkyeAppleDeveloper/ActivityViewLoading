//
//  DLActivityRefreshView.h
//  ScrollRefreshDataDemo
//
//  Created by Kai Shi on 2018/11/7.
//  Copyright © 2018 Kai Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActivityRefreshingBlock)(void);

typedef void(^ActivityEndRefreshingBlock)(void);

@interface DLActivityRefreshView : UIView

/**
 初始化刷新控件

 @param frame 位置
 @param scrollView 需要监测的滑动视图
 @param refreshingBlock 刷新回调
 @param endRefreshingBlock 结束刷新回调(包括回弹回调)
 @return init3
 */
- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView refreshingBlock:(ActivityRefreshingBlock)refreshingBlock endRefreshingBlock:(ActivityEndRefreshingBlock)endRefreshingBlock;

/**
 设置loading style

 @param style 具体样式
 */
- (void)setActivityViewLoadingStyle:(UIActivityIndicatorViewStyle)style;

/**
 结束loading
 */
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
