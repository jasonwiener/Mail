//
//  DemoView.m
//  JAListView
//
//  Created by Josh Abernathy on 9/29/10.
//  Copyright 2010 Maybe Apps. All rights reserved.
//

#import "DemoView.h"

@interface DemoView ()
- (void)drawBackground;

@property (weak, nonatomic, readonly) NSGradient *gradient;
@end


@implementation DemoView

+ (DemoView *)demoView {
    static NSNib *nib = nil;
    if(nib == nil) {
        nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(self) bundle:nil];
    }
    
    NSArray *objects = nil;
    [nib instantiateNibWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:self]) {
            return object;
        }
    }
    
    NSAssert1(NO, @"No view of class %@ found.", NSStringFromClass(self));
    return nil;
}

-(void)awakeFromNib {
    [(DKHoverButtonCell*)self.actionStep1 setImage:[NSImage imageNamed:@"ActionStepOne.png"]];
    [(DKHoverButtonCell*)self.actionStep1 setHoverImage:[NSImage imageNamed:@"ActionStepOneHover.png"]];
    [(DKHoverButtonCell*)self.actionStep2 setImage:[NSImage imageNamed:@"ActionStepTwo.png"]];
    [(DKHoverButtonCell*)self.actionStep2 setHoverImage:[NSImage imageNamed:@"ActionStepTwoHover.png"]];
    [(DKHoverButtonCell*)self.actionStep3 setImage:[NSImage imageNamed:@"ActionStepThree.png"]];
    [(DKHoverButtonCell*)self.actionStep3 setHoverImage:[NSImage imageNamed:@"ActionStepThreeHover.png"]];

}

#pragma mark NSView

- (void)drawRect:(NSRect)rect {
    [super drawRect:rect];
    [self drawBackground];
}

#pragma mark API

- (void)drawBackground {
    if (selected) {
        [self.gradient drawInRect:self.bounds angle:90.0f];
    }
    [[NSColor colorWithCalibratedRed:240.0f/255.0f green:243.0f/255.0f blue:246.0f/255.0f alpha:1.0f] set];
    NSRectFill(NSMakeRect(0.0f, 0.0f, self.bounds.size.width, 1.0f));
    
    [[NSColor colorWithCalibratedRed:233.0f/255.0f green:238.0f/255.0f blue:242.0f/255.0f alpha:1.0f] set];
    NSRectFill(NSMakeRect(0.0f, self.bounds.size.height - 1.0f, self.bounds.size.width, 1.0f));

}

- (NSGradient *)gradient {
    if(gradient == nil) {
        gradient = [[NSGradient alloc] initWithColorsAndLocations:[NSColor colorWithCalibratedRed:245.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f],0.0, [NSColor colorWithCalibratedRed:248.0f/255.0f green:250.0f/255.0f blue:249.0f/255.0f alpha:1.0f],10.0f/120.0f, [NSColor colorWithCalibratedRed:245.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f],1-(10.0f/120.0f), nil];
    }
    
    return gradient;
}
- (void)setText:(NSString *)newText {
    NSString *newValue = [newText copy];
    [self.textField setStringValue:newValue];
    [self.shadowTextField setStringValue:newValue];
}

- (NSString *)text {
    return [self.textField stringValue];
}

- (void)setSelected:(BOOL)isSelected {
    selected = isSelected;
    [self setNeedsDisplay:YES];
}

@synthesize selected;
@synthesize textField;
@synthesize shadowTextField;

@end
