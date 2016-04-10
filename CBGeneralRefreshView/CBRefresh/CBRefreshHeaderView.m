//
//  CBRefreshHeaderView.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "CBRefreshHeaderView.h"

@interface CBRefreshHeaderView (){
    
}

@property (nonatomic, strong) UIImageView * loadingImageView;

@end


@implementation CBRefreshHeaderView


-(instancetype)initWithFrame:(CGRect)frame loadingImages:(NSArray *)loadingImagesArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        self.loadingImages = [[NSArray alloc] init];
        self.loadingImages = [NSArray arrayWithArray:loadingImagesArray];
        
    }
    return self;
}

-(void)layoutSubviews{
    self.loadingImageView.bounds = CGRectMake(0, 0, 34, 34);
}

#pragma mark- get

-(UIImageView *)loadingImageView{
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        
    }
    return _loadingImageView;
}



@end
