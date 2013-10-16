//
//  UIImageView+ImageWebCache.h
//  oschinaClient
//
//  Created by boai on 13-7-22.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageWebCache)

- (NSData *)getImgFromWeb:(NSURL *)url;
@end
