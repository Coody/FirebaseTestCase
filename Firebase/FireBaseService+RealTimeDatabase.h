//
//  FireBaseService+RealTimeDatabase.h
//  Prime
//
//  Created by Coody on 2017/1/2.
//

#import "FireBaseService.h"

// for Firebase
#import "Firebase.h"

typedef void(^FirebaseRealTimeDatabaseResponseBlock)( FIRDataSnapshot *tempRealTimeData , NSError *error );  

@interface FireBaseService (RealTimeDatabase)

@property (strong , nonatomic) FIRDatabaseReference *ref;
@property (nonatomic) BOOL isActive;

/** 初始化 RealTimeDatabase （內部只會初始化一次） */
-(void)initialRealTimeDatabase;

/**
 * @brief - 取得 RealTimeDatabase 的資訊
 *
 * @param tempDatabaseKey , 使用此 key 取得內容
 * @param tempResponseBlock , 回傳 block
 */
-(void)getRealTimeDatabaseWithKey:(NSString *)tempDatabaseKey 
                withResponseBlock:(FirebaseRealTimeDatabaseResponseBlock)tempResponseBlock;

@end
