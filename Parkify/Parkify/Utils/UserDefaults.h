//
//  UserDefaults.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserDefaults: NSObject

+ (void)saveToken:(NSString *)token forUserEmail:(NSString *)email;
+ (NSString *)tokenForUserEmail:(NSString *)email;
+ (NSString *)tokenForUser:(User *)user;
+ (void)saveToken:(NSString *)token forUser:(User *)user;
@end