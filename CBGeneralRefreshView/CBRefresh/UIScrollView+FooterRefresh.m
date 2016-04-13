//
//  UIScrollView+FooterRefresh.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/4/13.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "UIScrollView+FooterRefresh.h"
#import <objc/runtime.h>

static char CBFooterRefreshView;

@implementation UIScrollView (FooterRefresh)

-(void)addRefreshFooter:(NSArray *)imageNames delegate:(UIViewController<CBRefreshFooterViewDelegate> *)delegate{
    if (!self.footerView) {
        self.footerView = [[CBRefreshFooterView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.frame.size.width, FOOTER_HEIGHT) andImages:imageNames];
        self.footerView.refreshDelegate = delegate;
        self.footerView.scrollView = self;
        self.footerView.isObserving = NO;
        [self addSubview:self.footerView];
        
        self.isShowRefreshFooterView = YES;
    }
}

-(void)stopFooterAnimating{
    self.footerView.state = CBRefreshStateStopped;
}

#pragma mark- get set
-(CBRefreshFooterView *)footerView{
    return objc_getAssociatedObject(self, &CBFooterRefreshView);
}

-(void)setFooterView:(CBRefreshFooterView *)footerView{
    objc_setAssociatedObject(self, &CBFooterRefreshView, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(BOOL)isShowRefreshFooterView{
    return !self.footerView.hidden;
}

-(void)setIsShowRefreshFooterView:(BOOL)isShowRefreshFooterView{
    self.footerView.hidden = !isShowRefreshFooterView;
    
    if(!isShowRefreshFooterView) {
        if (self.footerView.isObserving) {
            [self removeObserver:self.footerView forKeyPath:@"contentOffset"];
            [self removeObserver:self.footerView forKeyPath:@"contentSize"];
            [self.footerView resetScrollViewContentInset];
            self.footerView.isObserving = NO;
        }
    }
    else {
        if (!self.footerView.isObserving) {
            [self addObserver:self.footerView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.footerView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [self.footerView setScrollViewContentInsetForInfiniteScrolling];
            self.footerView.isObserving = YES;

        }
    }
}

@end
