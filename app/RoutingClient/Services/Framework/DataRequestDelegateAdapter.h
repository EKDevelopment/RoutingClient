//
//  DataRequestDelegate.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServiceRequestDispatcher.h"

@protocol DataRequestDelegate <NSObject>

-(void) dataRequestDispatcher: (BaseServiceRequestDispatcher*) dispatcher didLoadData: (NSData*) data;

@end

@interface DataRequestDelegateAdapter : NSObject<RequestDispatcherDelegate, DataRequestDelegate>

@property (strong, nonatomic) id<DataRequestDelegate> dataDelegate;

@end