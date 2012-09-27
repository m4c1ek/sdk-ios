//
//  SPiDAccessToken.m
//  SPiDSDK
//
//  Created by Mikael Lindström on 9/25/12.
//  Copyright (c) 2012 Schibsted Payment. All rights reserved.
//


#import "SPiDAccessToken.h"

static NSString *const AccessTokenKey = @"access_token";
static NSString *const ExpiresInKey = @"expires_in";
static NSString *const ExpiresAtKey = @"expires_at";
static NSString *const RefreshTokenKey = @"refresh_token";

@implementation SPiDAccessToken

@synthesize accessToken = _accessToken;
@synthesize expiresAt = _expiresIn;
@synthesize refreshToken = _refreshToken;

- (id)initWithAccessToken:(NSString *)accessToken andExpiresAt:(NSDate *)expiresAt andRefreshToken:(NSString *)refreshToken {
    self = [super init];
    if (self) {
        [self setAccessToken:accessToken];
        [self setExpiresAt:expiresAt];
        [self setRefreshToken:refreshToken];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    NSString *accessToken = [dictionary objectForKey:AccessTokenKey];
    NSString *expiresIn = [dictionary objectForKey:ExpiresInKey];
    NSString *refreshToken = [dictionary objectForKey:RefreshTokenKey];

    NSDate *expiresAt;
    if (expiresIn) {
        expiresAt = [NSDate dateWithTimeIntervalSinceNow:[expiresIn integerValue]];
    }

    return [self initWithAccessToken:accessToken andExpiresAt:expiresAt andRefreshToken:refreshToken];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *accessToken = [decoder decodeObjectForKey:AccessTokenKey];
    NSDate *expiresAt = [decoder decodeObjectForKey:ExpiresAtKey];
    NSString *refreshToken = [decoder decodeObjectForKey:RefreshTokenKey];
    return [self initWithAccessToken:accessToken andExpiresAt:expiresAt andRefreshToken:refreshToken];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self accessToken] forKey:AccessTokenKey];
    [coder encodeObject:[self expiresAt] forKey:ExpiresInKey];
    [coder encodeObject:[self refreshToken] forKey:RefreshTokenKey];
}

- (BOOL)hasTokenExpired {
    return ([[NSDate date] earlierDate:[self expiresAt]] == [self expiresAt]);
}

@end