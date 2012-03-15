//
//  Created by Vitaliy Ruzhnikov on 15.03.12.
//
//
//


#import "VKRequest.h"


@interface VKRequest ()
@property(nonatomic, readonly) NSString *urlString;

- (void)addAllGETParamsTo:(NSMutableString *)resultURL;

- (void)removeLastHttpGETDelimiterFrom:(NSMutableString *)resultURL;

- (BOOL)hasNotGETParams;


@end

@implementation VKRequest {

@private
    NSString *_urlString;
    NSMutableDictionary *GETParameters;
}


@synthesize urlString = _urlString;

- (id)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = [urlString copy];
        GETParameters = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (void)dealloc {
    [_urlString release];
    _urlString = nil;
    [_urlString release];
    [GETParameters release];
    GETParameters = nil;
    [super dealloc];
}

- (void)setGetParameterWithName:(NSString *)name andValue:(NSString *)value {
    [GETParameters setObject:value forKey:name];
}

- (NSString *)getParameterWithName:(NSString *)name {
    return [GETParameters objectForKey:name];
}

- (NSURL *)url {
    NSMutableString *resultURL = [NSMutableString stringWithString:self.urlString];
    
    if ([self hasNotGETParams]) {
        return [NSURL URLWithString:self.urlString];
    }
    
    [self addAllGETParamsTo:resultURL];

    return [NSURL URLWithString:resultURL];
}

- (void)addAllGETParamsTo:(NSMutableString *)resultURL {
    [resultURL appendString:GET_PARAMETERS_DELIMETER];

    for (NSString *name in [GETParameters allKeys]) {
        NSString *paramValue =[GETParameters objectForKey:name];
        NSString *encodedParamValue = [paramValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [resultURL appendString:[NSString stringWithFormat:@"%@=%@", name, encodedParamValue]];
        [resultURL appendString:HTTP_GET_PARAMS_DELIMETER];
    }
    [self removeLastHttpGETDelimiterFrom:resultURL];
}


- (void)removeLastHttpGETDelimiterFrom:(NSMutableString *)resultURL {
    NSRange range = NSMakeRange([resultURL length] - 1, 1);
    [resultURL deleteCharactersInRange:range];
}

- (BOOL)hasNotGETParams {
    return [GETParameters count] == 0;
}

@end