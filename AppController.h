/* 
   Project: DSA3

   Author: Sebastian Reitenbach

   Created: 2024-07-12 22:42:06 +0200 by sebastia
   
   Application Controller
*/
 
#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <AppKit/AppKit.h>
// Uncomment if your application is Renaissance-based
//#import <Renaissance/Renaissance.h>

@interface AppController : NSObject
{
  IBOutlet NSWindow *windowCharacterStartwerte;
  IBOutlet NSPopUpButton *popupCharacterChooser;
  IBOutlet NSFormCell *fieldStartwerteMU;
  IBOutlet NSFormCell *fieldStartwerteKL;
  IBOutlet NSFormCell *fieldStartwerteIN;        
  IBOutlet NSFormCell *fieldStartwerteCH;
  IBOutlet NSFormCell *fieldStartwerteFF;
  IBOutlet NSFormCell *fieldStartwerteGE;
  IBOutlet NSFormCell *fieldStartwerteKK;
  IBOutlet NSFormCell *fieldStartwerteAG;
  IBOutlet NSFormCell *fieldStartwerteHA;
  IBOutlet NSFormCell *fieldStartwerteRA;
  IBOutlet NSFormCell *fieldStartwerteTA;
  IBOutlet NSFormCell *fieldStartwerteNG;              
  IBOutlet NSFormCell *fieldStartwerteGG;
  IBOutlet NSFormCell *fieldStartwerteJZ;
  
  IBOutlet NSWindow      *windowCharDef;
  IBOutlet NSPopUpButton *popupWinCharDefTypus;
  IBOutlet NSPopUpButton *popupWinCharDefHerkunft;
  IBOutlet NSPopUpButton *popupWinCharDefBeruf;
  IBOutlet NSPopUpButton *popupWinCharDefMagierakademie;
  IBOutlet NSButton      *buttonCharDefCharGen;
  
  IBOutlet NSWindow      *windowCharGen;
  IBOutlet NSTextField   *fieldCharGenTypus;
  IBOutlet NSTextField   *fieldCharGenHerkunft;
  IBOutlet NSTextField   *fieldCharGenBeruf;
  IBOutlet NSTextField   *fieldCharGenAkademie;
  IBOutlet NSTextField   *fieldCharGenMU;
  IBOutlet NSTextField   *fieldCharGenMUC;
  IBOutlet NSTextField   *fieldCharGenKL;
  IBOutlet NSTextField   *fieldCharGenKLC;
  IBOutlet NSTextField   *fieldCharGenIN;
  IBOutlet NSTextField   *fieldCharGenINC;  
  IBOutlet NSTextField   *fieldCharGenCH;
  IBOutlet NSTextField   *fieldCharGenCHC;
  IBOutlet NSTextField   *fieldCharGenFF;
  IBOutlet NSTextField   *fieldCharGenFFC;
  IBOutlet NSTextField   *fieldCharGenGE;
  IBOutlet NSTextField   *fieldCharGenGEC;
  IBOutlet NSTextField   *fieldCharGenKK;
  IBOutlet NSTextField   *fieldCharGenKKC;
  IBOutlet NSTextField   *fieldCharGenAG;
  IBOutlet NSTextField   *fieldCharGenAGC;
  IBOutlet NSTextField   *fieldCharGenHA;
  IBOutlet NSTextField   *fieldCharGenHAC;
  IBOutlet NSTextField   *fieldCharGenRA;
  IBOutlet NSTextField   *fieldCharGenRAC;
  IBOutlet NSTextField   *fieldCharGenTA;
  IBOutlet NSTextField   *fieldCharGenTAC;
  IBOutlet NSTextField   *fieldCharGenNG;
  IBOutlet NSTextField   *fieldCharGenNGC;
  IBOutlet NSTextField   *fieldCharGenGG;
  IBOutlet NSTextField   *fieldCharGenGGC;                              
  IBOutlet NSTextField   *fieldCharGenJZ;                      
  IBOutlet NSTextField   *fieldCharGenJZC;
  IBOutlet NSButton      *buttonCharGenGenerieren;
  IBOutlet NSButton      *buttonCharGenAuswahl;
  
}

+ (void)  initialize;

- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application
	    openFile: (NSString *)fileName;

- (void) showPrefPanel: (id)sender;
- (void) showCharDefWindow: (id)sender;
- (void) showCharGenWindow: (id)sender;
- (void) showCharacterStartwerte: (id)sender;
- (void) updateCharacterStartwerte: (id)sender;

- (void) popupCharDefTypusSelected: (id)sender;

@end

#endif
