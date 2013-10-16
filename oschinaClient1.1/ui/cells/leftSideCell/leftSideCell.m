//
//  leftSideCell.m
//  oschinaClient
//
//  Created by boai on 13-7-18.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "leftSideCell.h"

@implementation leftSideCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_imgView_head release];
    [_lbl_name release];
    [super dealloc];
}
@end
