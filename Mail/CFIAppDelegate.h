//
//  CFIAppDelegate.h
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JAListView.h"
#import "CFIInboxCell.h"
#import "CFIComposeWindow.h"
#import "JUCollectionView.h"

@class CFIMenuView;

@interface CFIAppDelegate : NSObject <NSApplicationDelegate,JAListViewDataSource, JAListViewDelegate, NSSplitViewDelegate, JUCollectionViewDataSource> {
    IBOutlet NSButton *attachmentButton;
    IBOutlet NSButton *composeButton;
    IBOutlet NSButton *accountButton;
    
    //Inbox, Attachments
    IBOutlet NSView *inboxView;
    IBOutlet JUCollectionView *assetCollectionView;  // the container view in which the slides are positioned
    NSMutableArray *content;
}

@property (strong) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet CFIMenuView *menuView;
@property (weak) IBOutlet JAListView *listView;
@property (nonatomic, strong) CFIInboxCell *prevView;
@property (assign) NSRect origRect;
@property (strong, nonatomic) CFIComposeWindow *composeWindowController;
@property (strong, nonatomic) NSWindow *composeWindow;

-(IBAction)compose:(id)sender;
-(IBAction)moveToAttachments:(id)sender;

@end
