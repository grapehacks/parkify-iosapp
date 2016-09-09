//
//  ParkifyNotification.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "User.h"

@interface ParkifyNotification : NSObject

+ (instancetype)sharedInstance;
- (void)setupNotificationForUser:(User *)user andDate:(NSDate *)date;

@end
