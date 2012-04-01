//
//  Created by Vitaliy Ruzhnikov on 15.03.12.
//
//
//


#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

@protocol VKRequestDelegate;

static NSString *const GET_PARAMETERS_DELIMETER = @"?";
static NSString *const HTTP_GET_PARAMS_DELIMETER = @"&";
static NSString *const ERROR_DESCRIPTION_KEY = @"error_description";
static NSString *const ERROR_KEY = @"error";


@interface VKRequest : NSObject<ASIHTTPRequestDelegate>

- (id)initWithUrlString:(NSString *)urlString;


- (void)setGetParameterWithName:(NSString *)name andValue:(NSString *)value;


- (NSString *)getParameterWithName:(NSString *)name;

- (void)requestFailed:(id)request;

- (void)requestFinished:(id)request;

- (void)parse;

@property(readonly) NSURL* url;
@property(nonatomic, retain) id<VKRequestDelegate> delegate;
@property(nonatomic, copy) NSString *responseString;


@property(nonatomic, retain) NSError *responseError;
@end