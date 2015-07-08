//
//  HDUserInfo.h
//  HDStudio
//
//  Created by Hu Dennis on 14/12/12.
//  Copyright (c) 2014年 Hu Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDUserInfo : NSObject

@property (strong) NSString *sName;
@property (strong) NSString *sUserId;
@property (strong) NSString *sPwd;
@property (strong) NSString *sPhone;
@property (strong) NSString *sSex;
@property (strong) NSString *sImageUrl;
@property (strong) NSString *sImagePath;
@property (strong) UIImage  *img_head;
@property (assign) BOOL     isRememberPwd;
@property (assign) BOOL     isAutoLogin;

@end
