//
//  fatherHeadView.h
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+VC.h"
@interface fatherHeadView : UIView

@property (retain, nonatomic) IBOutlet UILabel *lbl_NavTitle;
- (IBAction)popSubVc:(id)sender;
@end
