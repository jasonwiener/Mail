//
//  CFIMenuView.m
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIMenuView.h"

@implementation NSView (myCustomMethods)

- (void)setAutoresizingBit:(unsigned int)bitMask toValue:(BOOL)set
{
    if (set)
    { [self setAutoresizingMask:([self autoresizingMask] | bitMask)]; }
    else
    { [self setAutoresizingMask:([self autoresizingMask] & ~bitMask)]; }
}

- (void)fixLeftEdge:(BOOL)fixed
{ [self setAutoresizingBit:NSViewMinXMargin toValue:!fixed]; }

- (void)fixRightEdge:(BOOL)fixed
{ [self setAutoresizingBit:NSViewMaxXMargin toValue:!fixed]; }

- (void)fixTopEdge:(BOOL)fixed
{ [self setAutoresizingBit:NSViewMinYMargin toValue:!fixed]; }

- (void)fixBottomEdge:(BOOL)fixed
{ [self setAutoresizingBit:NSViewMaxYMargin toValue:!fixed]; }

- (void)fixWidth:(BOOL)fixed
{ [self setAutoresizingBit:NSViewWidthSizable toValue:!fixed]; }

- (void)fixHeight:(BOOL)fixed
{ [self setAutoresizingBit:NSViewHeightSizable toValue:!fixed]; }

@end

@implementation NSButton (TextColor)

- (NSColor *)textColor
{
    NSAttributedString *attrTitle = [self attributedTitle];
    unsigned long len = [attrTitle length];
    NSRange range = NSMakeRange(0, MIN(len, 1)); // take color from first char
    NSDictionary *attrs = [attrTitle fontAttributesInRange:range];
    NSColor *textColor = [NSColor controlTextColor];
    if (attrs) {
        textColor = [attrs objectForKey:NSForegroundColorAttributeName];
    }
    return textColor;
}

- (void)setTextColor:(NSColor *)textColor
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc]
                                            initWithAttributedString:[self attributedTitle]];
    unsigned long len = [attrTitle length];
    NSRange range = NSMakeRange(0, len);
    [attrTitle addAttribute:NSForegroundColorAttributeName
                      value:textColor
                      range:range];
    [attrTitle fixAttributesInRange:range];
    [self setAttributedTitle:attrTitle];
}

@end

@implementation CFIMenuView
@synthesize line;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self fixWidth:YES];
        [self setAutoresizingMask:NSViewNotSizable];
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[NSColor colorWithCalibratedRed:41.0f/255.0f green:46.0f/255.0f blue:52.0f/255.0f alpha:1.0f] setFill];
    NSRectFill(dirtyRect);
}

-(void)awakeFromNib {
    self.line = [[NSBox alloc]initWithFrame:NSMakeRect(NSMinX(self.inboxButton.frame), NSMinY(self.inboxButton.frame), NSWidth(self.inboxButton.frame), 2.0f)];
    [self addSubview:self.line];
    [self loopExcludingButton:self.inboxButton];
}

-(void)inboxClicked:(id)sender {
    [self.line setFrame:NSMakeRect(NSMinX(self.inboxButton.frame), NSMinY(self.inboxButton.frame), NSWidth(self.inboxButton.frame), 2.0f)];
    [self loopExcludingButton:self.inboxButton];
}

-(IBAction)nextStepsClicked:(id)sender {
    [self.line setFrame:NSMakeRect(NSMinX(self.nextStepsButton.frame), NSMinY(self.nextStepsButton.frame), NSWidth(self.nextStepsButton.frame), 2.0f)];
    [self loopExcludingButton:self.nextStepsButton];

}
-(IBAction)sentClicked:(id)sender {
    [self.line setFrame:NSMakeRect(NSMinX(self.sentButton.frame), NSMinY(self.sentButton.frame), NSWidth(self.sentButton.frame), 2.0f)];
    [self loopExcludingButton:self.sentButton];

}
-(IBAction)draftsClicked:(id)sender {
    [self.line setFrame:NSMakeRect(NSMinX(self.draftsButton.frame), NSMinY(self.draftsButton.frame), NSWidth(self.draftsButton.frame), 2.0f)];
    [self loopExcludingButton:self.draftsButton];

}
-(IBAction)trashClicked:(id)sender {
    [self.line setFrame:NSMakeRect(NSMinX(self.trashButton.frame), NSMinY(self.trashButton.frame), NSWidth(self.trashButton.frame), 2.0f)];
    [self loopExcludingButton:self.trashButton];

}

-(void)loopExcludingButton:(NSButton*)button {
    for (NSButton *btn in self.subviews) {
        if (![btn isEqual:button]) {
            if ([btn respondsToSelector:@selector(setTextColor:)])
                [btn setTextColor:[NSColor colorWithCalibratedRed:102.0f/255.0f green:105.0f/255.0f blue:110.0f/255.0f alpha:1.0f]];
        }
        else {
            [btn setTextColor:[NSColor whiteColor]];
        }
    }
}

@end
