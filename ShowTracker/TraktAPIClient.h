//
//  TraktAPIClient.h
//  ShowTracker
//
//  Created by Allwyn on 22/07/14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>

extern NSString * const kTraktAPIKey;
extern NSString* const kTraktBaseURLString;


@interface TraktAPIClient : AFHTTPSessionManager;

+(TraktAPIClient*) sharedClient;

-(void) getShowsForDate:(NSDate*) date
               username:(NSString*) username
           numberOfDays:(int) numberOfDays
                success:(void(^)(NSURLSessionDataTask *task, id responsibleObject)) success
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error
                                 ))failure;
@end
