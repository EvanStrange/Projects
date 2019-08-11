

#import <UIKit/UIKit.h>

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateNumber;
@property (strong, nonatomic) IBOutlet UILabel *event;
@property BOOL hasEvent;

@end

