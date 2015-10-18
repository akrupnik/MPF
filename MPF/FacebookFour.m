//
//  FacebookFour.m
//  MPF
//
//  Created by Alexander Krupnik on 17/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "FacebookFour.h"
#import "NSMutableArray+Functions.h"
#import "Images.h"


static NSString *const FACEBOOK_ACCESS_TOKEN = @"CAAXuWOPMyrcBAKd0LoNzPtcVYo737s4enUO1r8OMy2FPEb8zv88liGxWb5K5wwSOdiIPcV5kLAqWh9O8JVyUFBAd9JG85620JCMF2RI9SLaDp7HNO3Ks1gZBIPyVnmBANJywJWUJ90IZBPyZBC39ioBg7UZASDisG5TFT3wvuaaEK0fYIp7Qc1Bo9cHJI1kZD";


@interface FacebookFour () {
    
}
@property(nonatomic,strong) NSArray *albumIds;
@end

@implementation FacebookFour



-(id) init {
    if([super init]) {
        self.imgIds = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSURLSession *)session {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        [configuration setHTTPMaximumConnectionsPerHost:1];
        
        session = [NSURLSession sessionWithConfiguration:configuration];
        
    });
    return session;
}


-(void) loadFourPictures {
    
    // get album list
    [self.imgIds removeAllObjects];
    NSString *albumListQuery = [NSString stringWithFormat:@"https://graph.facebook.com/v2.1/116856095313846/albums?access_token=%@",FACEBOOK_ACCESS_TOKEN];
    NSURLSessionDataTask *dataTask = [ [[self class] session] dataTaskWithURL:[NSURL URLWithString:albumListQuery] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            NSLog(@"JSON serialisation error = %@", error);
            return;
        }
        
        NSArray *items = [json objectForKey:@"data"];
        NSMutableArray *albumIds = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [items count]; i++) {
            [albumIds addObject:[items[i] objectForKey:@"id"]];
        }
        self.albumIds = [albumIds shuffle];
        //get image IDs
        NSOperationQueue  *imageQueue = [NSOperationQueue new];
        [imageQueue addOperationWithBlock:^{
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            __block BOOL foundFour = false;
            for(int i=0; !foundFour && i < [self.albumIds count]; i++) {
                NSLog(@"imgIDs, i= %ul foundFour=%i", i,foundFour);
                NSString *query = [NSString stringWithFormat:@"https://graph.facebook.com/v2.1/%@/photos?access_token=%@",self.albumIds[i],FACEBOOK_ACCESS_TOKEN];
                NSURLSessionDataTask *imageIDdataTask = [[[self class] session] dataTaskWithURL:[NSURL URLWithString:query] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (error) {
                        NSLog(@"error=%@",error);
                    }
                    NSError *jsonImgErr;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonImgErr];
                    if(jsonImgErr) {
                        NSLog(@"JSON img error = %@", error);
                        return;
                    }
                    
                    NSArray *albumItems = [json objectForKey:@"data"];
                    if([albumItems count] != 0) {
                        NSMutableArray *albumItemsMutable = [albumItems mutableCopy];
                        [albumItemsMutable shuffle];
                        [self.imgIds addObject:[albumItemsMutable[0] objectForKey:@"id"]];
                    }
                    if ([self.imgIds count] == 4) {
                        NSLog(@"show pictures");
                        foundFour = true;
                        [self showFourFacebookPictures];
                    }
                    dispatch_semaphore_signal(semaphore);
                    
                }];
                [imageIDdataTask resume];
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            }
        }];
    }];
    [dataTask resume];
}


-(void) showFourFacebookPictures {
    
    for(int i = 0; i < 4; i++) {
        
        NSString *query = [NSString stringWithFormat:@"https://graph.facebook.com/v2.1/%@/picture?access_token=%@",self.imgIds[i],FACEBOOK_ACCESS_TOKEN];
        Images *fourImages = [Images sharedInstance];
        NSURLSessionDataTask *imagedataTask = [[[self class] session] dataTaskWithURL:[NSURL URLWithString:query] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
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

            });
        }];
        [imagedataTask resume];
    }
}




@end
