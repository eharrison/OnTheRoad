//
//  APIManager.h
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface APIManager : NSObject

+(void)fetchTicketsWithType:(TicketType)type success:(void (^)(NSArray *tickets))success failure:(void (^)())failure;

@end
