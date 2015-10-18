//
//  ViewController.m
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "ViewController.h"
#import "ShowFourImages.h"
#import "InstagramFour.h"
#import "FacebookFour.h"
#import "Images.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) downloadFourImagesUsingSource: (id) class andTitle:(NSString *) title {
    ShowFourImages *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowFour"];
    vc.navigationItem.title = title;
    [self.navigationController pushViewController:vc animated:true];
    id object = [[class alloc] init];
    [Images sharedInstance].pictureSource = object;
    [object loadFourPictures];
}

- (IBAction)downloadFromFacebook:(id)sender {
  
    [self downloadFourImagesUsingSource:[FacebookFour class] andTitle:@"Facebook Random Four"];
}

- (IBAction)downloadFromInstagram:(id)sender {

    [self downloadFourImagesUsingSource:[InstagramFour class] andTitle:@"Instagram Most Popular Four"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
