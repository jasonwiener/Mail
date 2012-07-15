//
//  CFIMailBodyPane.m
//  Mail
//
//  Created by Robert Widmann on 7/11/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIMailBodyPane.h"

@implementation CFIMailBodyPane

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
    [[NSColor whiteColor]set];
    NSRectFill(self.bounds);
}

@end
