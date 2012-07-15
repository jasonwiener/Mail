//
//  CFIFontMenu.h
//  Mail
//
//  Created by Robert Widmann on 7/13/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CFIFontMenu : NSMenu {
    NSMutableArray *fonts;
}

+(id)sharedFontMenu;

@end
