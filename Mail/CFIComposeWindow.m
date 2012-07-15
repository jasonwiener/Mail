//
//  CFIComposeWindow.m
//  Mail
//
//  Created by Robert Widmann on 7/11/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIComposeWindow.h"
#import <QuartzCore/QuartzCore.h>
#import "LIFlipEffect.h"
#import "CFIMailIconWindow.h"
#import "CFIFontMenu.h"

@interface CFIComposeWindow () {
    CFIMailIconWindow *mailIconWindow;
}

@end

@implementation CFIComposeWindow
@synthesize colorWell = colorWell_;
@synthesize selectedFont;
@synthesize textView = textView_;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    fontSizes = @[@"9", @"10", @"11", @"12", @"13", @"14", @"18", @"24", @"36", @"48", @"64", @"72", @"96", @"144", @"288"];
    [fontSizeController setContent:fontSizes];
    [self.fontButton setMenu:[CFIFontMenu sharedFontMenu]];
}

-(void)showFontMenu {
    
}
                                      
-(void)windowWillClose:(NSNotification *)notification {
    [NSApp stopModal];
}

- (BOOL)control:(NSControl*)control
       textView:(NSTextView*)textView
doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;
    
    if (commandSelector == @selector(insertNewline:))
    {
        // new line action:
        // always insert a line-break character and don’t cause the receiver
        // to end editing
        [textView insertNewlineIgnoringFieldEditor:self];
        result = YES;
    }
    
    return result;
}

-(void)send:(id)sender {
    [NSApp stopModal];
}

-(void)paragraphLeft:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphLeftSelected.png"]];
    [self.centerPar setImage:[NSImage imageNamed:@"ParagraphCenter.png"]];
    [self.rightPar setImage:[NSImage imageNamed:@"ParagraphRight.png"]];
}
-(void)paragraphCenter:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphCenterSelected.png"]];
    [self.leftPar setImage:[NSImage imageNamed:@"ParagraphLeft.png"]];
    [self.rightPar setImage:[NSImage imageNamed:@"ParagraphRight.png"]];
}
-(void)paragraphRight:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphRightSelected.png"]];
    [self.centerPar setImage:[NSImage imageNamed:@"ParagraphCenter.png"]];
    [self.leftPar setImage:[NSImage imageNamed:@"ParagraphLeft.png"]];
}


@end
