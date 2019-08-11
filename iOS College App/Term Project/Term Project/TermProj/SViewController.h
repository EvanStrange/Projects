

#import <UIKit/UIKit.h>

@interface SViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIStackView *topStack;
@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *firstDate;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, strong) NSDate *date;
@property NSInteger initialSection;

- (IBAction)todayButton:(id)sender;

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSDate *selectedDate;

@end
