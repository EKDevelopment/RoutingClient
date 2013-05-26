//
//  GeolocationDispatcherIntegrationTests.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "GeolocationDispatcherIntegrationTests.h"
#import "GeolocationDispatcher.h"

@implementation GeolocationDispatcherIntegrationTests

dispatch_semaphore_t semaphore;
GeolocationDispatcher *dispatcher;
NSMutableDictionary *address;
NSDictionary *location;

- (void)setUp {
    address = [[NSMutableDictionary alloc] init];
    semaphore = dispatch_semaphore_create(0);
}

- (void)testSpecificAddress {
    [address setObject:@"204 Winsted Rd" forKey:@"StreetName"];
    [address setObject:@"Torrington" forKey:@"City"];
    [address setObject:@"CT" forKey:@"State"];
    [address setObject:@"06790" forKey:@"PostalCode"];
    [address setObject:@"US" forKey:@"Country"];
    
    dispatcher = [GeolocationDispatcher locationForAddressDictionary:address];
    dispatcher.delegate = self;
    
    [dispatcher startDispatch];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    STAssertNotNil(location, @"Location(s) not returned");
}

- (void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadObjects:(id)object {
    NSLOG(@"%@",object);
    location = object;
    dispatch_semaphore_signal(semaphore);
}

- (void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didFailLoadWithError:(NSError *)error {
    STAssertNotNil(error, [NSString stringWithFormat:@"Request resulted in error: %@",error]);
    //error handling
    NSLog(@"error : %@",error.description);
    dispatch_semaphore_signal(semaphore);
}

- (NSInteger)errorManager:(NSError *)error
{
    return [error code];
}

@end
