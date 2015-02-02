#import <Foundation/Foundation.h>

@interface Test : NSObject

@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSDate *expired;

@end