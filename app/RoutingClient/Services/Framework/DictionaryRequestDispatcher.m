//
//  BaseServiceRequestDispatcher.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//


#import "DictionaryRequestDispatcher.h"

@implementation DictionaryRequestDispatcher

#pragma mark NSURLConnectionDataDelegate implementation

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self assignDataFromCompletedConnection:connection];
    
    NSError *parseError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&parseError];
    if (!dict)
    {
        // JSON could not be parsed, call didFailLoadWithError delegate
        [self.delegate requestDispatcher:self didFailLoadWithError:parseError];
    }
    else
    {
        [self.delegate requestDispatcher:self didLoadObjects:dict];
    }
    
}

@end