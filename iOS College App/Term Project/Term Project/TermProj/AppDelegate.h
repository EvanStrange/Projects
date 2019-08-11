

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSData *data;
@property (nonatomic) Reachability *reach;
@property (nonatomic) BOOL networkIsReachable;
@property (nonatomic) BOOL networkIsReachableWiFi;
@property (nonatomic) BOOL networkIsReachableWWAN;

@property (nonatomic) BOOL failed;

@end

