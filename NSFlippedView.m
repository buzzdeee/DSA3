/* All rights reserved */

#import <AppKit/AppKit.h>
#import "NSFlippedView.h"

@implementation NSFlippedView
-(BOOL) isFlipped
{
  return YES;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Custom drawing code
    [[NSColor lightGrayColor] setFill];
    NSRectFill(dirtyRect);
}

@end
