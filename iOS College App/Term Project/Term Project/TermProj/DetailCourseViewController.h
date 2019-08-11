

#import <UIKit/UIKit.h>

@interface DetailCourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *cname;
@property (strong, nonatomic) NSString *cid;
@property (strong, nonatomic) NSString *credit;
@property (strong, nonatomic) NSString *lect;
@property (strong, nonatomic) NSString *lab;

@end

