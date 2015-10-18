//
//  ShowFourImages.h
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowFourImages : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void) display1;
-(void) display2;
-(void) display3;
-(void) display4;

- (IBAction)refresh:(id)sender;


@end
