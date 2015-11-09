//
//  RemoteDataCollector.m
//  SALNotifier
//
//  Created by Brandon Bodnar on 11/3/15.
//  Copyright © 2015 Apio Systems. All rights reserved.
//

#import "RemoteDataCollector.h"

@interface RemoteDataCollector ()
	@property(nonatomic, strong) CBCentral * central;
@end

@implementation RemoteDataCollector

+(RemoteDataCollector *)remoteDataCollectorAtCentral:(CBCentral *)central
{
	RemoteDataCollector * remoteDataCollector = [[RemoteDataCollector alloc] init];
	remoteDataCollector.central = central;
	remoteDataCollector.identifier = @"Unknown Device";
	remoteDataCollector.isCollecting = FALSE;
	return remoteDataCollector;
}

@end
