//
//  DLActivityRefreshView.m
//  ScrollRefreshDataDemo
//
//  Created by Kai Shi on 2018/11/7.
//  Copyright © 2018 Kai Shi. All rights reserved.
//

#import "DLActivityRefreshView.h"
#import "DLActivityRefreshDefine.h"

@interface DLActivityRefreshView()<UIScrollViewDelegate>

@property (strong, nonatomic)UIActivityIndicatorView *activityView;

@property (strong, nonatomic)UIScrollView *loadingScrollView;

@property (copy, nonatomic)ActivityRefreshingBlock refreshingBlock;

@property (copy, nonatomic)ActivityEndRefreshingBlock endRefreshingBlock;

@property (strong, nonatomic) UIPanGestureRecognizer *pan;

@end

@implementation DLActivityRefreshView

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView refreshingBlock:(nonnull ActivityRefreshingBlock)refreshingBlock endRefreshingBlock:(nonnull ActivityEndRefreshingBlock)endRefreshingBlock{
    if (self == [super initWithFrame:frame]) {
        self.loadingScrollView = scrollView;
        self.activityView = [[UIActivityIndicatorView alloc] init];
        self.activityView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self addSubview:self.activityView];
        _refreshingBlock = refreshingBlock;
        _endRefreshingBlock = endRefreshingBlock;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self.loadingScrollView addObserver:self forKeyPath:DLActivityRefreshKeyPathContentOffset options:options context:nil];
        self.pan = self.loadingScrollView.panGestureRecognizer;
        [self.pan addObserver:self forKeyPath:DLActivityRefreshKeyPathPanState options:options context:nil];
    }
    return self;
}

- (void)setActivityViewLoadingStyle:(UIActivityIndicatorViewStyle)style{
    self.activityView.activityIndicatorViewStyle = style;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:DLActivityRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:DLActivityRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.pan.state == UIGestureRecognizerStateChanged) {
        self.activityView.hidden = NO;
        self.activityView.transform = CGAffineTransformMakeRotation((self.loadingScrollView.contentOffset.y/[UIScreen mainScreen].bounds.size.width)*LoadingViewTransformMultiple * M_PI);
    }
    
    //此处判断 == 初始offset值
    if ((fabs(self.loadingScrollView.contentOffset.y) == ScrollViewInitOffsetValue) && !self.activityView.isAnimating ) {
        self.activityView.hidden = YES;
        if (self.endRefreshingBlock) {
            self.endRefreshingBlock();
        }
    }
    
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    if (self.pan.state == UIGestureRecognizerStateEnded) {
        if (fabs(self.loadingScrollView.contentOffset.y) > DraggingMaxOffsetToLoading) {
            if (!self.activityView.isAnimating) {
                [self startAnimating];
            }
        }
    }
}

- (void)startAnimating{
    [self.activityView startAnimating];
    if (self.refreshingBlock) {
        self.refreshingBlock();
    }
    [self performSelector:@selector(stopAnimating) withObject:nil afterDelay:LoadingTimeOut];
}

/**
 结束loading
 */
- (void)stopAnimating{
    if (self.endRefreshingBlock) {
        self.endRefreshingBlock();
    }
    [self.activityView stopAnimating];
}

@end
