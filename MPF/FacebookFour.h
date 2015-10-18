//
//  FacebookFour.h
//  MPF
//
//  Created by Alexander Krupnik on 17/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookFour : NSObject
@property(nonatomic,strong) NSMutableArray *imgIds;
-(void) loadFourPictures;
+ (NSURLSession *)session;
@end
