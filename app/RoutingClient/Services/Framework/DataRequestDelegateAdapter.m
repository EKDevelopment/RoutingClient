//
//  DataRequestDelegate.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "DataRequestDelegateAdapter.h"

@implementation DataRequestDelegateAdapter

-(void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadObjects:(id)object {
    NSData *data = (NSData*) object;
    [self dataRequestDispatcher:dispatcher didLoadData:data];
}

-(void)dataRequestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadData:(NSData *)data {
    [self.dataDelegate dataRequestDispatcher:dispatcher didLoadData:data];
}

@end
