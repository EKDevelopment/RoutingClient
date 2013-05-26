//
//  JSONRequestDelegate.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "JSONRequestDelegateAdapter.h"

@implementation JSONRequestDelegateAdapter

-(void)dataRequestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadData:(NSData *)data {
    [super dataRequestDispatcher: dispatcher didLoadData: data];
    
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self jsonRequestDispatcher:dispatcher didLoadJSON:jsonString];
}

-(void)jsonRequestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadJSON: (NSString*)jsonString {
    [self.jsonDelegate jsonRequestDispatcher:dispatcher didLoadJSON:jsonString];
}

@end
