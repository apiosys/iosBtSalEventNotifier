/*
//  CEventNotificationService.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CEventNotificationService.h"
#import "NotifierCBUUIDManager.h"

@interface CEventNotificationService()

@end

@implementation CEventNotificationService

- (CBMutableService *)service
{
	static dispatch_once_t once;
	static CBMutableService * service;
	dispatch_once(&once, ^
	{
		service= [[CBMutableService alloc] initWithType:[NotifierCBUUIDManager eventNotificationServiceUUID] primary:TRUE];
		service.characteristics = @[self.eventNotificationMessageCharacteristic];
	});

	return service;
}

-(CBMutableCharacteristic *)eventNotificationMessageCharacteristic
{
	static dispatch_once_t once;
	static CBMutableCharacteristic * characteristic;
	dispatch_once(&once, ^
	{
		characteristic= [[CBMutableCharacteristic alloc] initWithType:[NotifierCBUUIDManager eventNotificationMessageCharacteristicUUID]
														   properties:CBCharacteristicPropertyNotify
																value:nil
														  permissions:0
						 ];
	});

	return characteristic;
}

-(void) sendEventNotificationMessage:(NSString*)message UsingPeripheralManager:(CBPeripheralManager *)periphMgr;
{
	@try
	{
		NSData *msgData = [message dataUsingEncoding:NSUTF8StringEncoding];

		if([periphMgr updateValue:msgData forCharacteristic:self.eventNotificationMessageCharacteristic onSubscribedCentrals:nil] == FALSE)
			NSLog(@"Something went wrong");
	}
	@catch (NSException *exception)
	{
		NSLog(@"Exception updating the characteristic: %@", exception.description);
	}
	@finally
	{}
}


@end
