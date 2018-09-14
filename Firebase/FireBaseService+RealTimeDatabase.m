//
//  FireBaseService+RealTimeDatabase.m
//  Prime
//
//  Created by Coody on 2017/1/2.
//

#import "FireBaseService+RealTimeDatabase.h"

// for Tools
#import <objc/runtime.h>

#pragma mark - FireBaseService

static const char ResponseBlockKey;

@implementation FireBaseService (RealTimeDatabase)

#pragma mark - Public methods
-(void)initialRealTimeDatabase{
    static BOOL isFirstTime = NO;
    if ( isFirstTime == NO ) {
        isFirstTime = YES;
        self.ref = [[FIRDatabase database] reference];
        self.isActive = NO;
    }
    else{
        NSLog(@" Has alerady initial RealTimeDatabase !!");
    }
}

-(void)getRealTimeDatabaseWithKey:(NSString *)tempDatabaseKey 
                withResponseBlock:(FirebaseRealTimeDatabaseResponseBlock)tempResponseBlock
{
    
    // 一次只問一個
    if ( self.isActive ) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{@"ErrorMsg":@"正在詢問 RealTimeDatabase 中！",
                                                                                       @"ErrorCode":[NSNumber numberWithInt:0]}];
        tempResponseBlock( nil , error );
        return;
    }
    else{
        self.isActive = YES;
    }
    
    objc_setAssociatedObject(self , &ResponseBlockKey, tempResponseBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    __weak __typeof(self) weakSelf = self;
    [[self.ref child:tempDatabaseKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        FirebaseRealTimeDatabaseResponseBlock responseBlock = (FirebaseRealTimeDatabaseResponseBlock)objc_getAssociatedObject(strongSelf, &ResponseBlockKey);
        
        NSLog(@" reveive = %@" , snapshot.value );
        
        responseBlock( snapshot , nil );
        
        strongSelf.isActive = NO;
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        FirebaseRealTimeDatabaseResponseBlock responseBlock = (FirebaseRealTimeDatabaseResponseBlock)objc_getAssociatedObject(strongSelf, &ResponseBlockKey);
        
        responseBlock( nil , error );
        
        strongSelf.isActive = NO;
        
    }]; 
}

#pragma mark - Private methods
#pragma mark : Dynamic property
-(FIRDatabaseReference *)ref{
    return objc_getAssociatedObject(self, @selector(ref));
}

-(void)setRef:(FIRDatabaseReference *)ref{
    objc_setAssociatedObject(self, @selector(ref), ref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isActive{
    return [objc_getAssociatedObject(self, @selector(isActive)) boolValue];
}

-(void)setIsActive:(BOOL)isActive{
    objc_setAssociatedObject(self, @selector(isActive), [NSNumber numberWithBool:isActive], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
