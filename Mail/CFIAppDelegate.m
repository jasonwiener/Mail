//
//  CFIAppDelegate.m
//  Mail
//
//  Created by Robert Widmann on 7/10/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import "CFIAppDelegate.h"
#import "INAppStoreWindow.h"
#import <QuartzCore/QuartzCore.h>
#import "NSView+NSViewAnimationWithBlocks.h"
#import "CFIMenuView.h"
#import "CFIAttachmentCell.h"
#import <MailCore/MailCore.h>

@interface NSWindow (NSWindow_AccessoryView)

-(void)addViewToTitleBar:(NSView*)viewToAdd atXPosition:(CGFloat)x;

@end

@implementation NSWindow (NSWindow_AccessoryView)

-(void)addViewToTitleBar:(NSView*)viewToAdd atXPosition:(CGFloat)x
{
    viewToAdd.frame = NSMakeRect(x, [[self contentView] frame].size.height-13, viewToAdd.frame.size.width, 30);
    
    NSUInteger mask = 0;
    if( x > self.frame.size.width / 2.0 )
    {
        mask |= NSViewMinXMargin;
    }
    else
    {
        mask |= NSViewMaxXMargin;
    }
    [viewToAdd setAutoresizingMask:mask | NSViewMinYMargin];
    
    [[[self contentView] superview] addSubview:viewToAdd];
}

@end

@implementation CFIAppDelegate
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

-(IBAction)showAboutPanel:(id)sender {
    if (!aboutPanel) {
        BOOL successful = [NSBundle loadNibNamed:@"About" owner:self];
        
        // This makes the about panel the key window - gives it focus
        [aboutPanel makeKeyAndOrderFront:nil];
        
        NSLog(@"About panel loaded with success status %d.", successful);
        return;
    }
    
    // The About panel is open, so just give it focus.
    [aboutPanel makeKeyAndOrderFront:nil];
    NSLog(@"About panel given focus.");

}
-(void)awakeFromNib {
//        [self performSelector:@selector(startup)];
        [self.window addViewToTitleBar:[[NSSearchField alloc]initWithFrame:NSMakeRect(0, 0, 320, 44.0f)] atXPosition:CGRectGetWidth(self.window.frame)-345];
        
        [self.window addViewToTitleBar:composeButton atXPosition:(CGRectGetWidth(self.window.frame)/2)-100];
        
        [self.window addViewToTitleBar:attachmentButton atXPosition:(CGRectGetWidth(self.window.frame)/2)-150];
        
        INAppStoreWindow *aWindow = (INAppStoreWindow*)self.window;
        aWindow.titleBarHeight = 40.0;
        CGFloat xPos = NSWidth([[self.window screen] frame])/2 - NSWidth([self.window frame])/2;
        CGFloat yPos = NSHeight([[self.window screen] frame])/2 - NSHeight([self.window frame])/2;
        [self.window setFrame:NSMakeRect(xPos, yPos, NSWidth([self.window frame]), NSHeight([self.window frame])) display:YES];
        
        [[accountButton cell] setBackgroundColor:[NSColor colorWithCalibratedRed:51.0f/255.0f green:52.0f/255.0f blue:56.0f/255.0f alpha:1.0f]];
        
        [inboxTableView setRowHeight:120.0f];

//    }
}

-(void)startup {
    INAppStoreWindow *aWindow = (INAppStoreWindow*)self.window;
    aWindow.titleBarHeight = 20.0;
    [aWindow setStyleMask:(NSTitledWindowMask |NSClosableWindowMask|NSMiniaturizableWindowMask)];
    CGFloat xPos = NSWidth([[self.window screen] frame])/2 - NSWidth([self.window frame])/2;
    CGFloat yPos = NSHeight([[self.window screen] frame])/2 - NSHeight([self.window frame])/2;
    [self.window setFrame:NSMakeRect(xPos, yPos, 805, 522) display:YES animate:NO];
    [aWindow setContentView:startupView];
}

- (NSUInteger)numberOfCellsInCollectionView:(JUCollectionView *)view
{
    return [content count];
}

- (JUCollectionViewCell *)collectionView:(JUCollectionView *)view cellForIndex:(NSUInteger)index
{
    JUCollectionViewCell *cell = [view dequeueReusableCellWithIdentifier:@"cell"];
    
        if (cell == nil){
            cell = [[JUCollectionViewCell alloc]initWithReuseIdentifier:@"cell"];
            [cell setWantsLayer:YES];
        }
    [cell setImage:[content objectAtIndex:index]];

    return cell;
}

