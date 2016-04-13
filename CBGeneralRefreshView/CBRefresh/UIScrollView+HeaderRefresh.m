//
//  UIScrollView+HeaderRefresh.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "UIScrollView+HeaderRefresh.h"
#import <objc/runtime.h>



static char CBHeaderRefreshView;


@implementation UIScrollView (HeaderRefresh)

- (void)addRefreshHeader:(NSArray *)imageNames delegate:(UIViewController<CBRefreshHeaderViewDelegate> * )delegate{
    
    if (!self.headerView) {
        
        CBRefreshHeaderView * view = [[CBRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -HEADER_HEIGHT, self.frame.size.width, HEADER_HEIGHT) loadingImages:imageNames];
        self.headerView = view;
        self.headerView.scrollView = self;
        self.headerView.refreshDelegate = delegate;
        [self addSubview:view];
        
        self.isShowRefreshHeaderView = YES;
        
    }
    
}


#pragma mark set get

//headerView
- (void)setHeaderView:(CBRefreshHeaderView *)headerView{
    objc_setAssociatedObject(self, &CBHeaderRefreshView, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CBRefreshHeaderView *)headerView{
    return objc_getAssociatedObject(self, &CBHeaderRefreshView);
    
}


//hide the headerView or not
-(void)setIsShowRefreshHeaderView:(BOOL)isShowRefreshHeaderView{
    
    self.headerView.hidden = !isShowRefreshHeaderView;
    
    if (isShowRefreshHeaderView == YES) {
        if (self.headerView.isOberVing != YES) {
            
            self.headerView.isOberVing = YES;
            
            [self addObserver:self.headerView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.headerView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.headerView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            
#warning sv刷新里，这里有一个还原scrollview的contenrInset的方法，这里先不写，看看会不会出事
        }
        
    }
    
    if (isShowRefreshHeaderView == NO) {
        if (self.headerView.isOberVing != NO) {
            
            self.headerView.isOberVing = NO;
            
            [self removeObserver:self.headerView forKeyPath:@"contentOffset"];
            [self removeObserver:self.headerView forKeyPath:@"contentSize"];
            [self removeObserver:self.headerView forKeyPath:@"frame"];
            
        }
    }
    
}

-(BOOL)isShowRefreshHeaderView{
    return self.headerView.hidden;
}

-(void)stopHeaderAnimating{
//    [self.headerView stopHeaderAnimating];
    self.headerView.refreshState = CBRefreshStateStopped;
}

@end
