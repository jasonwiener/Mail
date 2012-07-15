//
//  CFIFontMenu.m
//  Mail
//
//  Created by Robert Widmann on 7/13/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIFontMenu.h"

@implementation CFIFontMenu

+ (id)sharedFontMenu
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(id)init {
    self = [super init];
    if (self) {
        fonts = [NSMutableArray arrayWithObjects:@"Helvetica",@"Menlo",@"Hoefler Text",@"Helvetica Neue", nil];

        for (NSString *font in fonts) {
            [self addItem:[[NSMenuItem alloc]initWithTitle:font action:@selector(setFont:) keyEquivalent:@""]];
        }
        [self addItem:[NSMenuItem separatorItem]];
        [self addItem:[[NSMenuItem alloc]initWithTitle:@"Show Fonts..." action:@selector(showFontMenu) keyEquivalent:@""]];
        [self addItem:[NSMenuItem separatorItem]];
        for (NSString* font in [[NSFontManager sharedFontManager] availableFontFamilies]) {
            [self addItem:[[NSMenuItem alloc]initWithTitle:font action:@selector(setFont:) keyEquivalent:@""]];
        }
    }
    return self;
}
@end
