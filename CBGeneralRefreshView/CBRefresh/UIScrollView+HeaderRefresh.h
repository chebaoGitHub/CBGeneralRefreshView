//
//  UIScrollView+HeaderRefresh.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBRefreshHeaderView;

@interface UIScrollView (HeaderRefresh)

- (void)addRefreshHeader:(NSArray *)imageNames;
@property (nonatomic, strong) CBRefreshHeaderView * headerView;

//@property (nonatomic, assign) CGSize headerViewSize;

@end
