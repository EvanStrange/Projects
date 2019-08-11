//
//  CalendarCollectionViewCell.h
//  Calendar
//
//  Created by Branko on 2018-01-19.
//  Copyright © 2018 Branko Cirovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateNumber;
@property (strong, nonatomic) IBOutlet UILabel *event;
@property BOOL hasEvent;

@end

