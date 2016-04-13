//
//  CBRefreshSizeDefine.h
//  CBGeneralRefreshView
//
//  Created by chebao on 16/4/12.
//  Copyright © 2016年 chebao. All rights reserved.
//

#ifndef CBRefreshSizeDefine_h
#define CBRefreshSizeDefine_h

#define HEADER_HEIGHT 100
#define HEADER_LOADING_HEIGHT 34
#define HEADER_LOADING_WIDTH 34

#define FOOTER_HEIGHT 100
#define FOOTER_LOADING_HEIGHT 34
#define FOOTER_LOADING_WIDTH 34

typedef NS_ENUM(NSUInteger, CBRefreshState) {
    CBRefreshStateStopped = 0,
    CBRefreshStateTriggered = 1,
    CBRefreshStateLoading = 2
};

#endif /* CBRefreshSizeDefine_h */
