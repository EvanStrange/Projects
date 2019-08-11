//
//  Event.h
//  CALENDAR
//
//  Created by Evan Strange
//  Copyright © 2019 Evan Strange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSMutableString *eventType;
@property (strong, nonatomic) NSString *eventDate;
@property (strong, nonatomic) NSMutableString *eventDescriptions;

@end
