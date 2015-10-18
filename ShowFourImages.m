//
//  ShowFourImages.m
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import "ShowFourImages.h"
#import "InstagramFour.h"
#import "Images.h"

@interface ShowFourImages () {
    int _imagesShown;
}

@end

@implementation ShowFourImages

- (void)viewDidLoad {
    [super viewDidLoad];
    [Images sharedInstance].object = self;
    [self.activityIndicator setHidesWhenStopped:YES];
}


-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self.activityIndicator startAnimating];
    _imagesShown = 0;
}

-(void) checkDownloadStatus {
    
    _imagesShown++;
    if(_imagesShown == 4) {
        [self.activityIndicator stopAnimating];
    }
}

- (void) display1 {
    
    NSLog(@"image1 are downloaded");
    self.imageView1.image = [Images sharedInstance].image1;
    [self checkDownloadStatus];
    
}

- (void) display2 {
    
    NSLog(@"image2 are downloaded");
    self.imageView2.image = [Images sharedInstance].image2;
    [self checkDownloadStatus];
}

- (void) display3 {
    
    NSLog(@"image3 are downloaded");
    [self.imageView3 setImage:[Images sharedInstance].image3];
    [self checkDownloadStatus];
    }

- (void) display4 {
    
    NSLog(@"image4 are downloaded");
    [self.imageView4 setImage:[Images sharedInstance].image4];
    [self checkDownloadStatus];
}

- (IBAction)refresh:(id)sender {
    
    if(_imagesShown == 4) {
        _imagesShown = 0;
        [self.activityIndicator startAnimating];
        [[Images sharedInstance].pictureSource loadFourPictures];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
