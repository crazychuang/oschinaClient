//
//  moreResultsCell.m
//  oschinaClient
//
//  Created by boai on 13-6-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "moreResultsCell.h"

@implementation moreResultsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lbl_content release];
    [_act_Loading release];
    [super dealloc];
}
@end
