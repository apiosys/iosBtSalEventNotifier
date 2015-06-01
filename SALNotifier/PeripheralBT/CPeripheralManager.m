/*
//  CPeripheralManager.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CPeripheralManager.h"
#import "CEventNotificationService.h"

@interface CPeripheralManager()
	@property(nonatomic, strong) NSMutableArray *arrServices;//These are CEventNotificationService objects
	@property(nonatomic, strong) CBPeripheralManager *nativePeripheralManager;
	@property(nonatomic, strong) CEventNotificationService *notificationService;

	-(id)initPeripheralManager;
@end

@implementation CPeripheralManager

@synthesize arrServices = _arrServices;
@synthesize notificationService = _notificationService;
@synthesize nativePeripheralManager = _nativePeripheralManager;

+(CPeripheralManager *)thePeripheralManager
{
	static CPeripheralManager *peripheralManager = nil;

	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		peripheralManager = [[CPeripheralManager alloc] initPeripheralManager];
	});
	
	return peripheralManager;
}

-(id)init
{
	[NSException raise:@"Invalid Init Called" format:@"The \"init\" method isn't allowed on the \"CPeripheralManager\" object"];
	return nil;
}

-(id)initPeripheralManager
{
	self = [super init];

	if(self == nil)
		return self;

	if(self.nativePeripheralManager == nil)
		self.nativePeripheralManager= [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];

	if(self.arrServices == nil)
		self.arrServices = [[NSMutableArray alloc]init];

	if(self.notificationService == nil)
		self.notificationService = [[CEventNotificationService alloc]init];

	return self;
}

-(void)advertiseTheServices
{
	NSArray *arrServiceUUIDsToAdvertise = [NSArray arrayWithObjects:[CBUUID UUIDWithString:self.notificationService.strServiceUUID], nil];

	NSDictionary *advertisingDict = [NSDictionary dictionaryWithObject:arrServiceUUIDsToAdvertise forKey:CBAdvertisementDataServiceUUIDsKey];

	[self.nativePeripheralManager startAdvertising:advertisingDict];
}

-(void)stopAdvertisingTheServices
{
	[self.nativePeripheralManager stopAdvertising];
}

-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal
{
	[self.notificationService updateServiceValue:eNotificationVal thePeripheralManager:self.nativePeripheralManager];
}

-(void)updateServiceValueWithMessage:(NSString *)messageNotificationVal
{
	[self.notificationService updateServiceMessageValue:messageNotificationVal thePeripheralManager:self.nativePeripheralManager];
}

#pragma mark - Peripheral manager delegate calls

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheralManager
{
	if(peripheralManager != self.nativePeripheralManager)
		NSLog(@"Strange");

	switch (peripheralManager.state)
	{
		case CBPeripheralManagerStateUnknown:
			NSLog(@"Unknown State");
			break;
		case CBPeripheralManagerStateResetting:
			NSLog(@"Resettting State");
			break;
		case CBPeripheralManagerStateUnsupported:
			NSLog(@"Unsupported State");
			break;
		case CBPeripheralManagerStateUnauthorized:
			NSLog(@"Unauthorized State");
			break;
		case CBPeripheralManagerStatePoweredOff:
			NSLog(@"Power Off State");
			break;
		case CBPeripheralManagerStatePoweredOn:
			[self.nativePeripheralManager addService:self.notificationService.theNotificationService];//Publishes the service. Does NOT advertise!!!
			break;
		default:
			break;
	}

	NSLog(@"Peripheral Delegate");
}

//Callback for connection.
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
	//Look for data
	
	//Send chunk: 20 bytes
	
//	[self.nativePeripheralManager updateValue:@"" forCharacteristic:self.serviceCharacteristics onSubscribedCentrals:nil];//Send to central
	
	//Send EOM
	//NSData *eom = [@"ENDVAL" dataUsingEncoding:NSUTF8StringEncoding];
	
	//if(eom == nil)
	//	return;
	
	//[self.nativePeripheralManager updateValue:eom forCharacteristic:self.serviceCharacteristic onSubscribedCentrals:nil];
}

@end
