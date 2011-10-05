

#import "SwitchViewController.h"
#import "NewsFeedsViewController.h"
#import "BrowserViewController.h"

@implementation SwitchViewController

@synthesize newsController;
@synthesize browserController;
@synthesize urlToLoad;

-(IBAction)switchViews:(id)sender{
	if(self.browserController == nil)   //initalize the web view screen
	{
		BrowserViewController *tempController =[[BrowserViewController alloc] initWithNibName:@"Browser" bundle:nil];
		self.browserController = tempController;
		[tempController release];
	}
	[UIView beginAnimations:@"View Flip" context:nil];       ///code for animations
	[UIView setAnimationDuration:1.25];
	// next control speed at begin and end of animation
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	UIViewController *coming = nil;
	UIViewController *going = nil;
	UIViewAnimationTransition transition;
	
	
	
	
	//check if not news View
	if(self.newsController.view.superview == nil)       //switch to newscontroller view
	{
		coming=newsController;
		going=browserController;
		transition=UIViewAnimationTransitionFlipFromLeft;
		[browserController.view removeFromSuperview];  
		[self.view insertSubview:newsController.view atIndex:0];
	}
	else
	{													//otherwise switch to webview
		coming=browserController;
		going=newsController;
		transition=UIViewAnimationTransitionFlipFromRight;
		[newsController.view removeFromSuperview];
		[self.view insertSubview:browserController.view atIndex:0];
		if (newsController.urlToBeLoaded!=nil) {
			[self saveText:newsController.urlToBeLoaded];
		[browserController LoadRequestedURL:newsController.urlToBeLoaded];
		}
		
	}	
		[UIView setAnimationTransition:transition forView:self.view cache: YES];    //code to complete animation
		[coming viewWillAppear:YES];
		[going viewWillDisappear:YES];
		[going.view removeFromSuperview];
		[self.view insertSubview:coming.view atIndex:0];
		[going viewDidDisappear:YES];
		[coming viewDidAppear:YES];
		[UIView commitAnimations];
}


- (void)saveText:(NSString*) data      //function to handle persistance: save view url to file
{
	NSFileManager *filemgr;
	NSString *dataFile;
	NSString *docsDir;
	NSArray *dirPaths;
	filemgr = [NSFileManager defaultManager];
	
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	docsDir = [dirPaths objectAtIndex:0];
	
	dataFile = [docsDir stringByAppendingPathComponent: @"datafile.txt"];
	if([filemgr fileExistsAtPath:dataFile]){
		[filemgr removeItemAtPath:dataFile error:nil];
	}
	[filemgr createFileAtPath: dataFile contents:[NSString stringWithString:data] attributes:nil];
	[filemgr release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {         //initialize newsview at the start of application
	NewsFeedsViewController* tempViewController=[[NewsFeedsViewController alloc] initWithNibName:@"NewsFeeds" bundle:nil];
	tempViewController.parent=self;
	self.newsController=tempViewController;
	[self.view insertSubview:(UIView *)tempViewController.view atIndex:0];
	[tempViewController release];
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[newsController release];
	[browserController release];
    [super dealloc];
}


@end
