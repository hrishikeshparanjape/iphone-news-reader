#import <UIKit/UIKit.h>

@class SwitchViewController;

@interface iCoolNewsAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet SwitchViewController* switchViewController;    //this is will control switching of views
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SwitchViewController* switchViewController;

@end

