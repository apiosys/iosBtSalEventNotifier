/*
//  CPeripheralManager.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

#import "Defs.h"

@interface CPeripheralManager : NSObject<CBPeripheralManagerDelegate>

+(CPeripheralManager *)thePeripheralManager;

-(void)advertiseTheServices;
-(void)stopAdvertisingTheServices;
-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal;

@end
