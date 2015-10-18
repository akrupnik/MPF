//
//  InstagramFour.h
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramFour : NSObject
@property (strong, nonatomic) NSArray *sortedItems;
-(void) loadFourPictures;

@end
