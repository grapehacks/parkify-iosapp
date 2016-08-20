//
//  Draw.h
//  Parkify
//
//  Created by Adam Kozłowski on 20/08/16.
//  Copyright © 2016 Sławek Derwisz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Card.h"


@interface Draw : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Card *card;

@end
