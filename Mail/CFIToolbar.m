//
//  CFIToolbar.m
//  Mail
//
//  Created by Robert Widmann on 7/12/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIToolbar.h"

@implementation CFIToolbar

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
    [[NSColor blackColor]set];
    NSRectFill(self.bounds);
}

@end
