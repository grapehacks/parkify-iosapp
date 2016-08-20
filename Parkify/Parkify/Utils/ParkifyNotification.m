//
//  ParkifyNotification.m
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "ParkifyNotification.h"
#import <UIKit/UIKit.h>

@implementation ParkifyNotification

+ (void)sendNotificationForMessage:(Message *)message {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertTitle = message.topic;
    localNotification.alertBody = message.text;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
