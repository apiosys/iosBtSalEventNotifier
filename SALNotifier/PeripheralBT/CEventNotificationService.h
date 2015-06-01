/*
//  CEventNotificationService.h
//  SALNotifier
//
//  Created by Jeff Behrbaum on 12/7/14.
//  Copyright (c) 2014 Apio Systems. All rights reserved.
*/

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

#import "Defs.h"

@interface CEventNotificationService : NSObject

	@property(nonatomic, readonly) NSString *strServiceUUID;
	@property(nonatomic, readonly) CBMutableService *theNotificationService;

	-(void)updateServiceMessageValue:(NSString *)notificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr;
	-(void)updateServiceValue:(NOTIFICATION_EVENTS)eNotificationVal thePeripheralManager:(CBPeripheralManager *)periphMgr;
@end
