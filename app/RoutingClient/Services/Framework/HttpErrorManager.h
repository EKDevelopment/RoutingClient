//
//  HttpErrorManager.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>

// HTML Error constants
#define kRequestTimeOut 1001
#define kInvalidUserNameOrPassword 401
#define kNotFound 404
#define kMethodNotAllowed 405
#define kBadRequest 400
#define kInternalServerError 500
#define kInvalidServerName 1003
#define kNoInternetConnection 1009

@interface HttpErrorManager: NSObject

/*!	@function	+parsedHttpError:
 @discussion	Returns a customized error object from the passed error object with user friendly error descriptions
 @param			error 		The NSError object to be customized with user friendly error messages
 @result		The customized NSError object */
+ (NSError *)parsedHttpError:(NSError *)error;

@end
