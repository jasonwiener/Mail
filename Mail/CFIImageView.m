//
//  CFIImageView.m
//  Mail
//
//  Created by Robert Widmann on 7/13/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIImageView.h"

@implementation CFIImageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
    [self.layer setCornerRadius:(NSHeight(self.frame))/2];
    [self.layer setBorderColor:CGColorCreateGenericRGB(128.0f, 128.0f, 128.0f, 1.0f)];
    [self.layer setBorderWidth:2.0f];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
