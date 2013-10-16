//
//  allAboutMePage.h
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface allAboutMePage : CustomNavPage
{
    NSString *_strTitle;
}
@property (retain, nonatomic) NSString *strTitle;
- (void)customPopAction;
@end
