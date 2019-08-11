
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface News : NSObject

@property (strong, nonatomic) UIImage *newsImage;
@property (strong, nonatomic) NSString *newsImageUrl;
@property (strong, nonatomic) NSString *newsTitle;
@property (strong, nonatomic) NSString *newsDate;
@property (strong, nonatomic) NSString *newsDescription;

@end

