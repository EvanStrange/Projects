

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSMutableString *eventType;
@property (strong, nonatomic) NSString *eventDate;
@property (strong, nonatomic) NSMutableString *eventDescriptions;

@end

