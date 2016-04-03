//
//  ExifContainer.m
//  Pods
//
//  Created by Nikita Tuk on 02/02/15.
//
//

#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
#import "ExifContainer.h"

@interface ExifContainer ()

@property (nonatomic, strong) NSMutableDictionary *imageMetadata;

@property (nonatomic, strong, readonly) NSMutableDictionary *exifDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary *tiffDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary *gpsDictionary;
@end

@implementation ExifContainer

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _imageMetadata = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}

- (void)addLocation:(CLLocation *)currentLocation {
    
    CLLocationDegrees latitude  = currentLocation.coordinate.latitude;
    CLLocationDegrees longitude = currentLocation.coordinate.longitude;
    
    NSString *latitudeRef = nil;
    NSString *longitudeRef = nil;
    
    if (latitude < 0.0) {
        
        latitude *= -1;
        latitudeRef = @"S";
        
    } else {
        
        latitudeRef = @"N";
        
    }
    
    if (longitude < 0.0) {
        
        longitude *= -1;
        longitudeRef = @"W";
        
    } else {
        
        longitudeRef = @"E";
        
    }
    
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSTimeStamp] = [self getUTCFormattedDate:currentLocation.timestamp];
    
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLatitudeRef] = latitudeRef;
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLatitude] = [NSNumber numberWithFloat:latitude];

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLongitudeRef] = longitudeRef;
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLongitude] = [NSNumber numberWithFloat:longitude];

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSDOP] = [NSNumber numberWithFloat:currentLocation.horizontalAccuracy];
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSAltitude] = [NSNumber numberWithFloat:currentLocation.altitude];
    
}

- (void)addUserComment:(NSString*)comment {
    
    [self.exifDictionary setObject:comment forKey:(NSString*)kCGImagePropertyExifUserComment];
    
}

- (void)addDigitizedDate:(NSDate *)date {

    NSString *dateString = [self getUTCFormattedDate:date];
    [self.exifDictionary setObject:dateString forKey:(NSString*)kCGImagePropertyExifDateTimeDigitized];
}

- (void)addCreationDate:(NSDate *)date {
    
    NSString *dateString = [self getUTCFormattedDate:date];
    [self.exifDictionary setObject:dateString forKey:(NSString*)kCGImagePropertyExifDateTimeOriginal];

}

- (void)addDescription:(NSString*)description {
    
    [self.tiffDictionary setObject:description forKey:(NSString *)kCGImagePropertyTIFFImageDescription];
    
}

- (NSDictionary *)exifData {
    
    return self.imageMetadata;
    
}

#pragma mark - Getters

- (NSMutableDictionary *)exifDictionary {
    
    return [self dictionaryForKey:(NSString*)kCGImagePropertyExifDictionary];
    
}

- (NSMutableDictionary *)tiffDictionary {
    
    return [self dictionaryForKey:(NSString*)kCGImagePropertyTIFFDictionary];
    
}

- (NSMutableDictionary *)gpsDictionary {
    
    return [self dictionaryForKey:(NSString*)kCGImagePropertyGPSDictionary];
    
}

- (NSMutableDictionary *)dictionaryForKey:(NSString *)key {
    
    NSMutableDictionary *dict = self.imageMetadata[key];
    
    if (!dict) {
        
        dict = [[NSMutableDictionary alloc] init];
        self.imageMetadata[key] = dict;
        
    }
    
    return dict;
    
}

#pragma mark - Helpers

- (NSString *)getUTCFormattedDate:(NSDate *)localDate {
    
    static NSDateFormatter *dateFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
        
    });

    
    return [dateFormatter stringFromDate:localDate];

}

@end
