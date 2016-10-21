//
//  NSDate+Custom.m
//  PepperJelly
//
//  Created by Evandro Harrison Hoffmann on 2/24/16.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

#import "NSDate+Custom.h"

@implementation NSDate (Custom)

+(NSDate*)stringToDate:(NSString*)dateString format:(NSString*)format{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter dateFromString:dateString];
}

+(NSDate*)stringToDate:(NSString*)dateString format:(NSString*)format timeZone:(int)timezone{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:timezone]];
    return [dateFormatter dateFromString:dateString];
}

+(NSString*)dateToString:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:date];
}

+(NSString *)timeFormatted:(int)totalSeconds{
    //int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

+(NSDate *)formatToKirbDate:(NSString *)dateString{
    return [self stringToDate:dateString format:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
    
//    //Tue Jul 26 2016 16:41:00 GMT-0700 (PDT)
//    NSArray *splittedDate = [dateString componentsSeparatedByString:@" GMT-"];
//    
//    NSString *format = @"EEE MMM dd yyyy HH:mm:ss";
//    NSString *dateAndTime = dateString;
//    if(splittedDate.count > 1)
//        dateAndTime = [splittedDate firstObject];
//    
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    dateFormatter.dateFormat = format;
//    return [dateFormatter dateFromString:dateAndTime];
}

#pragma mark - Class Functions

-(NSString*)dateToStringWithFormat:(NSString*)format{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}

-(NSString*)dateToStringWithFormat:(NSString*)format timeZoneName:(NSString*)timezone{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:timezone]];
    return [dateFormatter stringFromDate:self];
}

-(NSString*)dateToStringWithFormat:(NSString*)format timeZone:(int)timezone{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:timezone]];
    return [dateFormatter stringFromDate:self];
}

-(BOOL)isBeforeDate:(NSDate*)date{
    NSComparisonResult result = [date compare:self];
    switch (result) {
        case NSOrderedAscending:
            NSLog(@"%@ is future Date compared to %@", self, date);
            break;
        case NSOrderedDescending:
            NSLog(@"%@ is earlier Date compared to %@", self, date);
            return true;
        case NSOrderedSame:
            NSLog(@"Today/Null Date Passed");
            break;
        default:
            NSLog(@"Error Comparing Dates");
            break;
    }
    
    return false;
}

-(NSDate *) toLocalTime{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *)fromGMTtoLocalTime{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
}

-(NSDate *) toGlobalTime{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

+(NSString *)getUTCFormateDate:(NSDate *)localDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(float)getUTCOffsetFromNow{
    return fabs(([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0));
}


-(float)getUTCOffsetFromDate{
    NSDate *sourceDate = self;
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    float timeZoneOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate] / 3600.0;
    NSLog(@"sourceDate=%@ timeZoneOffset=%f", sourceDate, timeZoneOffset);
    return timeZoneOffset;
}


-(BOOL)dateIsBeforeToday{
    
    if ([self timeIntervalSinceNow] < 0.0){
        NSLog(@"date is in the past");
        return true;
    }
    
    NSLog(@"date is in the future");
    return false;
}

@end
