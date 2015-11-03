//
//  DataCollectorsViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "DataCollectorsViewController.h"
#import "CPeripheralManager.h"

static NSString * const STOP_ADVERTISING_TEXT = @"Stop Advertising";
static NSString * const START_ADVERTISING_TEXT = @"Start Advertising";

static NSString * const STOP_CAPTURE_TEXT = @"Stop Capture";
static NSString * const START_CAPTURE_TEXT = @"Start Capture";

@interface DataCollectorsViewController () <UITableViewDelegate, UITableViewDataSource, RemoteDataCollectionDelegate>

	-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop;//TRUE = Start  FALSE = Stop
	-(IBAction)onAdvertise:(UIButton *)sender;

	@property (weak, nonatomic) IBOutlet UITableView *connectedDataCollectorsStatusTableView;
	@property(nonatomic, strong) NSMutableArray * connectedDataCollectors;

@end

@implementation DataCollectorsViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.connectedDataCollectors = [NSMutableArray array];
	[[CPeripheralManager thePeripheralManager] addRemoteDataCollectionDelegate:self];
}

-(IBAction)onAdvertise:(UIButton *)sender
{
	NSLog(@"%@", [sender titleColorForState:UIControlStateNormal]);
	if([sender.currentTitle compare:START_ADVERTISING_TEXT] == NSOrderedSame)//Starting advertising
	{
		[[CPeripheralManager thePeripheralManager] advertiseTheServices];
		[sender setTitle:STOP_ADVERTISING_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:sender isStart:TRUE];
	}
	else if([sender.currentTitle compare:STOP_ADVERTISING_TEXT] == NSOrderedSame)
	{
		[[CPeripheralManager thePeripheralManager] stopAdvertisingTheServices];
		[sender setTitle:START_ADVERTISING_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:sender isStart:FALSE];
	}
}
- (IBAction)onCapture:(UIButton *)sender
{
	if ([sender.currentTitle isEqualToString:START_CAPTURE_TEXT])
	{
		[[CPeripheralManager thePeripheralManager] startDataCapture];
		[sender setTitle:STOP_CAPTURE_TEXT forState:UIControlStateNormal];

		[self configureButtonBackGround:sender isStart:TRUE];
	}
	else if ([sender.currentTitle isEqualToString:STOP_CAPTURE_TEXT])
	{
		[[CPeripheralManager thePeripheralManager] stopDataCapture];
		[sender setTitle:START_CAPTURE_TEXT forState:UIControlStateNormal];
		[self configureButtonBackGround:sender isStart:FALSE];
	}
}

-(void)configureButtonBackGround:(UIButton *)btn isStart:(BOOL)bIsStartOrStop
{
	UIColor * tintColor = (bIsStartOrStop) ? [UIColor redColor] : nil;
	[btn setTintColor:tintColor];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.connectedDataCollectors.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DataCollectorStatusCell"];

	CBCentral * central = [self.connectedDataCollectors objectAtIndex:indexPath.row];

	cell.textLabel.text = central.identifier.UUIDString;

	return cell;
}

#pragma mark - RemoteDataCollectionDelegate

-(void)centralDidSubscribeForRemoteDataCollection:(CBCentral *)central
{
	[self.connectedDataCollectors addObject:central];
	[self.connectedDataCollectorsStatusTableView reloadData];
}

-(void)centralDidUnsubscribeForRemoteDataCollection:(CBCentral *)central
{
	[self.connectedDataCollectors removeObject:central];
	[self.connectedDataCollectorsStatusTableView reloadData];
}

@end
