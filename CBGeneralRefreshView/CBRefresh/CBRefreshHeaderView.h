//
//  CBRefreshHeaderView.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CBRefreshState) {
    CBRefreshStateStopped = 0,
    CBRefreshStateTriggered = 1,
    CBRefreshStateLoading = 2
};

@interface CBRefreshHeaderView : UIView

@property (nonatomic, strong) NSArray * loadingImages;
@property (nonatomic, assign) BOOL isOberVing;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) CBRefreshState refreshState;

-(instancetype)initWithFrame:(CGRect)frame loadingImages:(NSArray *)loadingImagesArray;
-(void)stopHeaderAnimating;
@end
