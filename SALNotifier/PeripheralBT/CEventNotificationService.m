/*
//  CEventNotificationService.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CEventNotificationService.h"
#import "CEventNotificationStartStopCharacteristic.h"

@interface CEventNotificationService()
	@property(nonatomic, strong) CBUUID *notificationServiceUUID;
	@property(nonatomic, strong) CBMutableService *notificationService;
	@property(nonatomic, strong) CEventNotificationStartStopCharacteristic *startStopCharacteristic;
	@property(nonatomic, readonly) NSString *strNotificationServiceUUID;
@end

@implementation CEventNotificationService

@synthesize notificationService = _notificationService;
@synthesize startStopCharacteristic = _startStopCharacteristic;
@synthesize notificationServiceUUID = _notificationServiceUUID;

-(CBMutableService *)theNotificationService
{
	return self.notificationService;
}

-(NSString *)strServiceUUID
{
	return self.strNotificationServiceUUID;
}

-(CBMutableService *)notificationService
{
	if(_notificationService == nil)
	{
		_notificationService = [[CBMutableService alloc] initWithType:self.notificationServiceUUID primary:TRUE];
		_notificationService.characteristics = @[self.startStopCharacteristic.theStartStopCharacteristic];
	}

	return _notificationService;
}

-(CEventNotificationStartStopCharacteristic *)startStopCharacteristic
{
	if(_startStopCharacteristic == nil)
		_startStopCharacteristic = [[CEventNotificationStartStopCharacteristic alloc]init];
	
	return _startStopCharacteristic;
}

-(NSString *)strNotificationServiceUUID
{
	return @"CC2F4502-DE41-47D9-BFC3-BCB85136DC45";
}

-(CBUUID *)notificationServiceUUID
{
	if(_notificationServiceUUID == nil)
		_notificationServiceUUID = [CBUUID UUIDWithString:self.strNotificationServiceUUID];

	return _notificationServiceUUID;
}

-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr
{
	@try
	{
		[self.startStopCharacteristic updateServiceValue:eNotificationVal thePeripheralManager:periphMgr];
	}
	@catch (NSException *exception)
	{
		NSLog(@"Exception updating the characteristic: %@", exception.description);
	}
	@finally
	{}
}

@end
