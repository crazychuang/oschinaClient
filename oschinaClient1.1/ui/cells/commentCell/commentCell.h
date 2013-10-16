//
//  commentCell.h
//  oschinaClient
//
//  Created by boai on 13-7-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lbl_other;
@property (retain, nonatomic) IBOutlet UILabel *lbl_content;
@property (retain, nonatomic) IBOutlet UIImageView *img_head;

+ (CGFloat)resizeTheCellHeight:(NSString *)str;
- (void)initTheCell:(NSString *)str;
@end
