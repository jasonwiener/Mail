//
//  CFIPopUpButton.m
//  Mail
//
//  Created by Robert Widmann on 7/12/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIPopUpButton.h"

@implementation CFIPopUpButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[ NSColor whiteColor] set];
    NSRectFill([self bounds]);
    [super drawRect:dirtyRect];
}

-(void)selectItem:(NSMenuItem *)item {
    [self setNeedsDisplay];
    [super selectItem:item];
}
@end
