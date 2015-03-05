//
//  Eartquake.m
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import "Eartquake.h"


@implementation Eartquake
@synthesize place, mag, timeStamp, longitude, latitude, depth,lapsed;
- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init])
    {
        self.place       = [[dictionary objectForKey:@"properties"] objectForKey:@"place"];
        self.mag         = [[[dictionary objectForKey:@"properties"] objectForKey:@"mag"]floatValue];
        NSString *tmp   = [[dictionary objectForKey:@"properties"]objectForKey:@"time"];
        self.timeStamp   = [self convertToHumanDate:tmp];
        self.lapsed      = [self relativeDateFrom:self.timeStamp];
        self.longitude   = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:0]floatValue];
        self.latitude    = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:1]floatValue];
        self.depth =[[[[dictionary objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:2]floatValue];
    }
    return self;
}
+ (id)equakeWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (NSString *)convertToHumanDate:(NSString*)timeStampString
{
    NSLog(@"timestampstring:%@",timeStampString);
    double timestampval =  [timeStampString doubleValue]/1000;
    NSTimeInterval interval=(NSTimeInterval)timestampval;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy'-'MM'-'dd' T 'HH':'mm':'ss' PST'"];
    NSString *_date=[_formatter stringFromDate:date];
   return _date;
}
- (NSString *)relativeDateFrom:(NSString *)date
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeIdentifier = locale.localeIdentifier;
    NSLocale *currentLocale = [[NSLocale alloc]initWithLocaleIdentifier:localeIdentifier];
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setLocale:currentLocale];
    [hourFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //[hourFormatter setDateFormat:@"yyyy-MM-dd T HH:mm:ssZ"];
    
    NSDate *convertedDate = [hourFormatter dateFromString:date];
    
    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    
    if(ti < 1) {
        return @"just now";
    } else 	if (ti < 60) {
        int diff = round(ti);
        return [NSString stringWithFormat:@"%ds ago", diff];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%dm ago", diff];
    } else
    {
        return[NSString stringWithFormat:@"1h ago"];
    }
}




@end
