//
//  HTNetworkAPI.m
//  HaptikTask
//
//  Created by Shubham chawla on 10/9/16.
//  Copyright © 2016 Shubham Chawla. All rights reserved.
//

#import "HTNetworkAPI.h"

@implementation HTNetworkAPI

+ (AFHTTPRequestOperationManager*) manager {
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"os"];
    
    return manager;
}

+(void) reportError: (HTStatusCode) statusCode
           response: (id) responseObject
            failure: (closure) aFailedClosure
              error: (NSError *) error {

}
+(HTStatusCode) getStatusCode: (NSInteger) statusCode {
    switch (statusCode) {
        case 200:
            return HTStatusCodeSuccess;
            break;
        case HTStatusCodeFailedError:
            return HTStatusCodeFailedError;
            break;
          }
    return HTStatusCodeFailedError;
}

+(HTStatusCode) validateResponse: (NSDictionary*)dictionary operation:(AFHTTPRequestOperation*)operation {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return HTStatusCodeSuccess;
    }
    id responseCode = [dictionary objectForKey:@"responseCode"];
    id statusCode = [dictionary objectForKey:@"status"];
    
    if ((responseCode && [responseCode isKindOfClass:[NSNumber class]]) || (statusCode && [statusCode isKindOfClass:[NSNumber class]])) {
        id code = responseCode ? responseCode:statusCode;
        NSInteger status = [code integerValue];
        HTStatusCode scode = [self getStatusCode: status];
        return scode;
    }
    if (responseCode == nil) return HTStatusCodeSuccess;
    return HTStatusCodeFailedError;
}

+(void) handleRequestSuccessResponse: (AFHTTPRequestOperation *) operation
                            response: (id) responseObject
                             success: (closure) aSuccessClosure
                             failure: (closure) aFailedClosure {
    
    HTStatusCode statusCode = [HTNetworkAPI validateResponse:responseObject operation:operation];
    NSLog(@"Response - %@", responseObject);
    if (statusCode == HTStatusCodeSuccess) {
        if (aSuccessClosure)
            aSuccessClosure(@{@"Response":responseObject});
    }
    else {
        [self reportError: statusCode response: responseObject failure: aFailedClosure error: nil];
    }
}


+(void) handleRequestFailure: (AFHTTPRequestOperation *) operation
                       error: (NSError *) error
                     failure: (closure) aFailedClosure {
    
    if (operation) {
        NSInteger responseCode = [operation.response statusCode];
        HTStatusCode statusCode = [self getStatusCode: responseCode];
        NSDictionary *responseObject = CHECK_NULL_VAL([operation responseObject]);
        NSLog(@"Response - %@", responseObject);
        if (CHECK_NULL_VAL(responseObject[@"responseCode"])) {
            NSInteger respCode = [responseObject[@"responseCode"] integerValue];
            HTStatusCode rCode = [self getStatusCode: respCode];
            if (rCode != HTStatusCodeFailedError)
                statusCode = rCode;
        }
        [self reportError: statusCode response: responseObject failure:aFailedClosure error: error];
    }
}

+ (AFHTTPRequestOperation*)GET:(NSMutableDictionary *)urlParameters
                    parameters:(id)parameters
                       success:(closure) aSuccessClosure
                       failure:(closure) aFailedClosure {
    NSLog(@"GET Url - %@", [urlParameters objectForKey: kUrlKey]);
    
    NSString *urlString = CHECK_NULL_VAL([urlParameters objectForKey: kUrlKey]);
    if (urlString) {
        AFHTTPRequestOperationManager* manager = [HTNetworkAPI manager];
        
        AFHTTPRequestOperation *op = [manager GET:[urlParameters objectForKey: kUrlKey] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
                                      {
                                          [self handleRequestSuccessResponse:operation response:responseObject success: aSuccessClosure failure: aFailedClosure];
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                      {
                                          [self handleRequestFailure: operation error: error failure: aFailedClosure];
                                      }];
        return op;
    }
    return nil;
}


+(void) getConversationData:(closure) aSuccessClosure onFailure:(closure) aFailedClosure {
    NSMutableDictionary *urlParameters =[NSMutableDictionary new];
    NSString *urlString = @"http://www.haptik.co/app/test_data";
    [urlParameters setObject:urlString forKey: kUrlKey];
    [HTNetworkAPI GET:urlParameters parameters:nil success:aSuccessClosure failure:aFailedClosure];
}

@end
