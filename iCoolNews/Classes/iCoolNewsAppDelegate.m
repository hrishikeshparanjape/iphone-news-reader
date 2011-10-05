
#import <sqlite3.h>
#import "iCoolNewsAppDelegate.h"
#import "SwitchViewController.h"

@implementation iCoolNewsAppDelegate

@synthesize window;
@synthesize switchViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	[window addSubview:switchViewController.view];    //first screen of the app
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
	[switchViewController release];
    [super dealloc];
}

@end
