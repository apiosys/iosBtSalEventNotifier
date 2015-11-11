//
//  RemoteDataCollector.h
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBCentral.h>

@interface RemoteDataCollector : NSObject

	+(RemoteDataCollector*)remoteDataCollectorAtCentral:(CBCentral *) central;

	@property(nonatomic, strong) NSString * identifier;
	@property(nonatomic) BOOL isCollecting;
	@property(nonatomic,readonly) CBCentral * central;

@end
