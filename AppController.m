/* 
   Project: DSA3

   Author: Sebastian Reitenbach

   Created: 2024-07-12 22:42:06 +0200 by sebastia
   
   Application Controller
*/

#import "AppController.h"
#import "CharacterStartwerte.h"

@implementation AppController

+ (void) initialize
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  /*
   * Register your app's defaults here by adding objects to the
   * dictionary, eg
   *
   * [defaults setObject:anObject forKey:keyForThatObject];
   *
   */
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init
{
  if ((self = [super init]))
    {
      //CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
      //allCharacterTypes = [[NSPopUpButton alloc] init];
      //[allCharacterTypes addItemsWithTitles: [characterStartwerte allCharacterTypes]];

      //NSLog(@"HERE IN AppController: %@", [allCharacterTypes itemTitles]);
    }
  return self;
}

- (void) dealloc
{
  [super dealloc];
}

- (void) awakeFromNib
{
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif
{

}

- (BOOL) applicationShouldTerminate: (id)sender
{
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif
{
}

- (BOOL) application: (NSApplication *)application
	    openFile: (NSString *)fileName
{
  return NO;
}

- (void) showPrefPanel: (id)sender
{
}

- (IBAction) showCharacterStartwerte: (id)sender
{
      //theText = [[NSTextField alloc] init];
NSLog(@"showCharacterStartwerte got called");
CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
[popupCharacterChooser removeAllItems];
[popupCharacterChooser addItemsWithTitles: [characterStartwerte getCharacterTypesList]];
[windowCharacterStartwerte makeKeyAndOrderFront: self];
}

- (IBAction) selectCharacterType: (id)sender
{
  //[allCharacterTypes addItemsWithTitles:[characterConstraints allKeys]];
}  
  
- (void) showCharDefWindow: (id)sender
{
  NSLog(@"showCharDefWindow was called!");
  CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
  [popupWinCharDefTypus addItemsWithTitles: [characterStartwerte getCharacterTypesList]];
  [popupWinCharDefHerkunft addItemsWithTitles: [characterStartwerte getHerkunftList]];
  [popupWinCharDefBeruf addItemsWithTitles: [characterStartwerte getBerufeList]];
  [popupWinCharDefMagierakademie addItemsWithTitles: [characterStartwerte getMagierakademienList]];    
  [popupWinCharDefHerkunft setEnabled: NO];
  [popupWinCharDefBeruf setEnabled: NO];
  [popupWinCharDefMagierakademie setEnabled: NO];
  //[buttonWinCharDefCharGen setEnabled: NO];
  [windowCharDef makeKeyAndOrderFront: self];
}  

- (void) popupCharDefTypusSelected: (id)sender
{
  CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
  NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [characterStartwerte getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  
  [characterStartwerte getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]];
  if ( [[[popupWinCharDefTypus selectedItem] title] isEqualToString: @"Magier"] )
    {
      [popupWinCharDefMagierakademie setEnabled: YES];
    }
  else
    {
      [popupWinCharDefMagierakademie selectItemAtIndex: 0];    
      [popupWinCharDefMagierakademie setEnabled: NO];    
    }
  if ( [[charConstraints valueForKey: @"Herkunftmodifikator"] boolValue] == YES )
    {
      [popupWinCharDefHerkunft setEnabled: YES];
    }
  else
    {
      [popupWinCharDefHerkunft selectItemAtIndex: 0];
      [popupWinCharDefHerkunft setEnabled: NO];
    }
  if ( [[charConstraints valueForKey: @"Berufmodifikator"] boolValue] == YES )
    {
      [popupWinCharDefBeruf setEnabled: YES];
    }
  else
    {
      [popupWinCharDefBeruf selectItemAtIndex: 0];
      [popupWinCharDefBeruf setEnabled: NO];
    }
}

- (void) showCharGenWindow: (id)sender
{
  NSLog(@"showCharGenWindow was called!");
  CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
  NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [characterStartwerte getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  NSDictionary *eigenschaftenDict = [NSDictionary dictionaryWithDictionary: [charConstraints objectForKey: @"Eigenschaften"]];
  
  [windowCharDef setIsVisible: NO];
  [fieldCharGenTypus setStringValue: [[popupWinCharDefTypus selectedItem] title]];
  if ([popupWinCharDefHerkunft indexOfSelectedItem] == 0)
    {
      [fieldCharGenHerkunft setStringValue: @"Mittlereich"];
    }
  else
    {
      [fieldCharGenHerkunft setStringValue: [[popupWinCharDefHerkunft selectedItem] title]];
    }
  if ([popupWinCharDefBeruf indexOfSelectedItem] == 0)
    {
      [fieldCharGenBeruf setStringValue: @"Ohne Beruf"];
    }
  else
    {
      [fieldCharGenBeruf setStringValue: [[popupWinCharDefBeruf selectedItem] title]];
    }
  if ([popupWinCharDefMagierakademie indexOfSelectedItem] == 0)
    {
      [fieldCharGenAkademie setStringValue: @"N/A"];
    }
  else
    {
      [fieldCharGenAkademie setStringValue: [[popupWinCharDefMagierakademie selectedItem] title]];
    }

  if ([eigenschaftenDict objectForKey: @"MU"] == nil)
    {
      [fieldCharGenMUC setStringValue: @""];
    }
  else
    {
      [fieldCharGenMUC setStringValue: [eigenschaftenDict objectForKey: @"MU"]];
    }
  if ([eigenschaftenDict objectForKey: @"KL"] == nil)
    {
      [fieldCharGenKLC setStringValue: @""];
    }
  else
    {
      [fieldCharGenKLC setStringValue: [eigenschaftenDict objectForKey: @"KL"]];
    }
  if ([eigenschaftenDict objectForKey: @"IN"] == nil)
    {
      [fieldCharGenINC setStringValue: @""];
    }
  else
    {
      [fieldCharGenINC setStringValue: [eigenschaftenDict objectForKey: @"IN"]];
    }
  if ([eigenschaftenDict objectForKey: @"CH"] == nil)
    {
      [fieldCharGenCHC setStringValue: @""];
    }
  else
    {
      [fieldCharGenCHC setStringValue: [eigenschaftenDict objectForKey: @"CH"]];
    }
  if ([eigenschaftenDict objectForKey: @"FF"] == nil)
    {
      [fieldCharGenFFC setStringValue: @""];
    }
  else
    {
      [fieldCharGenFFC setStringValue: [eigenschaftenDict objectForKey: @"FF"]];
    }
  if ([eigenschaftenDict objectForKey: @"GE"] == nil)
    {
      [fieldCharGenGEC setStringValue: @""];
    }
  else
    {
      [fieldCharGenGEC setStringValue: [eigenschaftenDict objectForKey: @"GE"]];
    }
  if ([eigenschaftenDict objectForKey: @"KK"] == nil)
    {
      [fieldCharGenKKC setStringValue: @""];
    }
  else
    {
      [fieldCharGenKKC setStringValue: [eigenschaftenDict objectForKey: @"KK"]];
    }
  if ([eigenschaftenDict objectForKey: @"AG"] == nil)
    {
      [fieldCharGenAGC setStringValue: @""];
    }
  else
    {
      [fieldCharGenAGC setStringValue: [eigenschaftenDict objectForKey: @"AG"]];
    }
  if ([eigenschaftenDict objectForKey: @"HA"] == nil)
    {
      [fieldCharGenHAC setStringValue: @""];
    }
  else
    {
      [fieldCharGenHAC setStringValue: [eigenschaftenDict objectForKey: @"HA"]];
    }
  if ([eigenschaftenDict objectForKey: @"RA"] == nil)
    {
      [fieldCharGenRAC setStringValue: @""];
    }
  else
    {
      [fieldCharGenRAC setStringValue: [eigenschaftenDict objectForKey: @"RA"]];
    }
  if ([eigenschaftenDict objectForKey: @"TA"] == nil)
    {
      [fieldCharGenTAC setStringValue: @""];
    }
  else
    {
      [fieldCharGenTAC setStringValue: [eigenschaftenDict objectForKey: @"TA"]];
    }
  if ([eigenschaftenDict objectForKey: @"NG"] == nil)
    {
      [fieldCharGenNGC setStringValue: @""];
    }
  else
    {
      [fieldCharGenNGC setStringValue: [eigenschaftenDict objectForKey: @"NG"]];
    }
  if ([eigenschaftenDict objectForKey: @"GG"] == nil)
    {
      [fieldCharGenGGC setStringValue: @""];
    }
  else
    {
      [fieldCharGenGGC setStringValue: [eigenschaftenDict objectForKey: @"GG"]];
    }
      
  if ([eigenschaftenDict objectForKey: @"JZ"] == nil)
    {
      [fieldCharGenJZC setStringValue: @""];
    }
  else
    {
      [fieldCharGenJZC setStringValue: [eigenschaftenDict objectForKey: @"JZ"]];
    }

  [windowCharGen makeKeyAndOrderFront: self];
} 

- (IBAction) updateCharacterStartwerte: (id)sender
{
  NSLog(@"HERE IN AppController updateCharacterType: %@", [[popupCharacterChooser selectedItem] title]);
  NSString *characterType = [[popupCharacterChooser selectedItem] title];
  NSLog(@"%@", characterType);
  CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
  NSDictionary *characterConstraints = [characterStartwerte getCharacterConstraintsForCharacter: characterType];
  NSDictionary *eigenschaften = [characterConstraints objectForKey: @"Eigenschaften"];
  //NSArray *eigenschaftsKeys = [[NSArray arrayWithArray: [ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ]];
  NSArray *characterKeys = [NSArray arrayWithArray: [eigenschaften allKeys]];
  if ([characterKeys containsObject: @"MU"])
    {
      [fieldStartwerteMU setStringValue:[eigenschaften objectForKey: @"MU"]];
    }
  else
    {
      [fieldStartwerteMU setStringValue: @""];
    }
  if ([characterKeys containsObject: @"KL"])
    {
      [fieldStartwerteKL setStringValue: [eigenschaften objectForKey: @"KL"]];
    }
  else
    {
      [fieldStartwerteKL setStringValue: @""];
    }  
  if ([characterKeys containsObject: @"IN"])
    {
      [fieldStartwerteIN setStringValue: [eigenschaften objectForKey: @"IN"]];
    }
  else
    {
      [fieldStartwerteIN setStringValue: @""];
    } 
  if ([characterKeys containsObject: @"CH"])
    {
      [fieldStartwerteCH setStringValue: [eigenschaften objectForKey: @"CH"]];
    }
  else
    {
      [fieldStartwerteCH setStringValue: @""];
    } 
/*  if ([characterKeys containsObject: @""])
    {
      [fieldStartwerte setStringValue: [eigenschaften objectForKey: @""]];
    }
  else
    {
      [fieldStartwerte setStringValue: @""];
    }     
*/
    
      NSLog(@"%@", eigenschaften);

}

@end
