//
//  DKHoverButtonCell.h
//  Mail
//
//  Created by Robert Widmann on 7/11/12.
//  Copyright (c) 2012 CodaFi Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface DKHoverButtonCell : NSButtonCell
{
    NSImage *_oldImage;
    NSImage *hoverImage;
}

@property (retain, nonatomic) NSImage *hoverImage;

@end
