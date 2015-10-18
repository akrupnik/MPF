//
//  Images.h
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShowFourImages.h"


@interface Images : NSObject

+ (Images *)sharedInstance;

@property(strong,nonatomic) ShowFourImages *object;
@property(strong, nonatomic) id pictureSource;

@property(strong,nonatomic) UIImage *image1;
@property(strong,nonatomic) UIImage *image2;
@property(strong,nonatomic) UIImage *image3;
@property(strong,nonatomic) UIImage *image4;

@end
