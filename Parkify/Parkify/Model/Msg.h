//
//  Msg.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MsgType) {
    MsgTypeLoose,
    MsgTypeLooseGiveBack,
    MsgTypeWin,
    MsgTypeWinRecive,
    MsgTypeInfo,
    MsgTypeWarning,
    MsgTypeTerror
};

@interface Msg : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, assign) MsgType type;

@end
