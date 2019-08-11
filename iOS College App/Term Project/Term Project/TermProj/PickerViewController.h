

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)getSchedule:(id)sender;

@property (strong, nonatomic) NSArray *programs;
@property (strong, nonatomic) NSArray *years;
@property (strong, nonatomic) NSString *xmlUrl;
@property (strong, nonatomic) NSData *xmlData;

@end

