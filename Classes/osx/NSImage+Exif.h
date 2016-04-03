//
//  UIImage+Exif.h
//  Pods
//
//  Created by Nikita Tuk on 12/02/15.
//
//

#import <Cocoa/Cocoa.h>

@class ExifContainer;

@interface NSImage (Exif)

+ (NSData *)getAppendedDataForImageData:(NSData *)imageData exif:(ExifContainer *)container;

@end
