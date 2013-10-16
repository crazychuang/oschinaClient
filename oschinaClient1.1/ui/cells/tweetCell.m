//
//  tweetCell.m
//  oschinaClient
//
//  Created by boai on 13-7-9.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "tweetCell.h"
#import "UIImageView+WebCache.h"
@implementation tweetCell
@synthesize bTweetImg = _bTweetImg;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

+ (CGFloat) resizeTheCellHeight:(tweetModel *)model
{
    const int d = 10;
    CGFloat contentH = [tweetCell resizeTheCellLabel:model.strBody].height;
    contentH = contentH + 5;
    if (!model.strUrlImgSmall || model.strUrlImgSmall.length <= 0) {
        int timeY = contentH + 10 + 31;
        int cellH = timeY + 21 + d;
        return cellH;
    }else{
        int timeY = contentH + 10 + 120 + 31 + 10;
        int cellH = timeY + 21 + d;
        return cellH;
    }
}


+ (CGSize)resizeTheCellLabel:(NSString *)str
{
    //UIFont *font = [UIFont systemFontOfSize:15];
    UIFont *font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:14];
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(220.0f, 10000.0f) lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

- (void)initTheTweetCell:(tweetModel *)model
{
    CGSize size = [tweetCell resizeTheCellLabel:model.strBody];
    //self.lbl_content.font = [UIFont systemFontOfSize:15];
    self.lbl_content.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:14];
    self.lbl_content.lineBreakMode = UILineBreakModeWordWrap;
    self.lbl_content.text = model.strBody;
    
    [self.lbl_content setFrame:CGRectMake(self.lbl_content.frame.origin.x,
                                         self.lbl_content.frame.origin.y,
                                         self.lbl_content.frame.size.width,
                                          size.height + 5)];
    self.imgView_tweetImg.userInteractionEnabled = YES;
    self.imgView_head.userInteractionEnabled = YES;
    if (!model.strUrlImgSmall || model.strUrlImgSmall.length <= 0) {
        _bTweetImg = false;
        self.imgView_tweetImg.hidden = YES;
        [self.lbl_time setFrame:CGRectMake(self.lbl_time.frame.origin.x,
                                          self.lbl_content.frame.origin.y + self.lbl_content.frame.size.height + 10 ,
                                           self.lbl_time.frame.size.width, self.lbl_time.frame.size.height)];
        
    }else{
        _bTweetImg = true;
        [self.imgView_tweetImg setFrame:CGRectMake(self.imgView_tweetImg.frame.origin.x,
                                                  self.lbl_content.frame.origin.y + self.lbl_content.frame.size.height + 10,
                                                   self.imgView_tweetImg.frame.size.width,
                                                   self.imgView_tweetImg.frame.size.height)];
        self.imgView_tweetImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.imgView_tweetImg setImageWithURL:[NSURL URLWithString:model.strUrlImgSmall] placeholderImage:[UIImage imageNamed:@"avatar_loading.png"]];
        [self.lbl_time setFrame:CGRectMake(self.lbl_time.frame.origin.x,
                                           self.imgView_tweetImg.frame.origin.y + self.imgView_tweetImg.frame.size.height + 10 ,
                                           self.lbl_time.frame.size.width, self.lbl_time.frame.size.height)];
        
    }
    self.lbl_author.text = model.strAuthor;
    self.lbl_time.text = model.strPubDate;
    self.lbl_MsgCount.text = [NSString stringWithFormat:@"%d",model.nCommentCount];
    [self.imgView_head setImageWithURL:[NSURL URLWithString:model.strPortrait] placeholderImage:[UIImage imageNamed:@"avatar_loading.png"]];
}

- (void)addTweetTap:(tweetCell **)cell action:(SEL)action target:(id)target tweetModel:(tweetModel *)model
{
    if (!_bTweetImg) {
        return;
    }
    UITap *tweetTap = [[UITap alloc] initWithTarget:target action:action];
    tweetTap.strTagString = model.strUrlImgBig;
    [(*cell).imgView_tweetImg addGestureRecognizer:tweetTap];
    [tweetTap release]; tweetTap = nil;
}

- (void)addHeadTap:(UIImageView *)headImg action:(SEL)action target:(id)target tweetModel:(tweetModel *)model
{
    UITap *headTap = [[UITap alloc] initWithTarget:target action:action];
    headTap.nTag = [model.strAuthorID intValue];
    headTap.strTagString = model.strAuthor;
    [headImg addGestureRecognizer:headTap];
    [headTap release]; headTap = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_lbl_author release];
    [_lbl_content release];
    [_imgView_tweetImg release];
    [_lbl_time release];
    [_imgView_head release];
    [_imgView_MsgCount release];
    [_lbl_MsgCount release];
    [super dealloc];
}
@end
