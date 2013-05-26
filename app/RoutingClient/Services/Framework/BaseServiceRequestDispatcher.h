//
//  BaseServiceRequestDispatcher.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDispatcherDelegate.h"

@interface BaseServiceRequestDispatcher : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *postString;
@property (nonatomic, retain) NSData* data;
@property (nonatomic) NSURLRequestCachePolicy requestCachePolicy;
@property (nonatomic) NSTimeInterval requestTimeoutInterval;
@property (nonatomic,readonly)BOOL isJsonRequest;

@property (nonatomic, strong) id <NSObject, RequestDispatcherDelegate> delegate;

- (id)initFromURL:(NSString *)urlString;
- (id)initFromURL:(NSString *)urlString postString:(NSString *)postString;
- (id)initFromURL:(NSString *)urlString jsonString:(NSString *)jsonString;

- (void)assignDataFromCompletedConnection:(NSURLConnection *)connection;

- (void)startDispatch;
- (void)cancelDispatch;

@end
