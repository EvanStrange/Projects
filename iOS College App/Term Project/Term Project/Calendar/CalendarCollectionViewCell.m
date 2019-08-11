//
//  CalendarCollectionViewCell.m
//  Calendar
//
//  Created by Branko on 2018-01-19.
//  Copyright © 2018 Branko Cirovic. All rights reserved.
//

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
