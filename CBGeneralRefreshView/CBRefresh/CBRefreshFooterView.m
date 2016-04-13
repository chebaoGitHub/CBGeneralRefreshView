//
//  CBRefreshFooterView.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/4/13.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "CBRefreshFooterView.h"


@interface CBRefreshFooterView ()

@property (nonatomic, strong) UIImageView * footerImageView;
@property (nonatomic, strong) NSArray * loadingImags;


@end



@implementation CBRefreshFooterView

-(instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.loadingImags = [NSArray arrayWithArray:images];
        [self addSubview:self.footerImageView];

        
    }
    return self;
}

-(void)layoutSubviews{
    _footerImageView.bounds = CGRectMake(0, 0, FOOTER_LOADING_WIDTH, FOOTER_LOADING_HEIGHT);
    _footerImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
}

-(void)scrollViewDidScroll:(CGPoint)contentOffset{
    if(self.state != CBRefreshStateLoading) {
        
        CGFloat scrollViewContentHeight = self.scrollView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight-self.scrollView.bounds.size.height;
        
        if(!self.scrollView.isDragging && self.state == CBRefreshStateTriggered)
            self.state = CBRefreshStateLoading;
        else if(contentOffset.y > scrollOffsetThreshold && self.state == CBRefreshStateStopped && self.scrollView.isDragging)
            self.state = CBRefreshStateTriggered;
        else if(contentOffset.y < scrollOffsetThreshold  && self.state != CBRefreshStateStopped)
            self.state = CBRefreshStateStopped;
    }
}

#pragma mark- set get
-(UIImageView *)footerImageView{
    if (!_footerImageView) {
        _footerImageView = [[UIImageView alloc] init];
        _footerImageView.backgroundColor = [UIColor blackColor];
        _footerImageView.image = [UIImage imageNamed:[self.loadingImags firstObject] ? [self.loadingImags firstObject] : nil];
        
        
        NSMutableArray * imagearray = [[NSMutableArray alloc] init];
        for (NSString * name in self.loadingImags) {
            [imagearray addObject:[UIImage imageNamed:name]];
        }
        _footerImageView.animationImages = imagearray;
        _footerImageView.animationDuration = 2;
    }
    return _footerImageView;
}


- (void)setState:(CBRefreshState)newState {
    
    if(_state == newState)
        return;
    
    CBRefreshState previousState = _state;
    _state = newState;
    
    switch (newState) {
        case CBRefreshStateStopped:
            [self resetScrollViewContentInset];
            [self.footerImageView stopAnimating];
            self.footerImageView.hidden = YES;
            break;
            
        case CBRefreshStateTriggered:
            self.footerImageView.hidden = NO;
            break;
            
        case CBRefreshStateLoading:
            self.footerImageView.hidden = NO;
            [self.footerImageView startAnimating];
            [self setScrollViewContentInsetForInfiniteScrolling];
            break;
    }
    
    if(previousState == CBRefreshStateTriggered && newState == CBRefreshStateLoading && [self.refreshDelegate respondsToSelector:@selector(refreshTheTableFooter)]){
        [self.refreshDelegate refreshTheTableFooter];
    }
        
}

#pragma mark- insert
- (void)resetScrollViewContentInset {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForInfiniteScrolling {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset + FOOTER_HEIGHT;
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
