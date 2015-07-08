//
//  HDGlobleInfo.h
//  HDStudio
//
//  Created by Hu Dennis on 14/12/12.
//  Copyright (c) 2014年 Hu Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RESideMenu.h"

@interface HDGlobalInfo : NSObject

@property (strong) RESideMenu *sideMenu;

+ (HDGlobalInfo *)instance;
@end
