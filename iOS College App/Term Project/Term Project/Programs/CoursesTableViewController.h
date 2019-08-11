

#import <UIKit/UIKit.h>
#import "Course.h"
#import "Semester.h"

@interface CoursesTableViewController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSString *programNameText;
@property (strong, nonatomic) NSString *imageName;

@property(strong, nonatomic) NSString *urlData;
@property (strong, nonatomic) NSData *xmlData;
@property(strong, nonatomic) NSMutableArray *semesters;
@property(strong, nonatomic) NSMutableArray *courses;
@property(strong, nonatomic) Semester *currentSemester;
@property(strong, nonatomic) Course *currentCourse;
@property(strong, nonatomic) NSMutableString *currentNodeContent;

@end

