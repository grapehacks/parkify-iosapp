//
//  ConnectionManager.h
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Message.h"

@interface ConnectionManager : NSObject

+ (instancetype)sharedInstance;

- (void)authenticateWithLogin:(NSString *)login password:(NSString *)passwd completionHandler:(void (^)(NSString *token, User *user, NSError *error))completion;
- (void)pingWithToken:(NSString *)token completionHandler:(void (^)(NSDate *date, User *user, NSError *error))completion;
- (void)retrieveMessagesWithToken:(NSString *)token completionHandler:(void (^)(NSArray *messages, NSError *error))completion;

//- (void)retrieveUsersWithToken:(NSString *)token completionHandler:(void (^)(NSArray *users, NSError *error))completion;
//- (void)retrieveCardsWithToken:(NSString *)token completionHandler:(void (^)(NSArray *cards, NSError *error))completion;
@end
