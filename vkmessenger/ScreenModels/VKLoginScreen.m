//
//  Created by Vitaliy Ruzhnikov on 29.03.12.
//
//
//


#import "VKLoginScreen.h"
#import "VKAuthenticator.h"
#import "OxICContainer.h"
#import "VKLoginScreenDelegate.h"


@interface VKLoginScreen ()
- (void)startWait;

- (void)stopWait;


@end

@implementation VKLoginScreen {

@private
    VKAuthenticator *_authenticator;
    BOOL _isWaiting;
}
IoCName(loginScreen)
IoCSingleton
IoCLazy

IoCInject(authenticator, authenticator)
@synthesize authenticator = _authenticator;

@synthesize delegate = _delegate;
@synthesize isWaiting = _isWaiting;


- (void)setAuthenticator:(VKAuthenticator *)anAuthenticator {
    [_authenticator release];
    _authenticator = [anAuthenticator retain];
    _authenticator.delegate = self;
}


- (void)enteredLogin:(NSString *)login andPassword:(NSString *)password {
    [self startWait];


    [self.authenticator loginWithUsername:login andPassword:password];
}

- (void)startWait {
    _isWaiting = YES;

    [self.delegate startWait];
}


- (void)loginFinished {
    [self stopWait];

    [self.delegate enterInApplication];
}

- (void)stopWait {
    _isWaiting = NO;

    [self.delegate stopWait];
}

- (void)loginFailed {
    _isWaiting = NO;
    if (_isWaiting) {
        [self.delegate startWait];
    } else {
        [self.delegate stopWait];
    }
}

- (void)dealloc {
    self.authenticator = nil;
    self.delegate = nil;
    [super dealloc];
}

@end