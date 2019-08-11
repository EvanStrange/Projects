

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsTableViewController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSData *newsData;
@property (strong, nonatomic) NSMutableArray *news;
@property (strong, nonatomic) NSXMLParser *newsParser;
@property (strong, nonatomic) NSMutableString *currentNodeContent;
@property (strong, nonatomic) News *currentNews;

@property (strong, nonatomic) UIImage *newsImage;
@property (strong,nonatomic) NSString *newsImageName;
@property (strong,nonatomic) NSString *newsTitle;
@property (strong,nonatomic) NSString *newsText;
@property (strong,nonatomic) NSString *newsDate;
@property (strong,nonatomic) NSString *newsDescription;

@end

