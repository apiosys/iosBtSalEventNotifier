/*
//  CPeripheralManager.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CPeripheralManager.h"
#import "CEventNotificationService.h"
#import "CRemoteDataCollectionService.h"
#import "RemoteDataCollector.h"

@interface CPeripheralManager()
	@property(nonatomic, strong) CBPeripheralManager *nativePeripheralManager;
	@property(nonatomic, strong) CEventNotificationService *notificationService;
	@property(nonatomic, strong) CRemoteDataCollectionService * remoteDataCollectionService;
	@property(nonatomic, strong) NSMutableArray * remoteDataCollectionDelegates;

	-(id)initPeripheralManager;

	-(NSArray*) allPeripheralServices;
	-(NSArray*) allServiceUUIDs;
	-(void)registerServices:(NSArray*) services;

	-(void)notifyThatCentralDidSubscribeForRemoteDataCollection: (CBCentral*) central;
	-(void)notifyThatCentralDidUnsubscribeForRemoteDataCollection: (CBCentral*) central;
	-(void) notifyThatCentral:(CBCentral *)central reportedIdentifier:(NSString *)identifier;
	-(void) notifyThatCentral:(CBCentral *)central updatedDataCollectionStatus:(BOOL)isCollecting;

@end

@implementation CPeripheralManager

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

	if(self.notificationService == nil)
		self.notificationService = [[CEventNotificationService alloc] init];

	if (self.remoteDataCollectionService == nil)
		self.remoteDataCollectionService = [[CRemoteDataCollectionService alloc] init];

	return self;
}

-(NSArray*)allPeripheralServices
{
	return @[self.notificationService.service, self.remoteDataCollectionService.service];
}

-(NSArray*) allServiceUUIDs
{
	return @[ self.notificationService.service.UUID, self.remoteDataCollectionService.service.UUID ];
}

-(BOOL) isAdvertising
{
	return self.nativePeripheralManager.isAdvertising;
}

-(void)advertiseTheServices
{
	NSDictionary *advertisingDict = [NSDictionary dictionaryWithObject:[self allServiceUUIDs] forKey:CBAdvertisementDataServiceUUIDsKey];
	[self.nativePeripheralManager startAdvertising:advertisingDict];
}

-(void)stopAdvertisingTheServices
{
	[self.nativePeripheralManager stopAdvertising];
}

-(void)sendEventNotificationMessage:(NSString *)messageNotificationVal
{
	[self.notificationService sendEventNotificationMessage:messageNotificationVal UsingPeripheralManager:self.nativePeripheralManager];
}

-(void) registerServices: (NSArray*)services
{
	for (CBMutableService * service in services)
	{
		[self.nativePeripheralManager addService:service]; //Publishes the service. Does NOT advertise!!!
	}
}

#pragma mark - Remote Data Collection

-(NSArray *) allRemoteDataCollectionDelegates
{
	if (self.remoteDataCollectionDelegates == nil)
		return [NSArray array];

	return self.remoteDataCollectionDelegates;
}

-(void)addRemoteDataCollectionDelegate:(id<RemoteDataCollectionDelegate>)delegate
{
	if (self.remoteDataCollectionDelegates == nil)
		self.remoteDataCollectionDelegates = [NSMutableArray array];

	if (delegate != nil && [self.remoteDataCollectionDelegates containsObject:delegate] == FALSE)
		[self.remoteDataCollectionDelegates addObject:delegate];
}

-(void)removeRemoteDataCollectionDelegate:(id<RemoteDataCollectionDelegate>)delegate
{
	if (self.remoteDataCollectionDelegates != nil && delegate != nil)
		[self.remoteDataCollectionDelegates removeObject:delegate];
}

-(void)removeAllRemoteDataCollectionDelegates
{
	if (self.remoteDataCollectionDelegates != nil)
		[self.remoteDataCollectionDelegates removeAllObjects];
}

-(void)notifyThatCentralDidSubscribeForRemoteDataCollection:(CBCentral *)central
{
	for (id<RemoteDataCollectionDelegate> delegate in self.remoteDataCollectionDelegates)
	{
		if ([delegate respondsToSelector:@selector(centralDidSubscribeForRemoteDataCollection:)])
		{
			[delegate centralDidSubscribeForRemoteDataCollection:central];
		}
	}
}

-(void)notifyThatCentralDidUnsubscribeForRemoteDataCollection:(CBCentral *)central
{
	for (id<RemoteDataCollectionDelegate> delegate in self.remoteDataCollectionDelegates)
	{
		if ([delegate respondsToSelector:@selector(centralDidUnsubscribeForRemoteDataCollection:)])
		{
			[delegate centralDidUnsubscribeForRemoteDataCollection:central];
		}
	}
}

-(void) notifyThatCentral:(CBCentral *)central reportedIdentifier:(NSString *)identifier
{
	for (id<RemoteDataCollectionDelegate> delegate in self.remoteDataCollectionDelegates)
	{
		if ([delegate respondsToSelector:@selector(central:didReportIdentifier:)])
		{
			[delegate central:central didReportIdentifier:identifier];
		}
	}
}

-(void) notifyThatCentral:(CBCentral *)central updatedDataCollectionStatus:(BOOL)isCollecting
{
	for (id<RemoteDataCollectionDelegate> delegate in self.remoteDataCollectionDelegates)
	{
		if ([delegate respondsToSelector:@selector(central:didUpdateDataCollectorStatus:)])
		{
			[delegate central:central didUpdateDataCollectorStatus:isCollecting];
		}
	}
}



-(void)startDataCapture:(NSArray*) centrals
{
	[self.remoteDataCollectionService enableDataCapture:DATA_CAPTURE_COMMAND_START_CAPTURE on:centrals usingPeripheralManager:self.nativePeripheralManager];
}

-(void)stopDataCapture:(NSArray*) centrals
{
	[self.remoteDataCollectionService enableDataCapture:DATA_CAPTURE_COMMAND_STOP_CAPTURE on:centrals usingPeripheralManager:self.nativePeripheralManager];
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
			[self registerServices:[self allPeripheralServices]];
			break;
	}

	NSLog(@"Peripheral Delegate");
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
	if (error)
	{
		NSLog(@"Error publishing service: %@", [error localizedDescription]);
	}
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
	if ([self.remoteDataCollectionService.commandCharacteristic isEqual:characteristic])
	{
		[self notifyThatCentralDidSubscribeForRemoteDataCollection: central];
	}
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
	if ([self.remoteDataCollectionService.commandCharacteristic isEqual:characteristic])
	{
		[self notifyThatCentralDidUnsubscribeForRemoteDataCollection: central];
	}
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests
{

	for (CBATTRequest * request in requests)
	{
		if ([request.characteristic.UUID isEqual:self.remoteDataCollectionService.dataCollectorIdentifierCharacteristic.UUID])
		{
			NSString * identifier = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
			[self notifyThatCentral:request.central reportedIdentifier: identifier];
		}
		else if ([request.characteristic.UUID isEqual:self.remoteDataCollectionService.dataCollectorCollectionStatusCharacteristic.UUID])
		{
			NSString * message = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
			BOOL isCollecting = [message boolValue];
			[self notifyThatCentral:request.central updatedDataCollectionStatus:isCollecting];
		}
	}

}

@end
