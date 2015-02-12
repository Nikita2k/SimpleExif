//
//  ViewController.m
//  ExifDemo
//
//  Created by Nikita Tuk on 02/02/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "ViewController.h"
#import <SimpleExif/ExifContainer.h>
#import <SimpleExif/UIImage+Exif.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () < CLLocationManagerDelegate >

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // start location manager to receive first location
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // request location (ios8+)
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        NSAssert([[[NSBundle mainBundle] infoDictionary] valueForKey:@"NSLocationWhenInUseUsageDescription"],
                 @"For iOS 8 and above, your app must have a value for NSLocationWhenInUseUsageDescription in its Info.plist");
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    // create container for exif data
    ExifContainer *container = [[ExifContainer alloc] init];
    
    // add a comment
    [container addUserComment:@"A long time ago, in a galaxy far, far away"];
    
    // with some date in past (not really long ago)
    [container addCreationDate:[NSDate dateWithTimeIntervalSinceNow:-10000000]];
    
    // and your location
    [container addLocation:locations[0]];
    
    // add exif data to image
    NSData *imageData = [[UIImage imageNamed:@"DemoImage"] addExif:container];
    
    NSString *imagePath = [self saveImageDataToDocuments:imageData];
    NSLog(@"saved image path: %@", imagePath);
    
    // we use location only for demo purpose, so 1 location is enough
    [manager stopUpdatingLocation];
    
}

- (NSString *)saveImageDataToDocuments:(NSData *)data {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.jpg"];
    [data writeToFile:savedImagePath atomically:NO];
    
    return savedImagePath;
    
}

@end
