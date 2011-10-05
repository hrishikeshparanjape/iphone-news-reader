

#import <UIKit/UIKit.h>
@class NewsFeedsViewController;
@class BrowserViewController;

@interface SwitchViewController : UIViewController {
	NewsFeedsViewController* newsController;      //news view where user will search for news
	BrowserViewController* browserController;		//webview
	NSString* urlToLoad;
}
@property(retain,nonatomic)NewsFeedsViewController* newsController;
@property(retain,nonatomic)BrowserViewController* browserController;
@property(retain,nonatomic)NSString* urlToLoad;
-(IBAction)switchViews:(id)sender;
- (void)saveText:(NSString*) data;
@end