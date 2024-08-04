/* 
   Project: DSA3

   Author: Sebastian Reitenbach

   Created: 2024-07-12 22:42:06 +0200 by sebastia
   
   Application Controller
*/

#import "AppController.h"
#import "CharacterStartwerte.h"
#import "Charakter.h"
#import "Utils.h"

@implementation AppController

+ (void) initialize
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  //NSPasteboard *charGenPosEigPB = [NSPasteboard pasteboardWithName: @"charGenPosEigPB"];
  //NSPasteboard *charGenNegEigPB = [NSPasteboard pasteboardWithName: @"charGenNegEigPB"];
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
      utils = [Utils sharedInstance];
      aktiverCharakter = [[Charakter alloc] init];
      charGenStateDict = [[NSMutableDictionary alloc] init];
      [charGenStateDict setObject: @"" forKey: @"activePosButton"];
      [charGenStateDict setObject: @"" forKey: @"activeNegButton"];     
      enableButtonCharGenAuswahl = 0; 
    }
  return self;
}

- (void) dealloc
{

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


- (IBAction) showCharLoadWindow: (id)sender
{
  [windowCharLoad makeKeyAndOrderFront: self];
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

  NSLog(@"popupCharDefTypusSelected got called");
  
  if ([popupWinCharDefTypus indexOfSelectedItem] != 0)
    {
  
      NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [utils getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  
      [utils getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]];
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
          
        }
      [buttonCharGenGenerieren setEnabled: YES];
      
      [fieldCharGenMU setTextColor: [NSColor blackColor]];
      [fieldCharGenMU setStringValue: @""];
      [fieldCharGenKL setTextColor: [NSColor blackColor]];
      [fieldCharGenKL setStringValue: @""];
      [fieldCharGenIN setTextColor: [NSColor blackColor]];
      [fieldCharGenIN setStringValue: @""];
      [fieldCharGenCH setTextColor: [NSColor blackColor]];
      [fieldCharGenCH setStringValue: @""];
      [fieldCharGenFF setTextColor: [NSColor blackColor]];
      [fieldCharGenFF setStringValue: @""];
      [fieldCharGenGE setTextColor: [NSColor blackColor]];
      [fieldCharGenGE setStringValue: @""];
      [fieldCharGenKK setTextColor: [NSColor blackColor]];
      [fieldCharGenKK setStringValue: @""];
      [fieldCharGenAG setTextColor: [NSColor blackColor]];
      [fieldCharGenAG setStringValue: @""];      
      [fieldCharGenHA setTextColor: [NSColor blackColor]];
      [fieldCharGenHA setStringValue: @""];      
      [fieldCharGenRA setTextColor: [NSColor blackColor]];
      [fieldCharGenRA setStringValue: @""];      
      [fieldCharGenTA setTextColor: [NSColor blackColor]];
      [fieldCharGenTA setStringValue: @""];
      [fieldCharGenNG setTextColor: [NSColor blackColor]];
      [fieldCharGenNG setStringValue: @""];
      [fieldCharGenGG setTextColor: [NSColor blackColor]];
      [fieldCharGenGG setStringValue: @""];            
      [fieldCharGenJZ setTextColor: [NSColor blackColor]];
      [fieldCharGenJZ setStringValue: @""];
      [fieldCharGenHaarfarbe setStringValue: @""];
      [fieldCharGenAugenfarbe setStringValue: @""];      
      [fieldCharGenGroesse setStringValue: @""];            
      [fieldCharGenGewicht setStringValue: @""];            
      [fieldCharGenGeburtstag setStringValue: @""];            
      [fieldCharGenGottheit setStringValue: @""];            
      [fieldCharGenSterne setStringValue: @""];                              
      [fieldCharGenStand setStringValue: @""];                              
      [fieldCharGenEltern setStringValue: @""];                                    
            
      NSLog(@"selectedItem: %@", [[popupWinCharDefTypus selectedItem] title]);

      NSLog(@"charConstraints: %@", charConstraints);
      NSDictionary *eigenschaftenDict = [NSDictionary dictionaryWithDictionary: [charConstraints objectForKey: @"Eigenschaften"]];
  
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
    }
  else
    {
      [buttonCharGenGenerieren setEnabled: NO];
      [buttonCharGenAuswahl setEnabled: NO];
      [popupWinCharDefMagierakademie setEnabled: NO];      
    }  
}

