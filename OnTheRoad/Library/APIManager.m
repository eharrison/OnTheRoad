//
//  APIManager.m
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "APIManager.h"
#import "OnTheRoad-swift.h"

#define kFlightTickets @"https://api.myjson.com/bins/w60i"
#define kBusTickets @"https://api.myjson.com/bins/37yzm"
#define kTrainTickets @"https://api.myjson.com/bins/3zmcy"

@implementation APIManager

+(void)fetchTicketsWithType:(TicketType)type success:(void (^)(NSArray *))success failure:(void (^)())failure{
    NSString *urlString = @"";
    switch (type) {
        case BusTicket: urlString = kBusTickets; break;
        case TrainTicket: urlString = kTrainTickets; break;
        case FlightTicket: urlString = kFlightTickets; break;
    }
    
    [AwesomeFetcher fetchData:urlString completion:^(NSData *data) {
        NSDictionary *jsonObject = [AwesomeParser jsonObject:data];
        if (jsonObject) {
            NSArray *tickets = [Ticket parseJSONArray:jsonObject type:type];
            [Ticket save];
            success(tickets);
        }else{
            failure();
        }
    }];
}

@end
