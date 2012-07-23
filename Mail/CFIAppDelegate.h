//
//  CFIAppDelegate.h
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CFIInboxCell.h"
#import "CFIComposeWindow.h"
#import "JUCollectionView.h"

@class CFIMenuView;

@interface CFIAppDelegate : NSObject <NSApplicationDelegate, JUCollectionViewDataSource, JUCollectionViewDelegate, NSTableViewDataSource, NSTableViewDelegate> {
    IBOutlet NSButton *attachmentButton;
    IBOutlet NSButton *composeButton;
    IBOutlet NSButton *accountButton;
    
    IBOutlet NSPanel *aboutPanel;

    //Inbox, Attachments
    IBOutlet NSView *startupView;
    IBOutlet JUCollectionView *assetCollectionView;  // the container view in which the slides are positioned
    NSMutableArray *content;
    IBOutlet NSTableView *inboxTableView;
}

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet CFIMenuView *menuView;
@property (nonatomic, strong) CFIInboxCell *prevView;
@property (assign) NSRect origRect;
@property (strong, nonatomic) CFIComposeWindow *composeWindowController;
@property (strong, nonatomic) NSWindow *composeWindow;

-(IBAction)compose:(id)sender;
-(IBAction)moveToAttachments:(id)sender;
-(IBAction)saveAction:(id)sender;
-(IBAction)showAboutPanel:(id)sender;

@end
