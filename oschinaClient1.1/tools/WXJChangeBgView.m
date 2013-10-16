//
//  WXJChangeBgView.m
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "WXJChangeBgView.h"

@implementation WXJChangeBgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBackgroundView];
        [self initBtnView];
    }
    return self;
}

- (void) initBackgroundView
{
    self.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"forward_background"];
    UIImageView *_imageView = [[UIImageView alloc] initWithImage:image];
    [_imageView setFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    _imageView.center = CGPointMake(self.center.x, -self.center.y);
    NSLog(@"%f,%f",_imageView.center.x,_imageView.center.y);
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    _viewBg = [_imageView retain];
    [_imageView release];
}

- (void) initBtnView
{
    UILabel *_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, _viewBg.frame.size.width, 100)];
    [_label setText:@"呵呵,请选择一种背景颜色"];
    [_label setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:20]];
    [_label setTextAlignment:UITextAlignmentCenter];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_viewBg addSubview:_label];
    
    
    UIButton *_btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.tag = 0;
    [_btn1 setImage:[UIImage imageNamed:@"skin_set_blue"] forState:UIControlStateNormal];
    [_btn1 setFrame:CGRectMake(11, 25 + 75, 85, 85)];
    [_btn1 setContentMode:UIViewContentModeCenter];
    [_btn1 addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBg addSubview:_btn1];
    
    UIButton *_btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.tag = 1;
    [_btn2 setImage:[UIImage imageNamed:@"skin_set_red"] forState:UIControlStateNormal];
    [_btn2 setFrame:CGRectMake(_btn1.frame.origin.x + 65 + 12, 25 + 75, 85, 85)];
    [_btn2 setContentMode:UIViewContentModeCenter];
    [_btn2 addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBg addSubview:_btn2];
    
    UIButton *_btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.tag = 2;
    [_btn3 setImage:[UIImage imageNamed:@"skin_set_black"] forState:UIControlStateNormal];
    [_btn3 setFrame:CGRectMake(_btn2.frame.origin.x + 65 + 12, 25 + 75, 85, 85)];
    [_btn3 setContentMode:UIViewContentModeCenter];
    [_btn3 addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBg addSubview:_btn3];

}

- (void)clickTheBtn:(UIButton *)btn
{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(changeBgView:didClickBtnAtIndex:)]) {
            [_delegate changeBgView:self didClickBtnAtIndex:btn.tag];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    if (!CGRectContainsPoint(_viewBg.frame, p)) {
        [self fadeOut];
    }
}

- (void)fadeIn
{
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7f];
        _viewBg.alpha = 1.0f;
        _viewBg.center = self.center;
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundColor = [UIColor clearColor];
        _viewBg.alpha = 0.0f;
        _viewBg.center = CGPointMake(self.center.x, -self.center.y);
    } completion:^(BOOL finished) {
        [_viewBg release];
        _viewBg = nil;
        [self removeFromSuperview];
    }];
}

@end
