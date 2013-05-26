//
//  BaseServiceRequestDispatcher.m
//  RoutingClient
//
//  Created by Nightcrawler on 5/25/13.
//  Copyright (c) 2013 EKDevelopment. All rights reserved.
//

#import "BaseServiceRequestDispatcher.h"
#import "HttpErrorManager.h"


@interface BaseServiceRequestDispatcher()
{
    NSURLConnection* _connection;
    NSMutableData* _privateData;
    BOOL _downloadComplete;
    BOOL _jsonRequest;
}

@end

@implementation BaseServiceRequestDispatcher

+ (NSOperationQueue*)downloadQueue {
    static NSOperationQueue* queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
    });
    
    return queue;
}

- (id)initFromURL:(NSString *)urlString {
    return [self initFromURL:urlString postString:nil];
}

- (id)initFromURL:(NSString *)urlString jsonString:(NSString *)jsonString {
    _jsonRequest = YES;
    return [self initFromURL:urlString postString:jsonString];
}

- (id)initFromURL:(NSString *)urlString postString:(NSString *)postString {
    if(!(self = [super init])) {return NULL;}
    
    self.urlString = urlString;
    self.postString = postString;
    _privateData = [[NSMutableData alloc] init];
    
    // defaults of NSMutableRequest's initWithUrl
    self.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    self.requestTimeoutInterval = 60;
    
    _connection = [self createConnection];
    _downloadComplete = false;
    
    return self;
}

- (BOOL)isJsonRequest
{
    return _jsonRequest;
}

- (NSMutableURLRequest*)createRequest {
    NSString *encodedURLString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:encodedURLString] cachePolicy:self.requestCachePolicy timeoutInterval:self.requestTimeoutInterval];
    
    // This class supports both GET and POST requests.
    // If self.postString is non-nil, that data is used to create a POST request.
    // Otherwise, self.urlString is used by itself as a GET request.
    if (self.postString != nil)
    {
        NSData *postData = [self.postString dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:postData];

        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
        if (_jsonRequest)
            [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return req;
}

- (NSURLConnection*)createConnection {
    NSMutableURLRequest *req = [self createRequest];
    NSURLConnection* connection = [[NSURLConnection new] initWithRequest:req delegate:self startImmediately:false];
    [connection setDelegateQueue:[BaseServiceRequestDispatcher downloadQueue]];
    
    return connection;
}

- (void)startDispatch {
    if(_downloadComplete) {[self connectionDidFinishLoading:_connection];}
    else {
        if (!_connection) {_connection = [self createConnection];}
        [_connection start];
    }
}

- (void)cancelDispatch {
    if(!_downloadComplete) {
        [_connection cancel];
        _connection = nil;
    }
}

- (void)assignDataFromCompletedConnection:(NSURLConnection *)connection {
    if (connection == _connection && connection != nil)
    {
        self.data = _privateData;
        _downloadComplete = true;
        _connection = nil;
        _privateData = nil;
    }
}

#pragma mark NSURLConnectionDataDelegate implementation

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        int statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode >= 400)
        {
            [_connection cancel];  // stop connecting; no more delegate messages
            NSString *formattedStatusMessage = [NSString stringWithFormat:NSLocalizedString(@"Server returned status code %d",@""), statusCode];
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:formattedStatusMessage forKey:NSLocalizedDescriptionKey];
            NSError *statusError = [NSError errorWithDomain:@"HTTP" code:statusCode userInfo:errorInfo];
            [self connection:connection didFailWithError:statusError];
            return;
        }
    }
    
    [_privateData setLength:0]; // Reset data in case of a redirect.
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_privateData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self assignDataFromCompletedConnection:connection];
    [self.delegate requestDispatcher:self didLoadObjects:self.data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _downloadComplete = true;
    _connection = nil;
    _privateData = nil;
    
    NSLOG(@"Connection failed - %@ %@", error.localizedDescription, [error.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    NSError *customizedError = [HttpErrorManager parsedHttpError:error];
    
    [self.delegate requestDispatcher:self didFailLoadWithError:customizedError];
}



// @remarks- requestDispatcher:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite: is optional in RequestDispatcherDictionary
// Implement this method in your delegate to receive updates of bytes written messages
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{

    if ([self.delegate respondsToSelector:@selector(requestDispatcher:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:)])
        [self.delegate requestDispatcher:self didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite];
}


@end