/*
//  CEventNotificationStartStopCharacteristic.m
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import "CEventNotificationStartStopCharacteristic.h"

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

-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr
{
	NSString *strMessage = nil;
	
	switch (eNotificationVal)
	{
		case HB_START:
			strMessage = @"SE:HB";
			break;
		case HB_STOP:
			strMessage = @"EE:HB";
			break;
		case RA_START:
			strMessage = @"SE:RA";
			break;
		case RA_STOP:
			strMessage = @"EE:RA";
			break;
		case WK_START:
			strMessage = @"SE:WK";
			break;
		case WK_STOP:
			strMessage = @"EE:WK";
			break;
		case HT_LEFT_START:
			strMessage = @"SE:HTL";
			break;
		case HT_LEFT_STOP:
			strMessage = @"EE:HTL";
			break;
		case HT_RIGHT_START:
			strMessage = @"SE:HTR";
			break;
		case HT_RIGHT_STOP:
			strMessage = @"EE:HTR";
			break;
		case SPEEDING_START:
			strMessage = @"SE:SP";
			break;
		case SPEEDING_STOP:
			strMessage = @"EE:SP";
			break;
		case VEHICLE_ENTRY_START:
			strMessage = @"SE:VE";
			break;
		case VEHICLE_ENTRY_STOP:
			strMessage = @"EE:VE";
			break;
		case VEHICLE_EXIT_START:
			strMessage = @"SE:VX";
			break;
		case VEHICLE_EXIT_STOP:
			strMessage = @"EE:VX";
			break;
		default:
			return;
	}
	
	NSData *msgData = [strMessage dataUsingEncoding:NSUTF8StringEncoding];
	
	[periphMgr updateValue:msgData forCharacteristic:self.salEventNotification onSubscribedCentrals:nil];
}

@end
