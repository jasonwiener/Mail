//
//  CFIAppDelegate.h
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JAListView.h"
#import "DemoView.h"
#import "CFIComposeWindow.h"

@class CFIMenuView;

@interface CFIAppDelegate : NSObject <NSApplicationDelegate,JAListViewDataSource, JAListViewDelegate, NSSplitViewDelegate> {
    IBOutlet NSButton *attachmentButton;
    IBOutlet NSButton *composeButton;
}

@property (strong) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet CFIMenuView *menuView;
@property (weak) IBOutlet JAListView *listView;
@property (nonatomic, strong) DemoView *prevView;
@property (assign) NSRect origRect;
@property (strong, nonatomic) CFIComposeWindow *composeWindowController;
@property (strong, nonatomic) NSWindow *composeWindow;

-(IBAction)compose:(id)sender;
-(IBAction)moveToAttachments:(id)sender;

@end
