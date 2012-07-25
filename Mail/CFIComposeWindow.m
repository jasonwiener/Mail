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
#import <AddressBook/AddressBook.h>

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
    [colorWell_ setDelegate:self];
    [self buildSignature];
}

-(void)buildSignature {
    [self.bodyText insertText:@"\n\n --\n Robert Widmann \n Sent with .Mail"];
    [[self.bodyText textStorage] addAttribute: NSLinkAttributeName value:@"http://www.vanschneider.com/work/mail/" range:NSMakeRange(self.bodyText.attributedString.length-5, 5)];
}

-(NSString*)defaultSignature {
    return @"\n\n --\n Robert Widmann \n Sent with .Mail";
}

-(BOOL)windowShouldClose:(id)sender {
    if (![[self.bodyText textStorage].string isEqualToString:[self defaultSignature]]) {
        NSAlert* closeAlert = [NSAlert alertWithMessageText:@"Save this message as a draft?" defaultButton:@"Save" alternateButton:@"Discard" otherButton:@"Cancel" informativeTextWithFormat:@"This message contains unsaved changes and will be discarded if you don't save it."];
        [closeAlert beginSheetModalForWindow:self.window modalDelegate:self didEndSelector:@selector(publishedSuccessfullyDidEnd:returnCode:contextInfo:) contextInfo:(__bridge void *)((id)[[NSMutableDictionary alloc] init])];
        return NO;
    }
    return YES;
}

- (void)publishedSuccessfullyDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    if (returnCode == NSAlertDefaultReturn) {
        [self performSelector:@selector(close) withObject:nil afterDelay:1.0];
        [NSApp stopModal];
    }
    else if (returnCode  ==  NSAlertAlternateReturn) {
        [self performSelector:@selector(close) withObject:nil afterDelay:1.0];
        [NSApp stopModal];
    }

}

-(void)showFontMenu {
    
}

-(void)windowWillClose:(NSNotification *)notification {
    [NSApp stopModal];
}

//- (BOOL)control:(NSControl*)control
//       textView:(NSTextView*)textView
//doCommandBySelector:(SEL)commandSelector
//{
//    BOOL result = NO;
//    
//    if (commandSelector == @selector(insertNewline:))
//    {
//        // new line action:
//        // always insert a line-break character and don’t cause the receiver
//        // to end editing
//        [textView insertNewlineIgnoringFieldEditor:self];
//        result = YES;
//    }
//    NSLog(@"newline");
//    return result;
//}

-(void)controlTextDidChange:(NSNotification *)notification {
    if ([notification object] == self.subjectField) {
        if (self.subjectField.stringValue.length)
            [self.window setTitle:[self.subjectField stringValue]];
        else
            [self.window setTitle:@"(No Subject)"];
    }
}
-(void)send:(id)sender {
    NSLog(@"sending");
    CTCoreMessage *msg = [[CTCoreMessage alloc] init];
    [msg setTo:[NSSet setWithObject:[CTCoreAddress addressWithName:@"Robert" email:@"widmannrobert@gmail.com"]]];
    [msg setFrom:[NSSet setWithObject:[CTCoreAddress addressWithName:@"Robert" email:@"widmannrobert@gmail.com"]]];
    [msg setBody:self.bodyText.attributedString.string];
    [msg setSubject:[self.subjectField stringValue]];
    
    NSError *error = nil;
    
    if ([CTSMTPConnection canConnectToServer:@"smtp.gmail.com" username:@"widmannrobert@gmail.com" password:@"deer5cherry" port:993 useTLS:YES useAuth:YES error:&error]) {
        NSLog(@"YES");
        [CTSMTPConnection sendMessage:msg server:@"smtp.gmail.com" username:@"widmannrobert@gmail.com" password:@"deer5cherry" port:993 useTLS:YES useAuth:YES error:nil];
    }
    else {
        NSLog(@"%@", [error localizedDescription]);
    }
}
 
-(void)paragraphLeft:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphLeftSelected.png"]];
    [self.centerPar setImage:[NSImage imageNamed:@"ParagraphCenter.png"]];
    [self.rightPar setImage:[NSImage imageNamed:@"ParagraphRight.png"]];
    [self.bodyText alignLeft:self];
}
-(void)paragraphCenter:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphCenterSelected.png"]];
    [self.leftPar setImage:[NSImage imageNamed:@"ParagraphLeft.png"]];
    [self.rightPar setImage:[NSImage imageNamed:@"ParagraphRight.png"]];
    [self.bodyText alignCenter:self];
}
-(void)paragraphRight:(NSButton*)sender {
    [sender setImage:[NSImage imageNamed:@"ParagraphRightSelected.png"]];
    [self.centerPar setImage:[NSImage imageNamed:@"ParagraphCenter.png"]];
    [self.leftPar setImage:[NSImage imageNamed:@"ParagraphLeft.png"]];
    [self.bodyText alignRight:self];
}

-(void)colorWell:(MKColorWell *)colorWell didCloseWithColor:(NSColor *)aColor {
    if (self.bodyText.selectedRange.length != 0) {
        [[self.bodyText textStorage]addAttributes:[NSDictionary dictionaryWithObject:aColor forKey:NSForegroundColorAttributeName] range:self.bodyText.selectedRange];
    }
    
}


//-----------------
//NSOpenPanel: Displaying a File Open Dialog in OS X 10.7
//-----------------

// Any ole method
- (void)showAttachWindow:(id)sender {
    
    // Create a File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];

    // Enable options in the dialog.
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowsMultipleSelection:TRUE];
    // Display the dialog box.  If the OK pressed,
    // process the files.
    [openDlg beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        
        if (result == NSFileHandlingPanelOKButton) {
            // Gets list of all files selected
            NSArray *files = [openDlg URLs];
            
            // Loop through the files and process them.
            for(int i = 0; i < [files count]; i++ ) {
                
                // Do something with the filename.
                NSLog(@"File path: %@", [[files objectAtIndex:i] path]);
                
            }
        }
    }];

    
}


-(IBAction)fontDidChange:(id)sender {
}
-(IBAction)fontSizeDidChange:(id)sender {
}

@end
