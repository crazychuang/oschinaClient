//
//  WXJSliderSwitch.m
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "WXJSliderSwitch.h"
#import "WXJTapGestureRecognizer.h"

#define kLabelOffset 2
#define kLabelWidth  60
#define kLabelHeight 29

@implementation WXJSliderSwitch
@synthesize nTabHeight = _nTabHeight;
@synthesize nTabWidth = _nTabWidth;
@synthesize nTabOffset = _nTabOffset;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initV];
    }
    return self;
}

- (void) initV
{
    _arrTab = [[NSMutableArray alloc] init];
    _nTabWidth = 60;
    _nTabHeight = 29;
    _nTabOffset = 2;
}

- (void)initSliderSwitch:(NSString *)_strTab, ...
{
    
    va_list args;
    va_start(args, _strTab);
    [self initTabWithTag:0 frame:CGRectMake(0, 0, _nTabWidth, _nTabHeight) TapSel:@selector(didPressTheTab:) txt:_strTab];
    
    id obj;
    int idx = 1;
    int nTabX = 0;
    while (idx < _nLabelCount) {
        obj = va_arg(args, NSString *);
        NSString *_strLabel = (NSString *)obj;
        nTabX =  _nTabWidth * idx - _nTabOffset;
        [self initTabWithTag:idx frame:CGRectMake(nTabX, 0, _nTabWidth, _nTabHeight) TapSel:@selector(didPressTheTab:) txt:_strLabel];
        idx ++;
    }
    va_end(args);
    
    [self initToggleBtn];
}

- (void)didPressTheTab:(WXJTapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"%d",sender.nTag);
        [_btnSelectedTab setFrame:((UILabel *)[_arrTab objectAtIndex:sender.nTag]).frame];
    } completion:^(BOOL finished) {
        [self.delegate slideView:self switchChangedAtIndex:sender.nTag];
    }];
}

- (void)initTabWithTag:(int)nTag frame:(CGRect)frame TapSel:(SEL)sel txt:(NSString *)txt
{
    UILabel *_label = [[UILabel alloc] initWithFrame:frame];
    _label.text = txt;
    _label.tag = nTag;
    _label.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14];
    _label.textColor = [UIColor darkGrayColor];
    _label.textAlignment = UITextAlignmentCenter;
    _label.userInteractionEnabled = YES;
    _label.backgroundColor = [UIColor clearColor];
    
    WXJTapGestureRecognizer *_tagGesture = [[WXJTapGestureRecognizer alloc] initWithTarget:self action:sel];
    _tagGesture.nTag = nTag;
    [_label addGestureRecognizer:_tagGesture];
    [_tagGesture release];
    [self addSubview:_label];
    [_arrTab addObject:_label];
    [_label release];
}

- (void)initToggleBtn
{
    UIButton *_toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"top_tab_active"];
    [_toggleBtn setFrame:CGRectMake(0, 0, _nTabWidth, _nTabHeight)];
    [_toggleBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_toggleBtn setBackgroundImage:image forState:UIControlStateSelected];
    [_toggleBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    _toggleBtn.alpha = 0.8f;
    
    //[_toggleBtn addTarget:self action:@selector(draggingBtn:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    //[_toggleBtn addTarget:self action:@selector(finishedDraggingBtn:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_toggleBtn];
    _btnSelectedTab = _toggleBtn;
}

- (void)draggingBtn:(UIButton *)button withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    // get delta
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    
    // move button at x axis
    button.center = CGPointMake(button.center.x + delta_x,
                                button.center.y );
    
//    UITouch *touch = [[event touchesForView:btn] anyObject];
//    CGPoint previousLocation = [touch previousLocationInView:btn];
//    CGPoint location = [touch locationInView:btn];
//    CGFloat delta_x = location.x - previousLocation.x;
//    
//    btn.center = CGPointMake(btn.center.x + delta_x, btn.center.y);
//    for (int i=0; i < _nLabelCount - 1; i++) {
//        if (btn.frame.origin.x <= 0) {
//            [btn setFrame:((UILabel *)[_arrTab objectAtIndex:0]).frame];
//            break;
//        }else if(btn.frame.origin.x > ((UILabel *)[_arrTab objectAtIndex:i]).frame.origin.x && btn.frame.origin.x + btn.frame.size.width < ((UILabel *)[_arrTab objectAtIndex:i + 1]).center.x){
//            [btn setFrame:((UILabel *)[_arrTab objectAtIndex:i]).frame];
//            break;
//        }else if(btn.frame.origin.x > ((UILabel *)[_arrTab objectAtIndex:i]).frame.origin.x && btn.frame.origin.x + btn.frame.size.width >= ((UILabel *)[_arrTab objectAtIndex:i + 1]).center.x ){
//            [btn setFrame:((UILabel *)[_arrTab objectAtIndex:i + 1]).frame];
//            break;
//        }
//    }
    
}


- (void)finishedDraggingBtn:(UIButton *)btn withEvent:(UIEvent *)event
{
    
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return YES;
//}

- (void)setSliderSwitchBg:(UIImage *)_image
{
    UIImageView *_imgViewBg = [[UIImageView alloc] initWithImage:_image];
    [_imgViewBg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_imgViewBg];
    
    [_imgViewBg release];
}

@end
