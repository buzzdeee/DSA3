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

@class Utils;
@class Charakter;

@interface AppController : NSObject
{
  Utils *utils;
  Charakter *aktiverCharakter;
  NSMutableDictionary *charGenStateDict;
  NSInteger enableButtonCharGenAuswahl;
  
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
  
  /* Carakter definieren */
  IBOutlet NSWindow      *windowCharDef;
  IBOutlet NSPopUpButton *popupWinCharDefTypus;
  IBOutlet NSPopUpButton *popupWinCharDefHerkunft;
  IBOutlet NSPopUpButton *popupWinCharDefBeruf;
  IBOutlet NSPopUpButton *popupWinCharDefMagierakademie;
  IBOutlet NSButton      *buttonCharDefCharGen;
  
  /* Charakter generieren */
  IBOutlet NSWindow      *windowCharGen;
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
  IBOutlet NSTextField   *fieldCharGenName;
  IBOutlet NSTextField   *fieldCharGenTitel;  
  IBOutlet NSTextField   *fieldCharGenHaarfarbe;
  IBOutlet NSTextField   *fieldCharGenAugenfarbe;    
  IBOutlet NSTextField   *fieldCharGenGeburtstag;
  IBOutlet NSTextField   *fieldCharGenGottheit;
  IBOutlet NSTextField   *fieldCharGenSterne;
  IBOutlet NSTextField   *fieldCharGenGroesse;
  IBOutlet NSTextField   *fieldCharGenGewicht;
  IBOutlet NSTextField   *fieldCharGenStand;
  IBOutlet NSTextField   *fieldCharGenEltern;
  IBOutlet NSTextField   *fieldCharGenGeld;
  IBOutlet NSPopUpButton *popupCharGenGeschlecht; 
  IBOutlet NSButton      *buttonCharGenMU;         
  IBOutlet NSButton      *buttonCharGenKL;         
  IBOutlet NSButton      *buttonCharGenIN;         
  IBOutlet NSButton      *buttonCharGenCH;         
  IBOutlet NSButton      *buttonCharGenFF;         
  IBOutlet NSButton      *buttonCharGenGE;         
  IBOutlet NSButton      *buttonCharGenKK;         
  IBOutlet NSButton      *buttonCharGenAG;         
  IBOutlet NSButton      *buttonCharGenHA;         
  IBOutlet NSButton      *buttonCharGenRA;         
  IBOutlet NSButton      *buttonCharGenTA;         
  IBOutlet NSButton      *buttonCharGenNG;         
  IBOutlet NSButton      *buttonCharGenGG;         
  IBOutlet NSButton      *buttonCharGenJZ;
                                     
  IBOutlet NSWindow      *windowCharLoad;
  IBOutlet NSPopUpButton *popupCharLoadAuswahl; 
  
  IBOutlet NSWindow      *windowTalente;
  IBOutlet NSTextField   *fieldTalenteMU;
  IBOutlet NSTextField   *fieldTalenteKL;
  IBOutlet NSTextField   *fieldTalenteIN;
  IBOutlet NSTextField   *fieldTalenteCH;
  IBOutlet NSTextField   *fieldTalenteFF;
  IBOutlet NSTextField   *fieldTalenteGE;
  IBOutlet NSTextField   *fieldTalenteKK;            
  
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
//- (void) showCharDefWindow: (id)sender;
- (IBAction) showCharGenWindow: (id)sender;
- (IBAction) showTalenteWindow: (id)sender;
- (IBAction) showCharLoadWindow: (id)sender;
- (void) showCharacterStartwerte: (id)sender;
- (void) updateCharacterStartwerte: (id)sender;

- (void) popupCharDefTypusSelected: (id)sender;
- (void) farbeFuerEigenschaftsfeldSetzen: (NSString *) feldName;
- (void) testButtonCharGenAuswahlEnable;

- (IBAction) charGenTextFieldUpdated: (id)sender;
- (IBAction) showCharacterWindow: (id)sender;

- (IBAction) buttonCharGenPosEigenschaften: (id)sender;
- (IBAction) buttonCharGenNegEigenschaften: (id)sender;
@end

#endif
