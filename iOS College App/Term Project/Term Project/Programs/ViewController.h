

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, NSXMLParserDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageData;
@property NSUInteger startIndex;
@property(strong, nonatomic) NSMutableString *currentNodeContent;
@property (strong, nonatomic) NSMutableArray *week;
@property (strong, nonatomic) NSMutableArray *day;
@property (strong, nonatomic) NSData *xmlData2;

@end
