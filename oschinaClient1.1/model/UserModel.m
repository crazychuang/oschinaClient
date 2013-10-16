//
//  UserModel.m
//  oschinaClient
//
//  Created by boai on 13-6-15.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize strUid        = _strUid;
@synthesize strLocation   = _strLocation;
@synthesize strUser       = _strUser;
@synthesize nFollowers    = _nFollowers;
@synthesize nFans         = _nFans;
@synthesize nScore        = _nScore;
@synthesize nAtmeCount    = _nAtmeCount;
@synthesize nMsgCount     = _nMsgCount;
@synthesize nReviewCount  = _nReviewCount;
@synthesize nNewFansCount = _nNewFansCount;


- (id)initWithXml:(TBXML *)xml
{
    TBXMLElement *root = xml.rootXMLElement;
    
    TBXMLElement *user = [TBXML childElementNamed:@"user" parentElement:root];
    TBXMLElement *uid  = [TBXML childElementNamed:@"uid" parentElement:user];
    TBXMLElement *location = [TBXML childElementNamed:@"location" parentElement:user];
    TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:user];
    TBXMLElement *followers = [TBXML childElementNamed:@"followers" parentElement:user];
    TBXMLElement *fans = [TBXML childElementNamed:@"fans" parentElement:user];
    TBXMLElement *score = [TBXML childElementNamed:@"score" parentElement:user];
    
    TBXMLElement *notice = [TBXML childElementNamed:@"notice" parentElement:root];
    TBXMLElement *atmeCount = [TBXML childElementNamed:@"atmeCount" parentElement:notice];
    TBXMLElement *msgCount = [TBXML childElementNamed:@"msgCount" parentElement:notice];
    TBXMLElement *reviewCount = [TBXML childElementNamed:@"reviewCount" parentElement:notice];
    TBXMLElement *newFansCount = [TBXML childElementNamed:@"newFansCount" parentElement:notice];
    if (self = [super init]) {
        self.strUid = [TBXML textForElement:uid];
        self.strLocation = [TBXML textForElement:location];
        self.strUser = [TBXML textForElement:name];
        self.nFollowers = [[TBXML textForElement:followers] intValue];
        self.nFans = [[TBXML textForElement:fans] intValue];
        self.nScore = [[TBXML textForElement:score] intValue];
        self.nAtmeCount = [[TBXML textForElement:atmeCount] intValue];
        self.nMsgCount = [[TBXML textForElement:msgCount] intValue];
        self.nReviewCount = [[TBXML textForElement:reviewCount] intValue];
        self.nNewFansCount = [[TBXML textForElement:newFansCount] intValue];
    }
    return self;
}


-(void)dealloc
{
    [_strUid release];
    [_strLocation release];
    [_strUser release];
    [super dealloc];
}
@end
