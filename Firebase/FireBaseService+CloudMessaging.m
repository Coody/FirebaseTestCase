//
//  FireBaseService+CloudMessaging.m
//  TTQRCODE
//
//  Created by coodychou on 2018/10/5.
//  Copyright © 2018 coody. All rights reserved.
//

#import "FireBaseService+CloudMessaging.h"

@implementation FireBaseService (CloudMessaging)

-(void)initialFireBaseCloudMessaging{
    static BOOL isFirstTime = NO;
    if ( isFirstTime == NO ) {
        isFirstTime = YES;
        [FIRMessaging messaging].delegate = self;
    }
    else{
        NSLog(@" Has alerady initial Cloud Messaging !!");
    }
}

#pragma mark -
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}

@end
