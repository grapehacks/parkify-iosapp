//
//  JSONParser.h
//  Parkify
//
//  Created by Sławek Derwisz on 19/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Message.h"

@interface JSONParser : NSObject

- (id)objectOfType:(Class)objectType fromJSONString:(NSString *)jsonString;
- (User *)userFromDictionary:(NSDictionary *)jsonDictionary;
- (Message *)messageFromDictionary:(NSDictionary *)jsonDictionary;
- (NSDate *)dateFromString:(NSString *)dateString;
@end
