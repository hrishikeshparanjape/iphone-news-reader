

#import <UIKit/UIKit.h>


@interface BrowserViewController : UIViewController {
	IBOutlet UIWebView* webBrowserView;
}
@property (retain,nonatomic)UIWebView* webBrowserView;

-(void) LoadRequestedURL:(NSString *)urlstring;
@end
