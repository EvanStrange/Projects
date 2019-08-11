//
//  EventViewController.h
//  Calendar
//
//  Created by Branko Cirovic on 2018-01-22.
//  Copyright © 2018 Branko Cirovic. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "Event.h"


@interface EventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *stringDate;

@property (weak, nonatomic) IBOutlet UILabel *type1;
@property (weak, nonatomic) IBOutlet UILabel *descriptions1;
@property (strong, nonatomic) NSString *eventVType;
@property (strong, nonatomic) NSString *eventVDescriptions;


@end

