//
//  WXJSliderSwitch.h
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXJSliderSwitch;

@protocol WXJSliderSwitchDelegate <NSObject>
@optional
- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index;
@end

@interface WXJSliderSwitch : UIView
{
    NSMutableArray *_arrTab;
    UIButton *_btnSelectedTab;
    int _nTabWidth;
    int _nTabHeight;
    int _nTabOffset;
}

@property (nonatomic,assign) NSInteger nLabelCount;
@property (nonatomic,assign) id <WXJSliderSwitchDelegate> delegate;
@property (nonatomic,assign) int nTabWidth;
@property (nonatomic,assign) int nTabHeight;
@property (nonatomic,assign) int nTabOffset;
- (void)initSliderSwitch:(NSString *)_strTab,...;
- (void)setSliderSwitchBg:(UIImage *)_image;
@end
