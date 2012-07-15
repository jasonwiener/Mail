//
//  CFIMenuView.h
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (myCustomMethods)

- (void)fixLeftEdge:(BOOL)fixed;
- (void)fixRightEdge:(BOOL)fixed;
- (void)fixTopEdge:(BOOL)fixed;
- (void)fixBottomEdge:(BOOL)fixed;
- (void)fixWidth:(BOOL)fixed;
- (void)fixHeight:(BOOL)fixed;

@end

@interface NSButton (TextColor)

- (NSColor *)textColor;
- (void)setTextColor:(NSColor *)textColor;

@end

@interface CFIMenuView : NSView

@property (assign) IBOutlet NSButton *inboxButton;
@property (assign) IBOutlet NSButton *nextStepsButton;
@property (assign) IBOutlet NSButton *sentButton;
@property (assign) IBOutlet NSButton *draftsButton;
@property (assign) IBOutlet NSButton *trashButton;

@property (nonatomic, strong) NSBox *line;

-(IBAction)inboxClicked:(id)sender;
-(IBAction)nextStepsClicked:(id)sender;
-(IBAction)sentClicked:(id)sender;
-(IBAction)draftsClicked:(id)sender;
-(IBAction)trashClicked:(id)sender;

@end
