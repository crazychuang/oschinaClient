//
//  head_name_Cell.m
//  oschinaClient
//
//  Created by boai on 13-7-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "head_name_Cell.h"

@implementation head_name_Cell

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
    [_lbl_name release];
    [_ingView_head release];
    [_btn_ChangeHeadImg release];
    [super dealloc];
}
@end
