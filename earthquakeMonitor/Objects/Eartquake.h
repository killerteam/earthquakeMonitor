//
//  Eartquake.h
//  earthquakeMonitor
//
//  Created by Miguel Garcia Topete on 04/03/15.
//  Copyright (c) 2015 Miguel Garcia Topete. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Eartquake : NSObject

@property float mag;
@property (strong) NSString *place;
@property (strong) NSString *timeStamp;
@property (strong) NSString *lapsed;
@property float latitude;
@property float longitude;
@property float depth;



- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (id)equakeWithDictionary:(NSDictionary *)dictionary;

- (NSString *)convertToHumanDate:(NSString*)timeStampString;
- (NSString *)relativeDateFrom:(NSString *)date;
@end
