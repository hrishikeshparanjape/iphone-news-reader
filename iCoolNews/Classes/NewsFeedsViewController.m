

#import "NewsFeedsViewController.h"
#import "SwitchViewController.h"
#import "BrowserViewController.h"

@implementation NewsFeedsViewController

@synthesize goButton;
@synthesize SearchBox;
@synthesize feedsTable;
@synthesize currentURLName;
@synthesize tableURLs;
@synthesize listData;
@synthesize currentelement;
@synthesize parent;
@synthesize urlToBeLoaded;
@synthesize loadpage;

-(IBAction) fillTableCellsWithLinks:(id)sender{
	[tableURLs removeAllObjects];               //remove all objects from array at the start of procedure
	
	/*URL is divided in 3 parts, 1st part before searc string, 2nd part is search string and third part as part next to search string*/
	
	NSString* SecondPartOfURL=[NSString stringWithString:SearchBox.text];
	SecondPartOfURL=[SecondPartOfURL stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	NSString* FirstPartOfURL=[NSString stringWithString:@"http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=8Vf_mi3V34GOdc0PKOF6jQ60XH1YePBxiJbdxU_zIo45fgg.E7RKfMDOLNeeHH5z9skcycDqvxHl&query="];
	NSString* ThirdPartOfURL=[NSString stringWithString:@"&results=5&language=en"];
	NSString* urlString=[NSString stringWithFormat:@"%@%@%@",FirstPartOfURL,SecondPartOfURL,ThirdPartOfURL];
	
	NSURL* yahoonews=[NSURL URLWithString:urlString];
	NSData* myData=[NSData dataWithContentsOfURL:yahoonews];//data returned by yahoo api is in ml format
	NSXMLParser* p=[[NSXMLParser alloc] initWithData:myData];  // parse xml file
	[p setDelegate:self];
	[p parse];
	[p release];
	[feedsTable setDataSource:self];              
	[feedsTable reloadData];     // refresh the table view i.e. list of feeds
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	//the parser started this document. what are you going to do?
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	//the parser found an XML tag and is giving you some information about it
	//what are you going to do?
	currentelement = [elementName copy];
	[elementName release];
	
	if ([elementName isEqualToString:@"Url"]){
		currentURLName = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//the parser found some characters inbetween an opening and closing tag
	//what are you going to do?
	NSString *temp=[NSString stringWithString:currentelement];
		if ([temp isEqualToString:@"Url"]) {
		[currentURLName appendString:string];
		}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	  if ([elementName isEqualToString:@"Url"]) {
		  [tableURLs addObject:[NSString stringWithString:currentURLName]];
		  [currentURLName release];
	  }	  
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//the parser finished. what are you going to do?
}
 

-(IBAction)KBReturnHit:(id)sender{
	[sender resignFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	tableURLs=[[NSMutableArray alloc] init];
	[super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
  //  return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	//[tableURLs dealloc];
  [super dealloc];
}
#pragma mark -
#pragma mark Table View Controller Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //returns no. of cells to be displayed
	return [tableURLs count];
}


-(UITableViewCell *)tableView: (UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath              //draw cells
{
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
	UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
									   reuseIdentifier: SimpleTableIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	
	cell.textLabel.text = [tableURLs objectAtIndex:row];
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {///select row action
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	urlToBeLoaded=[NSString stringWithString:cell.textLabel.text];
	[self.parent switchViews:nil];
}

@end