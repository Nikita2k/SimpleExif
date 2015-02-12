//
//  UIImage+Exif.m
//  Pods
//
//  Created by Nikita Tuk on 12/02/15.
//
//

#import <ImageIO/ImageIO.h>
#import "UIImage+Exif.h"
#import "ExifContainer.h"

@implementation UIImage (Exif)

- (NSData *)addExif:(ExifContainer *)container {
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0f);
    
    // create an imagesourceref
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef) imageData, NULL);
    
    // this is the type of image (e.g., public.jpeg)
    CFStringRef UTI = CGImageSourceGetType(source);
    
    // create a new data object and write the new image into it
    NSMutableData *dest_data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data, UTI, 1, NULL);
    
    if (!destination) {
        NSLog(@"Error: Could not create image destination");
    }
    
    // add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef) container.exifData);
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);
    
    if (!success) {
        NSLog(@"Error: Could not create data from image destination");
    }
    
    CFRelease(destination);
    CFRelease(source);
    
    return dest_data;
    
}

@end
