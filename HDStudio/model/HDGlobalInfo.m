//
//  HDGlobleInfo.m
//  HDStudio
//
//  Created by Hu Dennis on 14/12/12.
//  Copyright (c) 2014年 Hu Dennis. All rights reserved.
//

#import "HDGlobalInfo.h"

static HDGlobalInfo* pData = NULL;
@implementation HDGlobalInfo

+ (HDGlobalInfo *)instance{
    @synchronized(self){
        if (pData == NULL){
            pData = [[HDGlobalInfo alloc] init];
        }
    }
    return pData;
}

- (void)reset{
    pData = NULL;
}

@end
