//
//  UIScrollView+FooterRefresh.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/4/13.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshSizeDefine.h"
#import "CBRefreshFooterView.h"

@interface UIScrollView (FooterRefresh)

- (void)addRefreshFooter:(NSArray *)imageNames delegate:(UIViewController<CBRefreshFooterViewDelegate> * )delegate;
-(void)stopFooterAnimating;


@property (nonatomic, strong) CBRefreshFooterView * footerView;

//public
@property (nonatomic, assign) BOOL isShowRefreshFooterView;//是否显示headerView

@end
