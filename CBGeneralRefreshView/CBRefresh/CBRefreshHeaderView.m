//
//  CBRefreshHeaderView.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "CBRefreshHeaderView.h"


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


- (void)scrollViewDidScroll:(CGPoint)contentOffset {
//    NSLog(@"%@",NSStringFromCGPoint(contentOffset));
    if(self.refreshState != CBRefreshStateLoading)
    {
        
        CGFloat scrollOffsetThreshold = self.frame.origin.y - self.originInsertTop;
        
        if(self.refreshState == CBRefreshStateTriggered)
        {
            if (!self.scrollView.isDragging)
            {
                self.refreshState = CBRefreshStateLoading;
            }
        }
        else if(self.refreshState == CBRefreshStateStopped)
        {
            if (contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging)
            {
                self.refreshState = CBRefreshStateTriggered;
            }
            
        }
        else if(self.refreshState != CBRefreshStateStopped )
        {
            if (contentOffset.y >= scrollOffsetThreshold) {
                self.refreshState = CBRefreshStateStopped;
            }
        }
    }

}



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
    [self.loadingImageView stopAnimating];
}

//更改下拉状态时进行相关操作
-(void)setRefreshState:(CBRefreshState)refreshState{
    if(_refreshState == refreshState)
        return;
    
    _refreshState = refreshState;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    switch (refreshState) {
        case CBRefreshStateStopped:
            
            [self stopHeaderAnimating];
            [self resetScrollViewContentInset];
            
            break;
            
        case CBRefreshStateTriggered:
            break;
            
        case CBRefreshStateLoading:
            
            [self loadingAnimationStart];
            [self setScrollViewContentInsetForLoading];//在这里重新设置contentInset的时候，会出现跳动的状况，不知道为什么
            if ([self.refreshDelegate respondsToSelector:@selector(refreshTheTableHeader)]) {
                [self.refreshDelegate refreshTheTableHeader];
            }
            
            
            break;
    }
}


//刷新开始或者结束时重置contentInsert
- (void)resetScrollViewContentInset {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.originInsertTop;
    
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForLoading {
    CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0);
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = MIN(offset, self.originInsertTop + self.bounds.size.height);
    [self setScrollViewContentInset:currentInsets];
}


- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:NULL];
}

@end


















