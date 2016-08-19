//
//  User.h
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

typedef NS_ENUM(NSInteger, UserType) {
  UserTypeUser,
  UserTypeAdmin,
  UserTypeDefault = UserTypeUser
};

typedef NS_ENUM(NSInteger, ParticipateMode) {
  ParticipateModeDecline,
  ParticipateModeAccept,
  ParticipateModeTentative,
  ParticipateModeDefault = ParticipateModeAccept
};


@interface User : NSObject
@property (nonatomic, strong) NSString *name;
//passwd?
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) UserType type;
@property (nonatomic, strong) Card *card;
@property (nonatomic, assign) ParticipateMode participate;
@property (nonatomic, assign) BOOL rememberChoice;
//removed?
@property (nonatomic, assign) NSInteger unreadMsgCounter;
@end
