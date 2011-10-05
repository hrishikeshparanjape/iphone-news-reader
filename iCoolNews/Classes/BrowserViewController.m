

#import "BrowserViewController.h"

@implementation BrowserViewController
@synthesize webBrowserView;

-(void) LoadRequestedURL:(NSString *)urlstring{
	NSURL* url=[NSURL URLWithString:urlstring];
	NSURLRequest* request=[NSURLRequest requestWithURL:url];
	[webBrowserView loadRequest:request];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSFileManager *filemgr;
	NSString *dataFile;
	NSString *docsDir;
	NSArray *dirPaths;
	
	filemgr = [NSFileManager defaultManager];
	
	// Identify the documents directory
	dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	docsDir = [dirPaths objectAtIndex:0];
	
	// Build the path to the data file
	dataFile = [docsDir stringByAppendingPathComponent: @"datafile.txt"];
	
	// Check if the file already exists
	if ([filemgr fileExistsAtPath: dataFile])
	{
		// Read file contents and display in textBox
		NSData *databuffer;
		databuffer = [filemgr contentsAtPath: dataFile];
		NSString *datastring = [[NSString alloc] initWithData: databuffer encoding:NSASCIIStringEncoding];
		NSURL* url=[NSURL URLWithString:datastring];
		NSURLRequest* request=[NSURLRequest requestWithURL:url];
		[webBrowserView loadRequest:request];
		[datastring release];
	}
	[filemgr release];
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
    [super dealloc];
}


@end
