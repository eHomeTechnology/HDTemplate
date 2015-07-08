//
//  HDDBManager.h
//
//  Created by DennisHu on 14-8-12.
//  Copyright (c) 2013年 DennisHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "HDUserInfo.h"

#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"dataBase.sqlite"

@interface HDDBManager : NSObject

/****/
/**
 *	@brief	数据库对象单例方法
 *
 *	@return	返回FMDateBase数据库操作对象
 */
+ (FMDatabase *)createDataBase;


/**
 *	@brief	关闭数据库
 */
+ (void)closeDataBase;

/**
 *	@brief	清空数据库内容
 */
+ (void)deleteDataBase;

/**
 *	@brief	判断表是否存在
 *
 *	@param 	tableName 	表明
 *
 *	@return	创建是否成功
 */
+ (BOOL)isTableExist:(NSString *)tableName;

/**
 *	@brief	创建所有表
 *
 *	@return	
 */
+ (BOOL)createUserTable;
/**
 *	@brief	添加chatdata  如果主键重复就更新
 *
 *	@param 	chatData 	要保存的chatdata
 *
 *	@return	返回是否保存或者更新成功
 */
+ (BOOL)saveOrUpdataUser:(HDUserInfo *)user;
+ (HDUserInfo *)selectUserByPhoneNumber:(NSString *)sPhone;
+ (HDUserInfo *)selectLatestUser;
@end
