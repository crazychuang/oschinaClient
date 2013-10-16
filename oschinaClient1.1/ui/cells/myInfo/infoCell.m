//
//  infoCell.m
//  oschinaClient
//
//  Created by boai on 13-7-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "infoCell.h"

@implementation infoCell

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
    [_lbl_label release];
    [_lbl_content release];
    [super dealloc];
}
@end
