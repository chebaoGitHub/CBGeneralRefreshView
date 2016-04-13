//
//  CBRefreshHeaderView.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshSizeDefine.h"

@protocol CBRefreshHeaderViewDelegate <NSObject>

-(void)refreshTheTableHeader;

@end

@interface CBRefreshHeaderView : UIView

@property (nonatomic, strong) NSArray * loadingImages;
@property (nonatomic, assign) BOOL isOberVing;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) CBRefreshState refreshState;
@property (nonatomic, weak) id <CBRefreshHeaderViewDelegate> refreshDelegate;


-(instancetype)initWithFrame:(CGRect)frame loadingImages:(NSArray *)loadingImagesArray;
-(void)stopHeaderAnimating;
@end