- (void) showCharGenWindow: (id)sender
{
  NSLog(@"showCharGenWindow was called!");
    
  [popupWinCharDefTypus addItemsWithTitles: [[utils typusDict] allKeys]];
  [popupWinCharDefHerkunft addItemsWithTitles: [[utils herkunftDict] allKeys]];
  [popupWinCharDefBeruf addItemsWithTitles: [[utils berufeDict] allKeys]];
  [popupWinCharDefMagierakademie addItemsWithTitles: [[utils magierakademienDict] allKeys]];    
  [popupWinCharDefHerkunft setEnabled: NO];
  [popupWinCharDefBeruf setEnabled: NO];
  [popupWinCharDefMagierakademie setEnabled: NO];
  [buttonCharGenGenerieren setEnabled: NO];  
  [buttonCharGenAuswahl setEnabled: NO];
  [fieldCharGenName setEnabled: NO];
  [fieldCharGenTitel setEnabled: NO];
    
  

  [windowCharGen makeKeyAndOrderFront: self];
} 

- (IBAction) charGenTextFieldUpdated: (id)sender
{
  if ([[sender stringValue] length] > 0)
    {
      [sender setBackgroundColor: [NSColor whiteColor]];
    }
  else
    {
      [sender setBackgroundColor: [NSColor redColor]];
    }
  [self testButtonCharGenAuswahlEnable];    
}

