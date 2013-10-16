//
//  PostCell.h
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *img_Head;
@property (retain, nonatomic) IBOutlet UILabel *txt_Content;
@property (retain, nonatomic) IBOutlet UILabel *txt_Other;
@property (retain, nonatomic) IBOutlet UILabel *txt_Count_Answer;

- (void)initTheCell:(NSString *)str;
+ (CGFloat )resizeTheCellHeight:(NSString *)str;
@end
