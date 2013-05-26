//
//  GeolocationDispatcher.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "GeolocationDispatcher.h"

@implementation GeolocationDispatcher

+ (GeolocationDispatcher *)locationForAddressDictionary:(NSDictionary *)addressDictionary {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:addressDictionary options:kNilOptions error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    return [[GeolocationDispatcher alloc] initFromURL:@"http://gis.routrix.com:801/Routrix/GISServices/gis/geocode" jsonString:jsonString];
}

@end
