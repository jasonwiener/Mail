//
//  CFIComposeWindow.h
//  Mail
//
//  Created by Robert Widmann on 7/11/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MKColorWell.h"

@interface CFIComposeWindow : NSWindowController <NSWindowDelegate, NSTextFieldDelegate> {
    NSString *selectedFont;
    NSArray *fontSizes;
    IBOutlet NSArrayController *fontSizeController;
    NSString *selectedFontSize;
    
}
@property (nonatomic, copy) NSString *selectedFont;
@property IBOutlet NSPopUpButton *fontButton;
@property IBOutlet NSPopUpButton *fontSizeButton;
@property (strong, nonatomic) MKColorWell * colorWell;
@property IBOutlet NSTextView *textView;
@property IBOutlet NSButton *leftPar;
@property IBOutlet NSButton *centerPar;
@property IBOutlet NSButton *rightPar;

-(IBAction)send:(id)sender;
-(IBAction)paragraphLeft:(NSButton*)sender;
-(IBAction)paragraphCenter:(NSButton*)sender;
-(IBAction)paragraphRight:(NSButton*)sender;

@end