- (IBAction)generiereBasiswerte: (id)sender
{
  NSLog(@"HERE in generiereBasiswerte");
  CharacterStartwerte *characterStartwerte = [[CharacterStartwerte alloc] init];
  NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [characterStartwerte getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  NSArray *positiveArr = [NSArray arrayWithArray: [utils positiveEigenschaftenGenerieren]];
  NSArray *negativeArr = [NSArray arrayWithArray: [utils negativeEigenschaftenGenerieren]];
  NSDictionary *haarConstraints = [charConstraints objectForKey: @"Haarfarbe"];
  NSDictionary *geburtstag = [[NSDictionary alloc] init];
  NSDictionary *herkunftEltern = [utils famHerkunftGenerieren: [[popupWinCharDefTypus selectedItem] title]];
  NSDictionary *startvermoegenDict = [utils startvermoegenGenerieren: [herkunftEltern objectForKey: @"Stand"]];
  
  
  NSLog(@"HERE in generiereBasiswerte: %@", positiveArr);

  [fieldCharGenHaarfarbe setStringValue: [utils haarfarbeVonConstraintGenerieren: haarConstraints]];
  [fieldCharGenAugenfarbe setStringValue: [utils augenfarbeVonHaarfarbeGenerieren: [fieldCharGenHaarfarbe stringValue]]];  
  geburtstag = [utils geburtstagGenerieren];
  [fieldCharGenGeburtstag setStringValue: [geburtstag objectForKey: @"Datum"]];
  [fieldCharGenGottheit setStringValue: [geburtstag objectForKey: @"Monat"]];
  [fieldCharGenGroesse setStringValue: [utils groesseGenerieren: [[popupWinCharDefTypus selectedItem] title]]];
  [fieldCharGenGewicht setStringValue: [utils gewichtGenerieren: [[popupWinCharDefTypus selectedItem] title] groesse: [fieldCharGenGroesse stringValue]]];
  [fieldCharGenName setEnabled: YES];
  [fieldCharGenTitel setEnabled: YES];
  
  if ([[fieldCharGenName stringValue] length] > 0)
    {
      [fieldCharGenName setBackgroundColor: [NSColor whiteColor]];
    }
  else
    {
      [fieldCharGenName setBackgroundColor: [NSColor redColor]];    
    }
  if ([[fieldCharGenTitel stringValue] length] > 0)
    {
      [fieldCharGenTitel setBackgroundColor: [NSColor whiteColor]];
    }
  else
    {
      [fieldCharGenTitel setBackgroundColor: [NSColor redColor]];    
    }
    
  [fieldCharGenStand setStringValue: [herkunftEltern objectForKey: @"Stand"]];
  [fieldCharGenEltern setStringValue: [herkunftEltern objectForKey: @"Eltern"]];
  [fieldCharGenGeld setStringValue: [NSString stringWithFormat: @"%@D %@S %@H %@K", [startvermoegenDict objectForKey: @"D"], [startvermoegenDict objectForKey: @"S"], [startvermoegenDict objectForKey: @"H"], [startvermoegenDict objectForKey: @"K"]]];
  [fieldCharGenSterne setStringValue: [[[utils goetterDict] objectForKey: [geburtstag objectForKey: @"Monat"]] objectForKey: @"Sternbild"]];
  
  // positive Eigenschaften
  
  int i = 0;
  for (NSString *field in [NSArray arrayWithObjects: @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", nil ])
    {
      [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setStringValue: [positiveArr objectAtIndex: i]];
      [self farbeFuerEigenschaftsfeldSetzen: field];
      i++;
    }
        
  // Negative Eigenschaften
  i = 0;
  for (NSString *field in [NSArray arrayWithObjects: @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ", nil ])
    {
      [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setStringValue: [negativeArr objectAtIndex: i]];
      [self farbeFuerEigenschaftsfeldSetzen: field];
      i++;
    }
      
  [self testButtonCharGenAuswahlEnable];
//  [buttonCharGenAuswahl setEnabled: enableButtonCharGenAuswahl];
}

- (void) testButtonCharGenAuswahlEnable
{
  for (NSString *field in [NSArray arrayWithObjects: @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ", nil ])
    {
      NSLog(@"testButtonCharGenAuswahlEnable  testing: %@", field);
      if ([[[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] backgroundColor] isEqualTo: [NSColor redColor]])
        {
          [buttonCharGenAuswahl setEnabled: NO];
          return;
        }
    }
  if ([[fieldCharGenName backgroundColor] isEqualTo: [NSColor redColor]] || [[fieldCharGenTitel backgroundColor] isEqualTo: [NSColor redColor]])
    {
      [buttonCharGenAuswahl setEnabled: NO];    
    }
  else
    {
      [buttonCharGenAuswahl setEnabled: YES];
    }
} 

- (void) farbeFuerEigenschaftsfeldSetzen: (NSString *) feldName
{
  NSString *eigenschaftsFeldName = [NSString stringWithFormat: @"fieldCharGen%@", feldName];
  NSString *constraintFeldName = [NSString stringWithFormat: @"fieldCharGen%@C", feldName];
  NSMutableDictionary *constraint = [[NSMutableDictionary alloc] init];
  NSTextField *eigenschaftsFeld = [[NSTextField alloc] init];
  NSTextField *constraintFeld = [[NSTextField alloc] init];
  eigenschaftsFeld = [self valueForKey: eigenschaftsFeldName];
  constraintFeld = [self valueForKey: constraintFeldName];
  
  if ([[constraintFeld stringValue] length] > 0)
    {
      [constraint removeAllObjects];
      [constraint addEntriesFromDictionary: [Utils parseConstraint: [constraintFeld stringValue]]];
      if ([[constraint objectForKey: @"Constraint"] isEqualToString: @"MAX"])
        {
          if ([[eigenschaftsFeld stringValue] integerValue] < [[constraint objectForKey: @"Wert"] integerValue])
            {
              [eigenschaftsFeld setBackgroundColor: [NSColor redColor]];
            }
          else
            {
              [eigenschaftsFeld setBackgroundColor: [NSColor whiteColor]];
            }
        }
      else
        {
          if ([[eigenschaftsFeld stringValue] integerValue] > [[constraint objectForKey: @"Wert"] integerValue])
            {
              [eigenschaftsFeld setBackgroundColor: [NSColor redColor]];
            }        
          else
            {
              [eigenschaftsFeld setBackgroundColor: [NSColor whiteColor]];
            }            
        }
    }
}

- (IBAction) buttonCharGenPosEigenschaften: (id)sender
{
  NSLog(@"buttonCharGenPosEigenschaften: sender: %@", sender);
  NSLog(@"buttonCharGenPosEigenschaften: sender title: %@", [sender title]);
  NSLog(@"buttonCharGenPosEigenschaften: sender state: %i", [sender state]);
  NSLog(@"current charGenStateDict: %@", charGenStateDict);  

  
  /* in case two buttons are marked, then the related fields are supposed
     to exchange values, and button state to be reset */         
  if ([sender state] == 1 && [[charGenStateDict objectForKey: @"activePosButton"] length] > 0)
    {
       NSLog(@"sender state was 1 AND activePosButton length > 0");
       NSString *tmpVal = [[self valueForKey:[NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue];
       NSString *otherField = [NSString stringWithString: [charGenStateDict objectForKey: @"activePosButton"]];
       NSLog(@"tmpVal: %@ otherField value: %@", tmpVal, otherField);
       NSLog(@"the other field name: %@", [NSString stringWithFormat: @"fieldCharGen%@", otherField]);
       [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", otherField]] setStringValue: tmpVal];
       [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] setStringValue: [charGenStateDict objectForKey: otherField]];
       NSLog(@"the other fields value now is: %@", [self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", otherField]]);
       [sender setState: 0];
       [[self valueForKey: [NSString stringWithFormat: @"buttonCharGen%@", otherField]] setState: 0];
       [charGenStateDict setObject: @"" forKey: @"activePosButton"];
       [charGenStateDict removeObjectForKey: otherField];
       NSLog(@"YIKES");
       [self farbeFuerEigenschaftsfeldSetzen: [sender title]];
              NSLog(@"BLARGH");
       [self farbeFuerEigenschaftsfeldSetzen: otherField];
                     NSLog(@"AAARGH");
       [self testButtonCharGenAuswahlEnable];
       return;
    }
  
  /* a button is pressed, and the same button pressed again */
  if ([sender state] == 0)
    {
      NSLog(@"sender state == 0");
      [charGenStateDict setObject: @"" forKey: @"activePosButton"];
      [charGenStateDict removeObjectForKey: [sender title]];
      NSLog(@"BOOM: current state dict:  %@", charGenStateDict);
      [self testButtonCharGenAuswahlEnable];      
      return;
    }
  else if ([sender state] == 1)
    {
      
      NSLog(@"just Sender State == 1");
      [charGenStateDict setObject: [sender title] forKey: @"activePosButton"];
      NSLog(@"BANG: current state dict:  %@", charGenStateDict);
      NSLog(@"field name generated: %@", [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]);
      NSLog(@"returned field value: %@", [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue]);
      [charGenStateDict setObject: [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue]
                           forKey: [sender title]];
      NSLog(@"BOOM: current state dict:  %@", charGenStateDict);
      [self testButtonCharGenAuswahlEnable];      
    }  
}
- (IBAction) buttonCharGenNegEigenschaften: (id)sender
{
  NSLog(@"buttonCharGenNegEigenschaften: sender: %@", sender);
  NSLog(@"buttonCharGenNegEigenschaften: sender title: %@", [sender title]);
  NSLog(@"buttonCharGenNegEigenschaften: sender state: %i", [sender state]);
  NSLog(@"current charGenStateDict: %@", charGenStateDict);  

  
  /* in case two buttons are marked, then the related fields are supposed
     to exchange values, and button state to be reset */         
  if ([sender state] == 1 && [[charGenStateDict objectForKey: @"activeNegButton"] length] > 0)
    {
       NSLog(@"sender state was 1 AND activeNegButton length > 0");
       NSString *tmpVal = [[self valueForKey:[NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue];
       NSString *otherField = [NSString stringWithString: [charGenStateDict objectForKey: @"activeNegButton"]];
       NSLog(@"tmpVal: %@ otherField value: %@", tmpVal, otherField);
       NSLog(@"the other field name: %@", [NSString stringWithFormat: @"fieldCharGen%@", otherField]);
       [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", otherField]] setStringValue: tmpVal];
       [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] setStringValue: [charGenStateDict objectForKey: otherField]];
       NSLog(@"the other fields value now is: %@", [self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", otherField]]);
       [sender setState: 0];
       [[self valueForKey: [NSString stringWithFormat: @"buttonCharGen%@", otherField]] setState: 0];
       [charGenStateDict setObject: @"" forKey: @"activeNegButton"];
       [charGenStateDict removeObjectForKey: otherField];

       [self farbeFuerEigenschaftsfeldSetzen: [sender title]];
       [self farbeFuerEigenschaftsfeldSetzen: otherField];
       
       return;
    }
  
  /* a button is pressed, and the same button pressed again */
  if ([sender state] == 0)
    {
      NSLog(@"sender state == 0");
      [charGenStateDict setObject: @"" forKey: @"activeNegButton"];
      [charGenStateDict removeObjectForKey: [sender title]];
      NSLog(@"BOOM: current state dict:  %@", charGenStateDict);
      return;
    }
  else if ([sender state] == 1)
    {
      
      NSLog(@"just Sender State == 1");
      [charGenStateDict setObject: [sender title] forKey: @"activeNegButton"];
      NSLog(@"BANG: current state dict:  %@", charGenStateDict);
      NSLog(@"field name generated: %@", [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]);
      NSLog(@"returned field value: %@", [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue]);
      [charGenStateDict setObject: [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", [sender title]]] stringValue]
                           forKey: [sender title]];
      NSLog(@"BOOM: current state dict:  %@", charGenStateDict);
    }
  [self testButtonCharGenAuswahlEnable];
    
}



- (IBAction) showCharacterWindow: (id)sender
{
  NSLog(@"showCharacterWindow got called!");
  [aktiverCharakter setName: [fieldCharGenName stringValue]];
  [aktiverCharakter setTitel: [fieldCharGenTitel stringValue]];
  //[NSKeyedArchiver archiveRootObject: aktiverCharakter toFile:@"/tmp/charakter.plist"];


  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [[documentsDirectoryPath stringByAppendingPathComponent:@"DSA3"] stringByAppendingPathComponent:@"Characters"];
    NSString *fileName = [NSString stringWithFormat:@"%@.plist", [aktiverCharakter name]];
    [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:nil];
    [NSKeyedArchiver archiveRootObject: aktiverCharakter toFile: [filePath stringByAppendingPathComponent: fileName]];
  
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
