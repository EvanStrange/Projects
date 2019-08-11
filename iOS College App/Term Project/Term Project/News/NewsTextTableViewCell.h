

#import <UIKit/UIKit.h>

@interface NewsTextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;
@property (weak, nonatomic) IBOutlet UITextView *newsText;

@end

