//
//  moreResultsCell.h
//  oschinaClient
//
//  Created by boai on 13-6-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreResultsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lbl_content;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act_Loading;
@end
