//
//  CBRefreshHeaderView.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "CBRefreshHeaderView.h"
#import "CBRefreshSizeDefine.h"

#define VIEW_WIDTH (self.frame.size.width)
#define VIEW_HEIGHT (self.frame.size.height)

@interface CBRefreshHeaderView ()

@property (nonatomic, strong) UIImageView * loadingImageView;
@property (nonatomic, assign) float originInsertTop;

@end


@implementation CBRefreshHeaderView


-(instancetype)initWithFrame:(CGRect)frame loadingImages:(NSArray *)loadingImagesArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
//        self.loadingImages = [[NSArray alloc] init];
        self.loadingImages = [NSArray arrayWithArray:loadingImagesArray];
        
        self.isOberVing = NO;//现在是否正在监听
    
        self.originInsertTop = self.scrollView.contentInset.top;
        
        if (self.loadingImages.count > 0) {
            [self addSubview:self.loadingImageView];
        }
        
    }
    return self;
}

-(void)layoutSubviews{
    
    //loadingImageView
    self.loadingImageView.bounds = CGRectMake(0, 0, HEADER_LOADING_WIDTH, HEADER_LOADING_HEIGHT);
    self.loadingImageView.center = CGPointMake(VIEW_WIDTH / 2, VIEW_HEIGHT / 2);
    
    
}

#pragma mark- get

-(UIImageView *)loadingImageView{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        
        //使用loadingImages中的第一张图片
        _loadingImageView.image = [UIImage imageNamed:[self.loadingImages firstObject] ? [self.loadingImages firstObject] : nil];
        
    }
    return _loadingImageView;
}


#pragma mark- observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self layoutSubviews];
    }
    
    if ([keyPath isEqualToString:@"frame"]) {
        [self layoutSubviews];
    }
}

//这个和table里的代理方法不一样，这个是自己纯手写的
- (void)scrollViewDidScroll:(CGPoint)contentOffset{
    
    float pullLength = -contentOffset.y;
    
    if (self.refreshState != CBRefreshStateLoading) {
        

            NSLog(@"%@",NSStringFromCGPoint(contentOffset));
        
        
        if (pullLength >= HEADER_HEIGHT && self.scrollView.dragging == NO) {
            self.refreshState = CBRefreshStateLoading;
            
            self.scrollView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT + self.originInsertTop, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right);
            NSLog(@"now%@",NSStringFromCGPoint(contentOffset));

            [self loadingAnimationStart];
            
        }
    }
    else{
        CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
        offset = MIN(offset, self.originInsertTop + self.bounds.size.height);
        UIEdgeInsets contentInset = self.scrollView.contentInset;
        self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
    }

    
}

//- (void)scrollViewDidScroll:(CGPoint)contentOffset {
//    if(self.refreshState != CBRefreshStateLoading)
//    {
//        CGFloat scrollOffsetThreshold = self.frame.origin.y - self.originInsertTop;
//        
//        if(self.refreshState == CBRefreshStateTriggered)
//        {
//            if (!self.scrollView.isDragging)
//            {
//                self.refreshState = CBRefreshStateLoading;
//            }
//            else if(self.scrollView.isDragging && contentOffset.y >= scrollOffsetThreshold && contentOffset.y < 0)
//            {
//                self.refreshState = CBRefreshStateStopped;
//                CGFloat percent = contentOffset.y/scrollOffsetThreshold;
////                [self.loadingView updateTriggerWithPercent:percent state:_state];
//            }
//        }
//        else if(self.refreshState == CBRefreshStateStopped)
//        {
//            if (contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging)
//            {
//                self.refreshState = CBRefreshStateTriggered;
////                [self.loadingView updateTriggerWithPercent:1 state:_state];
//            }
//            else if(contentOffset.y >= scrollOffsetThreshold && contentOffset.y < 0)
//            {
//                CGFloat percent = contentOffset.y/scrollOffsetThreshold;
////                [self.loadingView updateTriggerWithPercent:percent state:_state];
//            }
//            
//        }
//        else if(self.refreshState != CBRefreshStateStopped )
//        {
//            if (contentOffset.y >= scrollOffsetThreshold) {
//                self.refreshState = CBRefreshStateStopped;
//            }
//        }
//    }
//    else
//    {
//        CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
//        offset = MIN(offset, self.originInsertTop + self.bounds.size.height);
//        UIEdgeInsets contentInset = self.scrollView.contentInset;
//        self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
//    }
//}


-(void)loadingAnimationStart{
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    for (NSString * imageName in self.loadingImages) {
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    self.loadingImageView.animationDuration = 2;
    self.loadingImageView.animationImages = imageArray;
    [self.loadingImageView startAnimating];
}

-(void)stopHeaderAnimating{
    

    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(self.originInsertTop, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right);
    } completion:^(BOOL finished) {
        self.refreshState = CBRefreshStateStopped;
        [self.loadingImageView stopAnimating];
    }];
    
    
}

//-(void)setRefreshState:(CBRefreshState)refreshState{
//    if(_refreshState == refreshState)
//        return;
//    
//    CBRefreshState previousState = _refreshState;
//    _refreshState = refreshState;
//    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    
//    switch (refreshState) {
//        case CBRefreshStateStopped:
//            
//            [self stopHeaderAnimating];
//            [self resetScrollViewContentInset];
//            
//            break;
//            
//        case CBRefreshStateTriggered:
//            break;
//            
//        case CBRefreshStateLoading:
//            
//            [self loadingAnimationStart];
//            [self setScrollViewContentInsetForLoading];
//            
////            if(previousState == CBRefreshStateTriggered && _pullToRefreshActionHandler)
////                _pullToRefreshActionHandler();
//            
//            break;
//    }
//}
//
//- (void)resetScrollViewContentInset {
//    UIEdgeInsets currentInsets = self.scrollView.contentInset;
//    currentInsets.top = self.originInsertTop;
//    
//    [self setScrollViewContentInset:currentInsets];
//}
//
//- (void)setScrollViewContentInsetForLoading {
//    CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0);
//    UIEdgeInsets currentInsets = self.scrollView.contentInset;
//    currentInsets.top = MIN(offset, self.originInsertTop + self.bounds.size.height);
//    [self setScrollViewContentInset:currentInsets];
//}
//
//- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.scrollView.contentInset = contentInset;
//                     }
//                     completion:NULL];
//}

@end


















