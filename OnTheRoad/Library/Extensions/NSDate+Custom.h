//
//  NSDate+Custom.h
//  PepperJelly
//
//  Created by Evandro Harrison Hoffmann on 2/24/16.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Custom)

+(NSDate*)stringToDate:(NSString*)dateString format:(NSString*)format;
+(NSDate*)stringToDate:(NSString*)dateString format:(NSString*)format timeZone:(int)timezone;
+(NSString*)dateToString:(NSDate*)date format:(NSString*)format;
+(NSString *)timeFormatted:(int)totalSeconds;
+(NSString *)getUTCFormateDate:(NSDate *)localDate;

+(NSDate*)formatToKirbDate:(NSString*)dateString;

-(NSString*)dateToStringWithFormat:(NSString*)format;
-(NSString*)dateToStringWithFormat:(NSString*)format timeZoneName:(NSString*)timezone;
-(NSString*)dateToStringWithFormat:(NSString*)format timeZone:(int)timezone;

-(BOOL)isBeforeDate:(NSDate*)date;

-(NSDate *)fromGMTtoLocalTime;
-(NSDate *)toLocalTime;
-(NSDate *)toGlobalTime;
+(float)getUTCOffsetFromNow;
-(float)getUTCOffsetFromDate;
-(BOOL)dateIsBeforeToday;

@end
