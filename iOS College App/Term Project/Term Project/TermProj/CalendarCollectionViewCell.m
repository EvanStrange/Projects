

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _event.backgroundColor = [UIColor clearColor];
    _event.textColor = [UIColor blackColor];
    _dateNumber.backgroundColor = [UIColor clearColor];
    _dateNumber.textColor = [UIColor blackColor];
    _hasEvent = NO;
}

@end

