//
//  GeolocationDispatcher.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "DictionaryRequestDispatcher.h"

@interface GeolocationDispatcher : DictionaryRequestDispatcher

+ (GeolocationDispatcher *) locationForAddressDictionary: (NSDictionary *)addressDictionary;

@end
