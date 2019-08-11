

#import <UIKit/UIKit.h>
#import "Event.h"
#import <UIKit/UIView.h>
#import <sqlite3.h>


@interface CreateEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *stringDate;

@property (weak, nonatomic) IBOutlet UITextField *editType;
@property (weak, nonatomic) IBOutlet UITextField *editDescription;
@property (weak, nonatomic) IBOutlet UILabel *status;


@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end

