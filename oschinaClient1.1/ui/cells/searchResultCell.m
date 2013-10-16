//
//  searchResultCell.m
//  oschinaClient
//
//  Created by boai on 13-6-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "searchResultCell.h"

@implementation searchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lbl_id release];
    [_lbl_content release];
    [_lbl_author release];
    [_lbl_pubDate release];
    [super dealloc];
}
@end
