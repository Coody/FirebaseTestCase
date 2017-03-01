//
//  FireBaseService.m
//  Prime
//
//  Created by Coody on 2017/1/2.
//

#import "FireBaseService.h"
@import FirebaseCore;

@implementation FireBaseService

+(instancetype)sharedInstance{
    static FireBaseService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ( sharedInstance == nil ) {
            sharedInstance = [[self alloc] initWithFirebase];
        }
    });
    return sharedInstance;
}

-(instancetype)initWithFirebase{
    self = [super init];
    if ( self ) {
        [FIRApp configure];
    }
    return self;
}

-(instancetype)init{
    NSAssert(0, @"Do not use FireBase init function!");
    return nil;
}

@end
