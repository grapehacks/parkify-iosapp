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

+ (instancetype)sharedInstance {
    static ParkifyNotification *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ParkifyNotification alloc] init];
        
    });
    return sharedInstance;
}

- (void)clearNotifications {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)setupNotificationForUser:(User *)user andDate:(NSDate *)date {
    // to clear previous notifications since setup is made in ping response and could schedule a lot of notification
    [self clearNotifications];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.alertTitle = [NSString stringWithFormat:@"%@ %@",@"Hello ",user.name];
    localNotification.alertBody = @"It's a card draw!";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
