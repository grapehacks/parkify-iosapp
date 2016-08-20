//
//  UserDefaults.m
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (void)saveToken:(NSString *)token forUserEmail:(NSString *)email {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:token forKey:email];
  [defaults synchronize];
}

+ (NSString *)tokenForUserEmail:(NSString *)email {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults stringForKey:email];
}

+ (void)saveToken:(NSString *)token forUser:(User *)user {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:token forKey:user.email];
}

+ (NSString *)tokenForUser:(User *)user {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults stringForKey:user.email];
}
@end
