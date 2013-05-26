//
//  JSONRequestDelegate.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServiceRequestDispatcher.h"
#import "DataRequestDelegateAdapter.h"

@protocol JSONRequestDelegate <NSObject>

-(void)jsonRequestDispatcher:(BaseServiceRequestDispatcher *)dispatcher didLoadJSON: (NSString*)jsonString;

@end

@interface JSONRequestDelegateAdapter : DataRequestDelegateAdapter <JSONRequestDelegate>

@property (strong, nonatomic) id<JSONRequestDelegate> jsonDelegate;

@end
