

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ContactsTableViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property(nonatomic) Reachability *reach;
@property BOOL networkIsReachable;

@end

