//
//  CBRefreshFooterView.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/4/13.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshSizeDefine.h"

@protocol CBRefreshFooterViewDelegate <NSObject>
-(void)refreshTheTableFooter;
@end




@interface CBRefreshFooterView : UIView

-(instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images;
- (void)resetScrollViewContentInset;
- (void)setScrollViewContentInsetForInfiniteScrolling;

@property (nonatomic, weak) id <CBRefreshFooterViewDelegate> refreshDelegate;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) BOOL isObserving;
@property (nonatomic, readwrite) CGFloat originalBottomInset;
@property (nonatomic, assign) CBRefreshState state;

@end
