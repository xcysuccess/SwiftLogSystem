//
//  swift-bridging-Header.h
//  swiftLogSystem
//
//  Created by tomxiang on 6/14/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>

//! Project version number for CocoaLumberjack.
FOUNDATION_EXPORT double CocoaLumberjackVersionNumber;

//! Project version string for CocoaLumberjack.
FOUNDATION_EXPORT const unsigned char CocoaLumberjackVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CocoaLumberjack/PublicHeader.h>



// Disable legacy macros
#ifndef DD_LEGACY_MACROS
#define DD_LEGACY_MACROS 0
#endif

// Core
#import "DDLog.h"

// Main macros
#import "DDLogMacros.h"
#import "DDAssertMacros.h"

// Capture ASL
#import "DDASLLogCapture.h"

// Loggers
#import "DDTTYLogger.h"
#import "DDASLLogger.h"
#import "DDFileLogger.h"


@interface swift_bridging_Header : NSObject

@end
