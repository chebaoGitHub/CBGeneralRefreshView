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
-(void)stopHeaderAnimating;


@property (nonatomic, strong) CBRefreshHeaderView * headerView;


//public
@property (nonatomic, assign) BOOL isShowRefreshHeaderView;//是否显示headerView


@end
