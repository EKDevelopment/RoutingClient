//
//  HttpErrorManager.h
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//


#import "HttpErrorManager.h"

@interface HttpErrorManager()

@end

@implementation HttpErrorManager

+ (NSError *)parsedHttpError:(NSError *)error
{
    NSInteger statusCode =[error code];
    NSString *errorMessage = nil;
    NSInteger errorCode;
    if([error code] < 0)
    {
        errorCode = -1 * [error code];
    }
    else
    {
        errorCode = [error code];
        
    }
    switch(errorCode)
    {
        case kRequestTimeOut:
        {
            errorMessage = NSLocalizedString(@"HTTPServiceRequestTimedOut", nil);
        }
            break;
        case kInvalidUserNameOrPassword:
        {
            errorMessage = NSLocalizedString(@"HTTPServerRequireAuth", nil);        }
            break;
        case kNotFound:
        case kMethodNotAllowed:
        case kBadRequest:
        {
            errorMessage = NSLocalizedString(@"HTTPService​NotFound", nil);
        }
            break;
        case kInternalServerError:
        {
            errorMessage = NSLocalizedString(@"HTTPServerUnexpectedCondition", nil);
        }
        case kInvalidServerName:
        {
            errorMessage = NSLocalizedString(@"HTTPServerNotResolved", nil);
        }
            break;
        case kNoInternetConnection:
        {
            errorMessage = NSLocalizedString(@"HTTPConnectionFailed", nil);
        }
            break;
        default:
        {
            errorMessage = NSLocalizedString(@"HTTPUnknownError", nil);
        }
            break;
    }
    
    NSString *formattedStatusMessage = errorMessage;
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:formattedStatusMessage forKey:NSLocalizedDescriptionKey];
    NSError *statusError = [NSError errorWithDomain:@"HTTP" code:statusCode userInfo:errorInfo];
    
    return statusError;
}


@end
