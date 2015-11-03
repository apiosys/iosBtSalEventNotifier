//
//  NotifierCBUUIDManager.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "NotifierCBUUIDManager.h"

@implementation NotifierCBUUIDManager

+(CBUUID *) eventNotificationServiceUUID
{
	static dispatch_once_t once;
	static CBUUID * serviceUUID;
	dispatch_once(&once, ^
	{
		serviceUUID= [CBUUID UUIDWithString:@"CC2F4502-DE41-47D9-BFC3-BCB85136DC45"];
	});

	return serviceUUID;
}

+(CBUUID *) eventNotificationMessageCharacteristicUUID
{
	static dispatch_once_t once;
	static CBUUID * characeristicUUID;
	dispatch_once(&once, ^
	{
		characeristicUUID= [CBUUID UUIDWithString:@"95B94B7F-382C-4041-A362-B7627C648986"];
	});

	return characeristicUUID;
}

+(CBUUID *)remoteDataCollectionServiceUUID
{
	static dispatch_once_t once;
	static CBUUID * serviceUUID;
	dispatch_once(&once, ^
	{
		serviceUUID= [CBUUID UUIDWithString:@"DC659185-1C4D-4B80-B25F-36654194566C"];
	});

	return serviceUUID;
}

+(CBUUID *)remoteDataCollectionCommandCharacteristicUUID
{
	static dispatch_once_t once;
	static CBUUID * commandCharacteristicUUID;
	dispatch_once(&once, ^
	{
		commandCharacteristicUUID= [CBUUID UUIDWithString:@"BE959A4F-3FC2-405F-BFEE-45756E6D4097"];
	});

	return commandCharacteristicUUID;
}

+ (CBUUID *)remoteDataCollectionDataCollectorIdentifierCharacteristicUUID
{
	static dispatch_once_t once;
	static CBUUID * commandCharacteristicUUID;
	dispatch_once(&once, ^
				  {
					  commandCharacteristicUUID= [CBUUID UUIDWithString:@"22F57939-3FFA-4322-B30A-999661A4A2D1"];
				  });

	return commandCharacteristicUUID;
}

+ (CBUUID *)remoteDataCollectionDataCollectorCollectionStatusCharacteristicUUID
{
	static dispatch_once_t once;
	static CBUUID * commandCharacteristicUUID;
	dispatch_once(&once, ^
				  {
					  commandCharacteristicUUID= [CBUUID UUIDWithString:@"507BFB80-8729-419B-A1A8-68C0225E6F36"];
				  });

	return commandCharacteristicUUID;
}

@end
