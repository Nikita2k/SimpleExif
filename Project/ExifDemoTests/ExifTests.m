//
//  ExifDemoTests.m
//  ExifDemoTests
//
//  Created by Nikita Tuk on 02/02/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SimpleExif/ExifContainer.h>
#import <ImageIO/ImageIO.h>

@interface ExifTests : XCTestCase
@property (nonatomic, strong) ExifContainer *exifData;
@end

@implementation ExifTests

- (void)setUp {
    
    [super setUp];
    
    self.exifData = [[ExifContainer alloc] init];
    
}

- (void)testContainerShouldPersistUserComments {

    NSString *userComment = @"SampleComment";
    [self.exifData addUserComment:userComment];
    
    NSDictionary *exifDictionary = self.exifData.exifData[(NSString *)kCGImagePropertyExifDictionary];
    NSString *persistedComment = exifDictionary[(NSString *)kCGImagePropertyExifUserComment];
    
    XCTAssertEqualObjects(userComment, persistedComment, @"User comment is not persisted");
    
}

- (void)testContainerShouldPersistCreationDate {
    
    NSDate *originalDate = [NSDate date];
    [self.exifData addCreationDate:originalDate];
    
    NSDictionary *exifDictionary = self.exifData.exifData[(NSString *)kCGImagePropertyExifDictionary];
    NSString *persistedDateString = exifDictionary[(NSString *)kCGImagePropertyExifDateTimeOriginal];
    NSString *originalDateString = [self getUTCFormattedDate:originalDate];
    
    XCTAssertEqualObjects(originalDateString, persistedDateString, @"Creation date is not persisted");
    
}

- (void)testContainerShouldPersistDescription {
    
    NSString *userDescription = @"userDescription";
    [self.exifData addDescription:userDescription];
    
    NSDictionary *exifDictionary = self.exifData.exifData[(NSString *)kCGImagePropertyTIFFDictionary];
    NSString *persistedDescription = exifDictionary[(NSString *)kCGImagePropertyTIFFImageDescription];
    
    XCTAssertEqualObjects(userDescription, persistedDescription, @"Description is not persisted");
    
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