- (void)collectionView:(JUCollectionView *)_collectionView didSelectCellAtIndex:(NSUInteger)index
{
    NSLog(@"Selected cell at index: %u", (unsigned int)index);
    NSLog(@"Position: %@", NSStringFromPoint([_collectionView positionOfCellAtIndex:index]));
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 30;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
{
    return nil;
}


-(void)moveToAttachments:(id)sender {
    NSLog(@"moving");
    //    [self.window.contentView replaceSubview:[[self.window.contentView subviews] objectAtIndex:1]
    //                               with:[[self.window.contentView subviews] objectAtIndex:0]];
    CTCoreAccount *acc = [[CTCoreAccount alloc]init];
    BOOL success = [acc connectToServer:@"smtp.gmail.com" port:993 connectionType:CTConnectionTypeTLS authType:CTImapAuthTypePlain login:@"widmannrobert@gmail.com" password:@"deer5cherry"];
    if (success) {
        NSLog(@"YES!!");
    } else {
        NSLog(@"NO!!");

    }
    
}

-(void)compose:(id)sender {
    self.composeWindowController = [[CFIComposeWindow alloc] initWithWindowNibName:@"CFIComposeWindow"];
    
    self.composeWindow = [self.composeWindowController window];
    
    [NSApp runModalForWindow: self.composeWindow];
    
    [NSApp endSheet: self.composeWindow];
    
    [self.composeWindow orderOut: self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    content = [[NSMutableArray alloc] init];
    
    for(int i=0; i<10; i++) // This creates 590 elements!
    {
        [content addObject:[NSImage imageNamed:NSImageNameQuickLookTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameBluetoothTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameIChatTheaterTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameSlideshowTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameActionTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameSmartBadgeTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameIconViewTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameListViewTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameColumnViewTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameFlowViewTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNamePathTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameInvalidDataFreestandingTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameLockLockedTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameLockUnlockedTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameGoRightTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameGoLeftTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameRightFacingTriangleTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameLeftFacingTriangleTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameAddTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameRemoveTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameRevealFreestandingTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameFollowLinkFreestandingTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameEnterFullScreenTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameExitFullScreenTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameStopProgressTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameStopProgressFreestandingTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameRefreshTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameRefreshFreestandingTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameBonjour]];
        [content addObject:[NSImage imageNamed:NSImageNameComputer]];
        [content addObject:[NSImage imageNamed:NSImageNameFolderBurnable]];
        [content addObject:[NSImage imageNamed:NSImageNameFolderSmart]];
        [content addObject:[NSImage imageNamed:NSImageNameFolder]];
        [content addObject:[NSImage imageNamed:NSImageNameNetwork]];
        [content addObject:[NSImage imageNamed:NSImageNameDotMac]];
        [content addObject:[NSImage imageNamed:NSImageNameMobileMe]];
        [content addObject:[NSImage imageNamed:NSImageNameMultipleDocuments]];
        [content addObject:[NSImage imageNamed:NSImageNameUserAccounts]];
        [content addObject:[NSImage imageNamed:NSImageNamePreferencesGeneral]];
        [content addObject:[NSImage imageNamed:NSImageNameAdvanced]];
        [content addObject:[NSImage imageNamed:NSImageNameInfo]];
        [content addObject:[NSImage imageNamed:NSImageNameFontPanel]];
        [content addObject:[NSImage imageNamed:NSImageNameColorPanel]];
        [content addObject:[NSImage imageNamed:NSImageNameUser]];
        [content addObject:[NSImage imageNamed:NSImageNameUserGroup]];
        [content addObject:[NSImage imageNamed:NSImageNameEveryone]];
        [content addObject:[NSImage imageNamed:NSImageNameUserGuest]];
        [content addObject:[NSImage imageNamed:NSImageNameMenuOnStateTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameMenuMixedStateTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameApplicationIcon]];
        [content addObject:[NSImage imageNamed:NSImageNameTrashEmpty]];
        [content addObject:[NSImage imageNamed:NSImageNameTrashFull]];
        [content addObject:[NSImage imageNamed:NSImageNameHomeTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameBookmarksTemplate]];
        [content addObject:[NSImage imageNamed:NSImageNameCaution]];
        [content addObject:[NSImage imageNamed:NSImageNameStatusAvailable]];
        [content addObject:[NSImage imageNamed:NSImageNameStatusPartiallyAvailable]];
        [content addObject:[NSImage imageNamed:NSImageNameStatusUnavailable]];
        [content addObject:[NSImage imageNamed:NSImageNameStatusNone]];
    }

    [assetCollectionView reloadData];
    [assetCollectionView setCellSize:NSMakeSize(64.0, 64.0)];
    
    // Insert code here to initialize your application
    [[NSApplication sharedApplication]activateIgnoringOtherApps:YES];
    
}

#pragma mark Core Data
// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.codafi.CD" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.codafi.CD"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![[properties objectForKey:NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"CD.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    return NSTerminateNow;
}


@end