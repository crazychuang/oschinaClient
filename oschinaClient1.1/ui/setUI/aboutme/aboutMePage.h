//
//  aboutMePage.h
//  oschinaClient
//
//  Created by boai on 13-8-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutMePage : superPage

@property (retain, nonatomic) IBOutlet UIView *theView;
@property (retain, nonatomic) IBOutlet UILabel *lbl_aboutMe;
@property (retain, nonatomic) IBOutlet UIImageView *navBg;
- (IBAction)closeThepage:(id)sender;
@end
