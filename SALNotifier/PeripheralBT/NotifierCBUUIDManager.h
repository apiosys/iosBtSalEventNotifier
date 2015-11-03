//
//  NotifierCBUUIDManager.h
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBUUID.h>

@interface NotifierCBUUIDManager : NSObject

	+(CBUUID *) eventNotificationServiceUUID;
	+(CBUUID *) eventNotificationMessageCharacteristicUUID;

	+(CBUUID *) remoteDataCollectionServiceUUID;
	+(CBUUID *) remoteDataCollectionCommandCharacteristicUUID;
	+(CBUUID *) remoteDataCollectionDataCollectorIdentifierCharacteristicUUID;
	+(CBUUID *) remoteDataCollectionDataCollectorCollectionStatusCharacteristicUUID;

@end
