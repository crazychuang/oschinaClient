//
//  PostCell.m
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+ (CGFloat )resizeTheCellHeight:(NSString *)str
{
    const int d = 20;
    CGFloat contentH =  [self resizeTheCellLabel:str].height;  
    contentH = contentH + 5 ;  
    int otherY = 6 + contentH + 10;
    int cellH = 0;
    if (otherY <= 7 + 45) {
        otherY = 7 + 45 + 5;
        cellH = otherY + d;
        return cellH;
    }
    return cellH = otherY + d;
}



+ (CGSize)resizeTheCellLabel:(NSString *)str
{
    //UIFont *font = [UIFont systemFontOfSize:14];
    UIFont *font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(175.0f, 10000.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

- (void)initTheCell:(NSString *)str
{
    CGSize size = [PostCell resizeTheCellLabel:str];
    self.txt_Content.numberOfLines = 0;
    //self.txt_Content.font = [UIFont systemFontOfSize:14];
    self.txt_Content.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
    self.txt_Content.lineBreakMode = UILineBreakModeWordWrap;
    self.txt_Content.text = str;
    [self.txt_Content setFrame:CGRectMake(
                                         self.txt_Content.frame.origin.x,
                                         self.txt_Content.frame.origin.y,
                                         self.txt_Content.frame.size.width,
                                          size.height + 5)];
    
    [self.txt_Other setFrame:CGRectMake(self.txt_Other.frame.origin.x,
                                       self.txt_Content.frame.origin.y + self.txt_Content.frame.size.height + 10,
                                        self.txt_Other.frame.size.width, self.txt_Other.frame.size.height)];
    if (self.txt_Other.frame.origin.y <= self.img_Head.frame.origin.y + self.img_Head.frame.size.height) {
        [self.txt_Other setFrame:CGRectMake(self.txt_Other.frame.origin.x,
                                           self.img_Head.frame.origin.y + self.img_Head.frame.size.height + 5, self.txt_Other.frame.size.width,
                                            self.txt_Other.frame.size.height)];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_img_Head release];
    [_txt_Content release];
    [_txt_Other release];
    [_txt_Count_Answer release];
    [super dealloc];
}
@end
