

#import <UIKit/UIKit.h>
@class SwitchViewController;
@class BrowserViewController;

@interface NewsFeedsViewController : UIViewController<UITableViewDataSource> {
	IBOutlet UITextField* SearchBox;
	IBOutlet UIButton* goButton;
	IBOutlet UITableView* feedsTable;
	NSMutableString* currentURLName;
	NSString* currentelement;
	NSMutableArray* tableURLs;
	NSArray* listData;
	SwitchViewController* parent;
	BrowserViewController* loadpage;
	NSString* urlToBeLoaded;
}

@property (nonatomic,retain) UITextField* SearchBox;
@property(nonatomic,retain) UIButton* goButton;
@property(nonatomic,retain) UITableView* feedsTable;
@property(nonatomic,retain) NSMutableString* currentURLName;
@property(nonatomic,retain) NSMutableArray* tableURLs;
@property(nonatomic,retain) NSString* currentelement;
@property(nonatomic,retain) NSArray* listData;
@property(nonatomic,retain) SwitchViewController* parent;
@property(nonatomic,retain) 	NSString* urlToBeLoaded;
@property(nonatomic,retain)	BrowserViewController* loadpage;


-(IBAction) fillTableCellsWithLinks:(id)sender;
-(IBAction)KBReturnHit:(id)sender;
- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

- (void)parserDidEndDocument:(NSXMLParser *)parser;
-(UITableViewCell *)tableView: (UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
