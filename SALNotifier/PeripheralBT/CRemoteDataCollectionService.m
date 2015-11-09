//
//  CRemoteDataCollectionService.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/2/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "CRemoteDataCollectionService.h"
#import "NotifierCBUUIDManager.h"

@interface CRemoteDataCollectionService()

@end

@implementation CRemoteDataCollectionService

- (CBMutableCharacteristic *) commandCharacteristic
{
	static dispatch_once_t once;
	static CBMutableCharacteristic * characteristic;
	dispatch_once(&once, ^
	{
		characteristic= [[CBMutableCharacteristic alloc] initWithType:[NotifierCBUUIDManager remoteDataCollectionCommandCharacteristicUUID]
														   properties:CBCharacteristicPropertyNotify
																value:nil
														  permissions:0
						 ];
	});
	
	return characteristic;
}

- (CBMutableCharacteristic *) dataCollectorIdentifierCharacteristic
{
	static dispatch_once_t once;
	static CBMutableCharacteristic * characteristic;
	dispatch_once(&once, ^
				  {
					  characteristic= [[CBMutableCharacteristic alloc] initWithType:[NotifierCBUUIDManager remoteDataCollectionDataCollectorIdentifierCharacteristicUUID]
																		 properties:CBCharacteristicPropertyWriteWithoutResponse
																			  value:nil
																		permissions:CBAttributePermissionsWriteable
									   ];
				  });
	
	return characteristic;
}

- (CBMutableCharacteristic *) dataCollectorCollectionStatusCharacteristic
{
	static dispatch_once_t once;
	static CBMutableCharacteristic * characteristic;
	dispatch_once(&once, ^
				  {
					  characteristic= [[CBMutableCharacteristic alloc] initWithType:[NotifierCBUUIDManager remoteDataCollectionDataCollectorCollectionStatusCharacteristicUUID]
																		 properties:CBCharacteristicPropertyWriteWithoutResponse
																			  value:nil
																		permissions:CBAttributePermissionsWriteable
									   ];
				  });
	
	return characteristic;
}

-(CBMutableService*) service
{
	static dispatch_once_t once;
	static CBMutableService * remoteDataCollectionService;
	dispatch_once(&once, ^
	{
		remoteDataCollectionService = [[CBMutableService alloc] initWithType:[NotifierCBUUIDManager remoteDataCollectionServiceUUID] primary:TRUE];
		remoteDataCollectionService.characteristics = @[
														self.commandCharacteristic,
														self.dataCollectorIdentifierCharacteristic,
														self.dataCollectorCollectionStatusCharacteristic
														];
	});

	return remoteDataCollectionService;
}

+(NSString *) commandMessageForDataCaptureCommand:(DATA_CAPTURE_COMMAND) command
{
	NSString * command_message;
	switch (command)
	{
		case DATA_CAPTURE_COMMAND_START_CAPTURE:
			command_message = @"START_CAPTURE";
			break;
		case DATA_CAPTURE_COMMAND_STOP_CAPTURE:
			command_message = @"STOP_CAPTURE";
			break;
	}
	return command_message;
}

-(void)enableDataCapture:(DATA_CAPTURE_COMMAND)command on:(NSArray*)centrals usingPeripheralManager:(CBPeripheralManager*) manager
{

	@try
	{
		NSString * message = [CRemoteDataCollectionService commandMessageForDataCaptureCommand:command];

		NSData *msgData = [message dataUsingEncoding:NSUTF8StringEncoding];

		if([manager updateValue:msgData forCharacteristic:self.commandCharacteristic onSubscribedCentrals:centrals] == FALSE)
			NSLog(@"Something went wrong");
	}
	@catch (NSException *exception)
	{
		NSLog(@"Exception updating the characteristic: %@", exception.description);
	}
	@finally
	{}
	
}

-(void) central:(CBCentral*) central didSubscribeToCharacteristic:(CBCharacteristic*) characteristic
{

}

-(void) central:(CBCentral*) central didUnsubscribeToCharacteristic:(CBCharacteristic*) characteristic
{

}


@end
