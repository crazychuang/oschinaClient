//
//  commentCell.m
//  oschinaClient
//
//  Created by boai on 13-7-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "commentCell.h"

@implementation commentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


+ (CGSize)resizeTheCellLabel:(NSString *)str
{
    //UIFont *font = [UIFont systemFontOfSize:14];
    UIFont *font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:13];
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(220.0f, 10000.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

+ (CGFloat)resizeTheCellHeight:(NSString *)str
{
    const int d = 10;
    CGFloat contentH = [commentCell resizeTheCellLabel:str].height;
    contentH = contentH + 5;
    int content_buttom_Y = contentH + 27;
    if (content_buttom_Y < 6 + 30) {
        return 6 + 30 + d;
    }
    return content_buttom_Y + d;
}

- (void)initTheCell:(NSString *)str
{
    CGSize size = [commentCell resizeTheCellLabel:str];
    self.lbl_content.numberOfLines = 0;
    self.lbl_content.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:13];
    self.lbl_content.lineBreakMode = UILineBreakModeWordWrap;
    self.lbl_content.text = str;
    [self.lbl_content setFrame:CGRectMake(self.lbl_content.frame.origin.x, self.lbl_content.frame.origin.y, self.lbl_content.frame.size.width, size.height + 5)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_lbl_other release];
    [_lbl_content release];
    [_img_head release];
    [super dealloc];
}
@end
