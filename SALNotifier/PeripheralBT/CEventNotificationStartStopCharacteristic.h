/*
//  CEventNotificationStartStopCharacteristic.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

#import "Defs.h"

@interface CEventNotificationStartStopCharacteristic : NSObject

	@property(nonatomic, readonly) CBMutableCharacteristic *theStartStopCharacteristic;

	-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr;
@end
