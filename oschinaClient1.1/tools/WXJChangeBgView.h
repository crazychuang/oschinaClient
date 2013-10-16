//
//  WXJChangeBgView.h
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  WXJChangeBgView;
@protocol WXJChangeBgViewDelegate <NSObject>
- (void)changeBgView:(WXJChangeBgView *)changeBgView didClickBtnAtIndex:(NSInteger)index;
@end

@interface WXJChangeBgView : UIView
{
    UIImageView *_viewBg;
}
@property (assign, nonatomic) id<WXJChangeBgViewDelegate> delegate;

- (void)fadeIn;
- (void)fadeOut;
@end
