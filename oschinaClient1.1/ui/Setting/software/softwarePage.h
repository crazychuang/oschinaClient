//
//  softwarePage.h
//  oschinaClient
//
//  Created by boai on 13-6-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "softwareCatalogModel.h"
#import "oschinaTool.h"
#import "softwareTypesPage.h"
#import "softwareOptionsPage.h"
#import "WXJSliderSwitch.h"
@interface softwarePage : superNavBackPage <UITableViewDataSource,UITableViewDelegate,WXJSliderSwitchDelegate>
{
    softwareTypesPage *_softwareType;
    softwareOptionsPage *_software;
}
@property (retain, nonatomic) softwareOptionsPage *software;
@property (retain, nonatomic) softwareTypesPage *softwareType;

@end
