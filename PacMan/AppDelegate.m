//
//  AppDelegate.m
//  PacMan
//
//  Created by Jules on 4/17/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppView.h"

@implementation AppDelegate

@synthesize window = _window;

AppView *view;
NSTimer* timer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setFrame:CGRectMake(300, 200, 500, 550) display:YES];
    [self.window setStyleMask:[self.window styleMask] & ~NSResizableWindowMask];
    [self.window setBackgroundColor:[NSColor lightGrayColor]];
    view = [[AppView alloc] initWithFrame:_window.frame];
    [view setFrameOrigin:NSMakePoint(0, 0)];
    [self.window.contentView addSubview:view];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    [view becomeFirstResponder];
    
}

- (void) refresh {
    [view refresh];
}

@end
