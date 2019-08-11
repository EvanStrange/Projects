

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <WKNavigationDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

