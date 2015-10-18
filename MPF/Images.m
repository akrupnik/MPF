//
//  Images.m
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import "Images.h"

@implementation Images

#pragma mark - Singleton Methods

+ (Images *)sharedInstance {
    
    static Images *_sharedInstance;
    if(!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // Custom initialization
        _image1 = nil;
        _image2 = nil;
        _image3 = nil;
        _image4 = nil;
    }
    return self;
}

@end
