//
//  DataCollectorsViewController.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "DataCollectorsViewController.h"
#import "CPeripheralManager.h"
#import "RemoteDataCollector.h"

static NSString * const STOP_CAPTURE_TEXT = @"Stop Capture";
static NSString * const START_CAPTURE_TEXT = @"Start Capture";

@interface DataCollectorsViewController () <UITableViewDelegate, UITableViewDataSource, RemoteDataCollectionDelegate>

	@property (weak, nonatomic) IBOutlet UITableView *connectedDataCollectorsStatusTableView;
	@property(nonatomic, strong) NSMutableDictionary * centralToDataCollectorMap;
	@property(nonatomic, strong) NSMutableArray * connectedCentrals;

@end

@implementation DataCollectorsViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.connectedCentrals = [NSMutableArray array];
	self.centralToDataCollectorMap = [NSMutableDictionary dictionary];
	[[CPeripheralManager thePeripheralManager] addRemoteDataCollectionDelegate:self];
}

- (IBAction)startCapture:(UIButton *)sender
{
	NSArray * stoppedRemoteDataCollectors = [self.centralToDataCollectorMap.allValues filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isCollecting == FALSE"]];
	NSArray * stoppedCentrals = [stoppedRemoteDataCollectors valueForKeyPath:@"@unionOfObjects.central"];
	[[CPeripheralManager thePeripheralManager] startDataCapture: stoppedCentrals];
}

-(IBAction)stopCapture:(UIButton*) sender
{
	NSArray * startedRemoteDataCollectors = [self.centralToDataCollectorMap.allValues filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isCollecting == TRUE"]];
	NSArray * startedCentrals = [startedRemoteDataCollectors valueForKeyPath:@"@unionOfObjects.central"];
	[[CPeripheralManager thePeripheralManager] stopDataCapture: startedCentrals];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.connectedCentrals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DataCollectorStatusCell"];

	CBCentral * central = [self.connectedCentrals objectAtIndex:indexPath.row];
	RemoteDataCollector * dataCollector = [self.centralToDataCollectorMap objectForKey:central.identifier.UUIDString];

	cell.textLabel.text = dataCollector.identifier;
	cell.detailTextLabel.text = dataCollector.isCollecting ? @"Collecting..." : @"Stopped";

	return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"Tapped");
}

#pragma mark - RemoteDataCollectionDelegate

-(void)centralDidSubscribeForRemoteDataCollection:(CBCentral *)central
{
	[self.connectedCentrals addObject:central];
	[self.centralToDataCollectorMap setObject:[RemoteDataCollector remoteDataCollectorAtCentral:central] forKey:central.identifier.UUIDString];
	[self.connectedDataCollectorsStatusTableView reloadData];
}

-(void)centralDidUnsubscribeForRemoteDataCollection:(CBCentral *)central
{
	[self.connectedCentrals removeObject:central];
	[self.centralToDataCollectorMap removeObjectForKey:central.identifier.UUIDString];
	[self.connectedDataCollectorsStatusTableView reloadData];
}

-(void)central:(CBCentral *)central didReportIdentifier:(NSString *)identifier
{
	RemoteDataCollector * collector = [self.centralToDataCollectorMap objectForKey:central.identifier.UUIDString];
	collector.identifier = identifier;
	[self.connectedDataCollectorsStatusTableView reloadData];
}

-(void)central:(CBCentral *)central didUpdateDataCollectorStatus :(BOOL)isCollecting
{
	RemoteDataCollector * collector = [self.centralToDataCollectorMap objectForKey:central.identifier.UUIDString];
	collector.isCollecting = isCollecting;

	[self.connectedDataCollectorsStatusTableView reloadData];
}

@end
