

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dataTable;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) NSArray *hours;

@end

