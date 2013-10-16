//
//  mePage.h
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mePage : superNavPage

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)MeBtnPressed:(id)sender;
- (IBAction)closeThisPage:(id)sender;
@end
