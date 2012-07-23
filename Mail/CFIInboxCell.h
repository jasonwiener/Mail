//
//  DemoView.h
//  JAListView
//
//  Created by Josh Abernathy on 9/29/10.
//  Copyright 2010 Maybe Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DKHoverButtonCell.h"

@interface CFIInboxCell : NSTableCellView {
    NSGradient *gradient;
    BOOL selected;
    NSTextField *textField;
    NSTextField *shadowTextField;
}

+ (CFIInboxCell *)demoView;

@property (nonatomic, copy) NSString *title;
@property (assign) IBOutlet NSTextField *subject;
@property (assign) IBOutlet NSTextField *bodyPreview;

@property (assign) IBOutlet NSButtonCell *actionStep1;
@property (assign) IBOutlet NSButtonCell *actionStep2;
@property (assign) IBOutlet NSButtonCell *actionStep3;

@end
