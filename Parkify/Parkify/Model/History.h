//
//  History.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Draw.h"
#import "User.h"

@interface History : NSObject


@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) Draw *draw;
@property(nonatomic, strong) User *user;
// special cases?

@end
