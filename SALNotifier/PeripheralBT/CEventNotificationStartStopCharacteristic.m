/*
//  CEventNotificationStartStopCharacteristic.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CEventNotificationStartStopCharacteristic.h"
#import "HelperMethods.h"

@interface CEventNotificationStartStopCharacteristic()
	@property(nonatomic, strong) NSData *startEvent;
	@property(nonatomic, strong) CBUUID *characteristicUUID;
	@property(nonatomic, readonly) NSString *strCharacteristicID;
	@property(nonatomic, strong) CBMutableCharacteristic *salEventNotification;

@end

@implementation CEventNotificationStartStopCharacteristic

@synthesize startEvent = _startEvent;
@synthesize characteristicUUID = _characteristicUUID;
@synthesize salEventNotification = _salEventNotification;

-(NSData *)startEvent
{
	NSString* str = @"Start Event";
	NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];

	return data;
}

-(CBMutableCharacteristic *)theStartStopCharacteristic
{
	return self.salEventNotification;
}

-(NSString *)strCharacteristicID
{
	return @"95B94B7F-382C-4041-A362-B7627C648986";
}

-(CBUUID *)characteristicUUID
{
	if(_characteristicUUID == nil)
		_characteristicUUID = [CBUUID UUIDWithString:self.strCharacteristicID];

	return _characteristicUUID;
}

-(id)init
{
	self = [super init];

	if(self == nil)
		return self;

	self.salEventNotification = [[CBMutableCharacteristic alloc] initWithType:self.characteristicUUID
																						properties:CBCharacteristicPropertyNotify //CBCharacteristicPropertyRead
																							  value:nil// self.startEvent
																					  permissions:0];//CBAttributePermissionsReadable];

	return self;
}

-(void)updateServiceValueMessage:(NSString *)notificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr
{
	@try
	{
		NSData *msgData = [notificationVal dataUsingEncoding:NSUTF8StringEncoding];
		
		if([periphMgr updateValue:msgData forCharacteristic:self.salEventNotification onSubscribedCentrals:nil] == FALSE)
			NSLog(@"Something went wrong");
	}
	@catch(NSException *exception)
	{}
	@finally
	{}
}

@end
