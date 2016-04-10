//
//  UIScrollView+HeaderRefresh.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "UIScrollView+HeaderRefresh.h"
#import <objc/runtime.h>

#import "CBRefreshHeaderView.h"// the header of refresh

static char CBHeaderRefreshView;
static char CBHeaderRefreshViewSize;


@interface UIScrollView ()


@end





@implementation UIScrollView (HeaderRefresh)

- (void)addRefreshHeader:(NSArray *)imageNames{
    
    if (!self.headerView) {
        CBRefreshHeaderView * view = [[CBRefreshHeaderView alloc] init];
        view.frame = CGRectMake(0, -100, self.frame.size.width, 100);
        self.headerView = view;
        [self addSubview:view];
    }
    
}

-(void)layoutSubviews{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark set get

- (void)setHeaderView:(CBRefreshHeaderView *)headerView{
    
    [self willChangeValueForKey:@"CBRefreshHeaderView"];
    objc_setAssociatedObject(self, &CBHeaderRefreshView, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"CBRefreshHeaderView"];
    
}

-(CBRefreshHeaderView *)headerView{
    
    return objc_getAssociatedObject(self, &CBHeaderRefreshView);
    
}

//- (void)setHeaderViewSize:(CGSize)headerViewSize{
//    objc_setAssociatedObject(self, &CBHeaderRefreshViewSize, headerViewSize, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (CGSize)headerViewSize{
//    objc_getAssociatedObject(self, &CBHeaderRefreshViewSize);
//}

@end
