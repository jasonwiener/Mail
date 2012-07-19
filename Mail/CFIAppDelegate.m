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

-(void)awakeFromNib {
    [self.window addViewToTitleBar:[[NSSearchField alloc]initWithFrame:NSMakeRect(0, 0, 320, 44.0f)] atXPosition:CGRectGetWidth(self.window.frame)-345];
    
    [self.window addViewToTitleBar:composeButton atXPosition:(CGRectGetWidth(self.window.frame)/2)-100];

    [self.window addViewToTitleBar:attachmentButton atXPosition:(CGRectGetWidth(self.window.frame)/2)-150];

    INAppStoreWindow *aWindow = (INAppStoreWindow*)self.window;
    aWindow.titleBarHeight = 40.0;
    CGFloat xPos = NSWidth([[self.window screen] frame])/2 - NSWidth([self.window frame])/2;
    CGFloat yPos = NSHeight([[self.window screen] frame])/2 - NSHeight([self.window frame])/2;
    [self.window setFrame:NSMakeRect(xPos, yPos, NSWidth([self.window frame]), NSHeight([self.window frame])) display:YES];
    
    [[accountButton cell] setBackgroundColor:[NSColor colorWithCalibratedRed:51.0f/255.0f green:52.0f/255.0f blue:56.0f/255.0f alpha:1.0f]];
    
}

- (NSUInteger)numberOfCellsInCollectionView:(JUCollectionView *)view
{
    return 10;
}

- (JUCollectionViewCell *)collectionView:(JUCollectionView *)view cellForIndex:(NSUInteger)index
{
    JUCollectionViewCell *cell = [view dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
        cell = [[JUCollectionViewCell alloc] initWithReuseIdentifier:@"cell"];

    return cell;
}

- (void)collectionView:(JUCollectionView *)_collectionView didSelectCellAtIndex:(NSUInteger)index
{
    NSLog(@"Selected cell at index: %u", (unsigned int)index);
    NSLog(@"Position: %@", NSStringFromPoint([_collectionView positionOfCellAtIndex:index]));
}


#pragma mark JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        CFIInboxCell *demoView = (CFIInboxCell *) view;
        demoView.selected = YES;
    }
}

- (void)listView:(JAListView *)list didSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        self.prevView.selected = NO;
        if (self.prevView != view) {
            self.origRect = view.frame;
            [self listView:self.listView didUnSelectView:self.prevView];
        }
        self.prevView = (CFIInboxCell*)view;
        if (NSMinX(self.origRect) == NSMinX(view.frame))
            [[view animator]setFrame:NSMakeRect(NSMinX(view.frame)+42, NSMinY(view.frame), NSWidth(view.frame), NSHeight(view.frame))];
    }
}

- (void)listView:(JAListView *)list didUnSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        CFIInboxCell *demoView = (CFIInboxCell *) view;
        [[view animator]setFrame:NSMakeRect(NSMinX(self.origRect), NSMinY(view.frame), NSWidth(view.frame), NSHeight(view.frame))];
        demoView.selected = NO;
    }
}


#pragma mark JAListViewDataSource

- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return 7;
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    CFIInboxCell *view = [CFIInboxCell demoView];
    return view;
}

-(void)compose:(id)sender {
    if(self.composeWindowController == nil)
        self.composeWindowController = [[CFIComposeWindow alloc] initWithWindowNibName:@"CFIComposeWindow"];
    
    self.composeWindow = [self.composeWindowController window];
    
    [NSApp runModalForWindow: self.composeWindow];
    
    [NSApp endSheet: self.composeWindow];
    
    [self.composeWindow orderOut: self];
}


-(void)moveToAttachments:(id)sender {
    [self.window.contentView replaceSubview:[[self.window.contentView subviews] objectAtIndex:1]
                               with:[[self.window.contentView subviews] objectAtIndex:0]];

}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[NSApplication sharedApplication]activateIgnoringOtherApps:YES];
    
}

@end