//
//  InstagramFour.m
//  MPF
//
//  Created by Alexander Krupnik on 16/10/15.
//  Copyright © 2015 Alexander Krupnik. All rights reserved.
//

#import "InstagramFour.h"
#import "Images.h"

static NSString *const  INSTAGRAM_QUERY = @"https://api.instagram.com/v1/media/popular?access_token=2218748617.ea3ed6e.b4f54912924d410cbabe0a2a97393a82";


@implementation InstagramFour

-(id) init {
    if([super init]) {
        self.sortedItems = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) loadFourPictures {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:INSTAGRAM_QUERY] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSLog(@"%@",json);
        if(jsonError) {
            NSLog(@"JSON serialisation error = %@", error);
            return;
        }
        NSArray *items = [json objectForKey:@"data"];
        NSArray *sortedArray = [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            int first = (int) [[a objectForKey:@"likes"] objectForKey:@"count"];
            int second = (int)[[b objectForKey:@"likes"] objectForKey:@"count"];
            return first <= second;
        }];
        self.sortedItems = sortedArray;
        [self displayPictures];
    }];
    [dataTask resume];
}

-(void) displayPictures {
    if(!self.sortedItems) return;
    NSURLSession *imageGetSession = [NSURLSession sharedSession];
    NSLog(@"display pictures");
    Images *fourImages = [Images sharedInstance];
    for(int i = 0; i < 4; i++) {
        id item = self.sortedItems[i];
        id imgUrl =[[[item objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
        NSURL *url = [NSURL URLWithString:imgUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"GET";
        NSURLSessionDataTask *getDataTask = [imageGetSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(i == 0) {
                    fourImages.image1 = image;
                    [[Images sharedInstance].object display1];
                }
                else if(i == 1) {
                    fourImages.image2 = image;
                    [[Images sharedInstance].object display2];
                }
                else if(i == 2){
                    fourImages.image3 = image;
                    [[Images sharedInstance].object display3];
                }
                else if (i == 3){
                    fourImages.image4 = image;
                    [[Images sharedInstance].object display4];
                }
            });
        
        }];//getDataTask
        [getDataTask resume];
    }//for
}


@end
