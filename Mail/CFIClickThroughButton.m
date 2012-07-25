//
//  CFIClickThroughButton.m
//  Mail
//
//  Created by Robert Widmann on 7/24/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIClickThroughButton.h"

@implementation CFIClickThroughButton

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
}

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}
@end
