//
//  DemoView.h
//  JAListView
//
//  Created by Josh Abernathy on 9/29/10.
//  Copyright 2010 Maybe Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JAListViewItem.h"
#import "DKHoverButtonCell.h"

@interface DemoView : JAListViewItem {
    NSGradient *gradient;
    BOOL selected;
    NSTextField *textField;
    NSTextField *shadowTextField;
}

+ (DemoView *)demoView;

@property (nonatomic, copy) NSString *text;
@property (strong) IBOutlet NSTextField *textField;
@property (strong) IBOutlet NSTextField *shadowTextField;

@property (weak) IBOutlet NSButtonCell *actionStep1;
@property (weak) IBOutlet NSButtonCell *actionStep2;
@property (weak) IBOutlet NSButtonCell *actionStep3;

@end
