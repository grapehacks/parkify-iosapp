//
//  Message.h
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MessageType) {
  MessageTypeLoss,
  MessageTypeLossReturn,
  MessageTypeWin,
  MessageTypeWinReceive,
  MessageTypeInfo,
  MessageTypeWarning,
  MessageTypeError,
  MessageTypeDefault = MessageTypeInfo
};

@interface Message : NSObject
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign, getter=isRead) BOOL read;
@property (nonatomic, strong) NSDate *date;
@end
