//
//  RequestDispatcherDelegate.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseServiceRequestDispatcher;

@protocol RequestDispatcherDelegate <NSObject>

// Sent to the delegate when on succesful completion of an attempted load.
- (void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadObjects:(id)object;

@optional
// Sent to the delegeate when a load attempt fails.
- (void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didFailLoadWithError:(NSError *)error;

@optional
// Sent to the delegate when a request has updated the amount of body written
- (void)requestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end
