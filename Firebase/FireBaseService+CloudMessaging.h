//
//  FireBaseService+CloudMessaging.h
//  TTQRCODE
//
//  Created by coodychou on 2018/10/5.
//  Copyright © 2018 coody. All rights reserved.
//

@import Firebase;

#import "FireBaseService.h"

@interface FireBaseService (CloudMessaging)<FIRMessagingDelegate>

-(void)initialFireBaseCloudMessaging;

@end
