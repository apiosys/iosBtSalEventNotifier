/*
//  CEventNotificationService.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

@interface CEventNotificationService : NSObject

	-(CBMutableService*) service;

	-(void)sendEventNotificationMessage:(NSString*)notificationVal UsingPeripheralManager:(CBPeripheralManager *)periphMgr;

@end
