//
//  HDDBManager.m
//  FetionHD
//
//  Created by DenisHu on 14-8-12.
//  Copyright (c) 2013年 DennisHu. All rights reserved.

#import <Foundation/Foundation.h>
#import "HDDBManager.h"

static FMDatabase *shareDataBase = nil;
@implementation HDDBManager

/**
 创建数据库类的单例对象
 这种方法可以达到线程安全，但多次调用时会导致性能显著下降
 **/
//+ (FMDatabase *)createDataBase {
//    //debugMethod();
//    @synchronized (self) {
//        if (shareDataBase == nil) {
//
//            shareDataBase = [[FMDatabase databaseWithPath:dataBasePath] retain];
//        }
//        return shareDataBase;
//    }
//}

+ (FMDatabase *)createDataBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDataBase = [FMDatabase databaseWithPath:dataBasePath];
    });
    return shareDataBase;
}

/**
 判断数据库中表是否存在
 **/
+ (BOOL)isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [shareDataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]){
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"%@ isOK %d", tableName, (int)count);
        
        if (0 == count){
            return NO;
        }else{
            return YES;
        }
    }
    
    return NO;
}

/**
 创建用户表
 **/
+ (BOOL)createUserTable{
    debugMethod();
    NSLog(@"%@",dataBasePath);
    shareDataBase = [HDDBManager createDataBase];
    if ([shareDataBase open]) {
        if (![HDDBManager isTableExist:@"user_table"]) {
            NSString *sql = @"CREATE TABLE \"user_table\" (\"user_phone\" TEXT PRIMARY KEY  NOT NULL  check(typeof(\"user_phone\") = 'text') , \"user_name\" TEXT, \"user_pwd\" TEXT, \"user_isRemember\" int, \"user_isAutoLogin\" int, \"user_image\" blob)";
            [shareDataBase executeUpdate:sql];
        }
        [shareDataBase close];
    }
    return YES;
}

/**
 关闭数据库
 **/
+ (void)closeDataBase
{
    if(![shareDataBase close]) {
        NSLog(@"数据库关闭异常，请检查");
        return;
    }
}

/**
 删除数据库
 **/
+ (void)deleteDataBase
{
    if (shareDataBase != nil) {
        //这里进行数据库表的删除工作
    }
}

+ (BOOL)saveOrUpdataUser:(HDUserInfo *)user
{
    BOOL isOk = NO;
    shareDataBase = [HDDBManager createDataBase];
    if ([shareDataBase open]) {
        FMResultSet *s = [shareDataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"user_table\" WHERE \"user_phone\" = '%@'", user.sPhone]];
        if (![s next]) {
            isOk = [shareDataBase executeUpdate:
                    @"INSERT INTO \"user_table\" (\"user_phone\", \"user_name\", \"user_pwd\", \"user_isRemember\", \"user_isAutoLogin\", \"user_image\") VALUES(?, ?, ?, ?, ?, ?)", user.sPhone, user.sName, user.sPwd, FORMAT(@"%d", user.isRememberPwd), FORMAT(@"%d", user.isAutoLogin),  UIImageJPEGRepresentation(user.img_head, 1.0)];
        }else{
            isOk = [shareDataBase executeUpdate:
                    @"UPDATE \"user_table\" SET \"user_name\" = ?, \"user_pwd\" = ?, \"user_isRemember\" = ?, \"user_isAutoLogin\" = ?, \"user_image\" = ? WHERE \"user_phone\" = ?", user.sName, user.sPwd, FORMAT(@"%d", user.isRememberPwd), FORMAT(@"%d", user.isAutoLogin), UIImageJPEGRepresentation(user.img_head, 1.0), user.sPhone];
        }
        [shareDataBase close];
    }
    return isOk;
}

+ (HDUserInfo *)selectUserByPhoneNumber:(NSString *)sPhone
{
    HDUserInfo *user = nil;
    shareDataBase = [HDDBManager createDataBase];
    if ([shareDataBase open]) {
        FMResultSet *s = [shareDataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"user_table\" WHERE \"user_phone\" = '%@'", sPhone]];// select * from users order by uid desc LIMIT 1
        if ([s next]) {
            user                = [[HDUserInfo alloc] init];
            user.sPhone         = [s stringForColumn:@"user_phone"];
            user.sName          = [s stringForColumn:@"user_name"];
            user.sPwd           = [s stringForColumn:@"user_pwd"];
            user.isAutoLogin    = [s boolForColumn:@"user_isAutoLogin"];
            user.isRememberPwd  = [s boolForColumn:@"user_isRemember"];
            user.img_head       = [UIImage imageWithData:[s dataForColumn:@"user_image"]];
        }
        [shareDataBase close];
    }
    return user;
}

+ (HDUserInfo *)selectLatestUser
{
    HDUserInfo *user = nil;
    NSMutableArray *mar_ = [NSMutableArray new];
    shareDataBase = [HDDBManager createDataBase];
    if ([shareDataBase open]) {
        FMResultSet *s = [shareDataBase executeQuery:[NSString stringWithFormat:@"select * from \"user_table\""]];//
        while ([s next]) {
            user                = [[HDUserInfo alloc] init];
            NSData  *data_img   = [s dataForColumn:@"user_image"];
            user.sPhone         = [s stringForColumn:@"user_phone"];
            user.sName          = [s stringForColumn:@"user_name"];
            user.sPwd           = [s stringForColumn:@"user_pwd"];
            user.isAutoLogin    = [s boolForColumn:@"user_isAutoLogin"];
            user.isRememberPwd  = [s boolForColumn:@"user_isRemember"];
            user.img_head       = [UIImage imageWithData:data_img];
            [mar_ addObject:user];
        }
        [shareDataBase close];
    }
    return [mar_ lastObject];
}
@end
