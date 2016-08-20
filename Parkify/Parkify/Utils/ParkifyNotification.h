//
//  ParkifyNotification.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface ParkifyNotification : NSObject

+ (void)sendNotificationForMessage:(Message *)message;

@end
