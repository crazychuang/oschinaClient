//
//  TweetImgDetail.h
//  oschinaClient
//
//  Created by boai on 13-7-10.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetImgDetail : superPage 
{
    NSString *_strImgHref;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgView_nav;
@property (copy, nonatomic) NSString *strImgHref;
@property (retain, nonatomic) IBOutlet UIWebView *web_Img;
- (IBAction)closeThisPage:(id)sender;
@end
