

#import <UIKit/UIKit.h>

@interface ProgramsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *programs;
@property (strong, nonatomic) NSArray *programsID;

@property(strong, nonatomic) NSString *pid;
@property(strong, nonatomic) NSString *pname;
@property(strong, nonatomic) NSString *imageName;

@property(strong, nonatomic) NSString *urlData;
@property(strong, nonatomic) NSData *xmlData;

@end

