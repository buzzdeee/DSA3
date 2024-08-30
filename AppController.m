/* 
   Project: DSA3

   Author: Sebastian Reitenbach

   Created: 2024-07-12 22:42:06 +0200 by sebastia
   
   Application Controller
*/

#import "AppController.h"
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
      
      // add observers to the aktiverCharakter
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.MU" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.KL" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.IN" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.CH" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.FF" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.GE" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"positiveEigenschaften.KK" options: NSKeyValueObservingOptionNew context: nil];
      [aktiverCharakter addObserver: self forKeyPath:@"steigerungsTalente.verbleibendeVersuche" options: NSKeyValueObservingOptionNew context: nil];
          
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

- (IBAction) selectCharacterType: (id)sender
{
  //[allCharacterTypes addItemsWithTitles:[characterConstraints allKeys]];
}  


- (IBAction) showCharLoadWindow: (id)sender
{
  [windowCharLoad makeKeyAndOrderFront: self];
}  

- (void) popupCharDefTypusSelected: (id)sender
{

  NSLog(@"popupCharDefTypusSelected got called");
  
  [aktiverCharakter setTypus: [[popupWinCharDefTypus selectedItem] title]];
  
  NSLog(@"aktiverCharakter: %@ %@", [aktiverCharakter typus], aktiverCharakter);
  
  if ([popupWinCharDefTypus indexOfSelectedItem] != 0)
    {
  
      NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [utils getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
      NSLog(@"charConstraints: %@", charConstraints);
      
      if ( [[[popupWinCharDefTypus selectedItem] title] isEqualToString: @"Magier"] )
        {
          [popupWinCharDefMagischeSchule setEnabled: YES];
          [popupWinCharDefMagischeSchule removeAllItems];
          [popupWinCharDefMagischeSchule addItemsWithTitles: [[utils magierakademienDict] allKeys]];
          [fieldCharDefMagischeSchule setStringValue: @"Magierakademie"];
        }
      else if ( [[[popupWinCharDefTypus selectedItem] title] isEqualToString: @"Geode"] )
        {
          [popupWinCharDefMagischeSchule setEnabled: YES];
          [popupWinCharDefMagischeSchule removeAllItems];
          [popupWinCharDefMagischeSchule addItemsWithTitles: [charConstraints objectForKey: @"Schule"]];
          [fieldCharDefMagischeSchule setStringValue: @"Geodische Fakultät"];
        }
      else
        {
          [popupWinCharDefMagischeSchule selectItemAtIndex: 0];    
          [popupWinCharDefMagischeSchule setEnabled: NO];   
          [popupWinCharDefMagischeSchule setTitle: @"Schule"];  
          [fieldCharDefMagischeSchule setStringValue: @"Magische Schule"];
        }
        
      // Die Herkünfte
      [popupWinCharDefHerkunft removeAllItems];
      [popupWinCharDefHerkunft addItemsWithTitles: [utils getHerkuenfteForTypus: [aktiverCharakter typus]]];
      if ([popupWinCharDefHerkunft numberOfItems] == 1)
        {
          [popupWinCharDefHerkunft setEnabled: NO];        
        }
      else
        {
          [popupWinCharDefHerkunft setEnabled: YES];        
        }        
                
      // Die Berufe
      [popupWinCharDefBeruf removeAllItems];
      [popupWinCharDefBeruf addItemsWithTitles: [utils getBerufeForTypus: [aktiverCharakter typus]]];
      if ([popupWinCharDefBeruf numberOfItems] == 1)
        {
          [popupWinCharDefBeruf setEnabled: NO];        
        }
      else
        {
          [popupWinCharDefBeruf setEnabled: YES];        
        }
      
      [buttonCharGenGenerieren setEnabled: YES];

      
      for (NSString *field in [NSArray arrayWithObjects: @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", 
                                                        @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ", 
                                                        @"Haarfarbe", @"Augenfarbe", @"Groesse", @"Gewicht",
                                                        @"Geburtstag", @"Gottheit", @"Sterne", @"Stand", @"Eltern", nil ])
        {
          [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setBackgroundColor: [NSColor whiteColor]];
          [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setStringValue: @""];
        }      
        
      NSDictionary *eigenschaftenDict = [NSDictionary dictionaryWithDictionary: [charConstraints objectForKey: @"Eigenschaften"]];      
      for (NSString *field in [NSArray arrayWithObjects: @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", 
                                                        @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ", nil ])
        {
          
          if ([eigenschaftenDict objectForKey: field] == nil)
            {
              [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@C", field]] setStringValue: @""];
            }
          else
            {
              [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@C", field]] setStringValue: [eigenschaftenDict objectForKey: field]];              
            }
        }       
    }
  else
    {
      [buttonCharGenGenerieren setEnabled: NO];
      [buttonCharGenAuswahl setEnabled: NO];
      [popupWinCharDefMagischeSchule setEnabled: NO];      
    }  
}

- (void) popupCharDefHerkunftSelected: (id)sender
{

  NSLog(@"popupCharDefHerkunftSelected got called");
  [aktiverCharakter setHerkunft: [[popupWinCharDefHerkunft selectedItem] title]];

  // einige Herkünfte haben extra Bedingungen
  NSDictionary *herkunftConstraints = [[[utils herkunftDict] objectForKey: [[popupWinCharDefHerkunft selectedItem] title]] objectForKey: @"Basiswerte"];  
  NSLog(@"berufeConstraints: %@", herkunftConstraints);    
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", 
                            @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
    {        
      if ([herkunftConstraints objectForKey: field] == nil)
        {
          NSLog(@"checking field was nil: %@", field);
          // Herkunft hat stärkere Bedingung als Typus
        }
      else
        {
          NSLog(@"checking field had value: %@", field);
          [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@C", field]] setStringValue: [herkunftConstraints objectForKey: field]];              
        }
    }    
}

- (void) popupCharDefBerufSelected: (id)sender
{

  NSLog(@"popupCharDefBerufSelected got called");
  [aktiverCharakter setBerufe: [NSArray arrayWithObjects: [[popupWinCharDefBeruf selectedItem] title], nil]];
  
  NSDictionary *berufeConstraints = [[[[utils berufeDict] objectForKey: [[popupWinCharDefBeruf selectedItem] title]] objectForKey: @"Bedingung"] objectForKey: @"Basiswerte"];  
  NSLog(@"berufeConstraints: %@", berufeConstraints);    
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", 
                             @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
    {          
      if ([berufeConstraints objectForKey: field] == nil)
        {
          NSLog(@"checking field was nil: %@", field);
          // Beruf hat stärkere Bedingung als Typus
          // gibt eh keine logischen Konflikte, da nur Anatom Bedingung auf TA hat...
        }
      else
        {
          NSLog(@"checking field had value: %@", field);
          [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@C", field]] setStringValue: [berufeConstraints objectForKey: field]];              
        }
    } 
}

- (void) popupCharDefMagischeSchuleSelected: (id)sender
{

  NSLog(@"popupCharDefMagierakademieSelected got called");
  
  [aktiverCharakter setMagischeSchule: [[popupWinCharDefMagischeSchule selectedItem] title]];
  
}

- (void) popupCharDefKategorieSelected: (id)sender
{

  NSLog(@"popupCharDefKategorieSelected got called");
  
  [aktiverCharakter setMagischeSchule: [[popupWinCharDefMagischeSchule selectedItem] title]];
  
    if ([[sender title] isEqualTo: @"Charakter generieren"])
    {
      [popupWinCharDefTypus setEnabled: NO];   
    }
  else
    {
      [popupWinCharDefTypus removeAllItems];
      [popupWinCharDefTypus addItemsWithTitles: [utils getAllTypusForKategorie: [[popupWinCharDefKategorie selectedItem] title]]];
      [popupWinCharDefTypus setEnabled: YES];       
    }
  
}

- (IBAction) showCharGenWindow: (id)sender
{
  NSLog(@"showCharGenWindow was called by %@ %@", sender, [sender title]);
  
  NSLog(@"Charakter: %@", [aktiverCharakter typus]);
  
  [popupWinCharDefKategorie addItemsWithTitles: [utils getAllTypusKategorien]];

  [popupWinCharDefTypus addItemsWithTitles: [utils getAllTypusForKategorie: [[popupWinCharDefKategorie selectedItem] title]]];

  [popupWinCharDefHerkunft addItemsWithTitles: [[utils herkunftDict] allKeys]];
  [popupWinCharDefBeruf addItemsWithTitles: [utils getBerufeForTypus: [aktiverCharakter typus]]];
  [popupWinCharDefMagischeSchule addItemsWithTitles: [[utils magierakademienDict] allKeys]];
  if ([[sender title] isEqualTo: @"Charakter generieren"])
    {
      [popupWinCharDefTypus setEnabled: NO];   
    }
  else
    {
      [popupWinCharDefTypus setEnabled: YES];       
    }
  [popupWinCharDefHerkunft setEnabled: NO];
  [popupWinCharDefBeruf setEnabled: NO];
  [popupWinCharDefMagischeSchule setEnabled: NO];
  [buttonCharGenGenerieren setEnabled: NO];  
  [buttonCharGenAuswahl setEnabled: NO];
  [fieldCharGenName setEnabled: NO];
  [fieldCharGenTitel setEnabled: NO];

  [windowCharGen makeKeyAndOrderFront: self];
} 

/* takes a "talentFieldXXX" NSTextField, and updates it's values
   according to KVO, based on talentType may either be "Kampftechniken" or "Talent"
*/
-(void) updateTalentFieldString: (NSTextField *)talentField ofType: (NSString *) talentType
{
  
}

- (void) showTalenteWindow: (id)sender
{
  NSLog(@"aktiverCharakter: %@", aktiverCharakter);
  NSLog(@"typus: %@", [aktiverCharakter typus]);
  NSLog(@"herkunft: %@", [aktiverCharakter herkunft]);
  NSLog(@"berufe: %@", [aktiverCharakter berufe]);
  NSLog(@"magischeSchule: %@", [aktiverCharakter magischeSchule]);
  
  [aktiverCharakter setTalente: [utils getTalenteForTypus: [aktiverCharakter typus]]];
  
  NSDictionary *charConstraints = [utils getTypusForTypus: [aktiverCharakter typus]];
  
//  NSLog(@"aktiverCharakter TALENTE: %@", [aktiverCharakter talente]);
//  NSLog(@"charConstraints: %@", charConstraints);

  if ([aktiverCharakter steigerungsTalente] == nil)
    {
      NSLog(@"Steigerungstalente war NIL oder WATT");
      NSLog(@"YUCK");
      NSMutableDictionary *steigerungsTalente = [[NSMutableDictionary alloc] init];
      NSLog(@"YUCK");
      [steigerungsTalente setObject: [[charConstraints objectForKey: @"Stufenanstieg"] objectForKey: @"TS"] forKey: @"verbleibendeVersuche"];
      
      NSLog(@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA: %@", steigerungsTalente);   
      [steigerungsTalente setObject: [[aktiverCharakter talente] mutableCopy] forKey: @"Talente"];
      [aktiverCharakter setSteigerungsTalente: steigerungsTalente];
      
      
      
      NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");            
      NSLog(@"Steigerungstalente jetzt gesetzt: %@", [aktiverCharakter steigerungsTalente]);

    }
  else
    {
      NSLog(@"Steigerungstalente war schon gesetzt: %@", [aktiverCharakter steigerungsTalente]);
    }
  
  [fieldVerbleibendeSteigerungsversuche setStringValue: [aktiverCharakter valueForKeyPath: @"steigerungsTalente.verbleibendeVersuche"]];
    
  NSRect viewRect = [windowTalente frame];
  viewRect.size.height = viewRect.size.height - 100;
  viewRect.origin.x = 0;
  viewRect.origin.y = 0;
  
  [[windowTalente contentView] addSubview: talenteView positioned: NSWindowAbove relativeTo: nil];
  [talenteView setAutoresizingMask: (NSViewWidthSizable | NSViewHeightSizable)];
  [talenteView setFrame: viewRect];
  
  NSTabView *mainTabView = [[NSTabView alloc] initWithFrame: viewRect];
  [mainTabView setIdentifier: @"talenteTabView"];
  [mainTabView setAutoresizingMask: (NSViewWidthSizable | NSViewHeightSizable)];
//  NSUInteger numberOfMainTabs = [[[aktiverCharakter talente] allKeys] count];
  
  for (NSString *mainTabTitle in [[aktiverCharakter talente] allKeys])
    {
      NSLog(@"Adding tabviewitem for: %@", mainTabTitle);
      NSTabViewItem *tabItem = [[NSTabViewItem alloc] initWithIdentifier: mainTabTitle];
      [tabItem setIdentifier: [NSString stringWithFormat: @"talentGruppe%@", mainTabTitle]];
      [tabItem setLabel: mainTabTitle];
      
      NSView *contentView = [[NSFlippedView alloc] initWithFrame: [mainTabView bounds]];
      
      [tabItem setView: contentView];
      
      if ([@"Kampftechniken" isEqualTo: mainTabTitle])
        {
          NSTabView *subTabView = [[NSTabView alloc] initWithFrame: viewRect];
          [subTabView setAutoresizingMask: (NSViewWidthSizable | NSViewHeightSizable)];          
          
          for (NSString *subTabTitle in [[[aktiverCharakter talente] objectForKey: mainTabTitle] allKeys])
            {
//              NSLog(@"adding subtabviewitem for %@", subTabTitle);
              NSTabViewItem *subtabItem = [[NSTabViewItem alloc] initWithIdentifier: subTabTitle];
              [subtabItem setLabel: subTabTitle];
              [subtabItem setIdentifier: [NSString stringWithFormat: @"talentSubGruppe%@", subTabTitle]];
              NSView *subcontentView = [[NSFlippedView alloc] initWithFrame: [subTabView bounds]];
              
              [subtabItem setView: subcontentView];
              
              NSInteger Offset = 0;
//              NSLog(@"Before the talent for loop!!!");
              for (NSString *talent in [[[aktiverCharakter talente] objectForKey: mainTabTitle] objectForKey: subTabTitle])
                {
//                  NSLog(@"In the Talent For Loop: %@", talent);
                  NSDictionary *talentDict = [NSDictionary dictionaryWithDictionary: 
                                             [[[[aktiverCharakter talente] objectForKey: mainTabTitle] 
                                                                          objectForKey: subTabTitle]
                                                                          objectForKey: talent]];
                  Offset += 22;
                  NSRect fieldRect = NSMakeRect(10,Offset, 300, 20);
                  NSTextField *talentField = [[NSTextField alloc] initWithFrame: fieldRect];
                  [talentField setIdentifier: [NSString stringWithFormat: @"talentField%@", talent]];
//                  NSLog(@"IDENTIFIER: %@", [talentField identifier]);
                  [talentField setSelectable: NO];
                  [talentField setEditable: NO];
                  [talentField setBordered: NO];
                  [talentField setBezeled: NO];
                  [talentField setBackgroundColor: [NSColor lightGrayColor]];
                  
//                  NSLog(@"talentField basic config done");
//                  NSLog(@"talentDict: %@", talentDict);
//                  NSLog(@"probe: %@", [talentDict objectForKey: @"Probe"]);
//                  NSLog(@"talent: %@", talent);
                  //NSString *probe = [NSString stringWithFormat: @"%@/%@/%@", ]
                  [talentField setStringValue: [NSString stringWithFormat: @"%@ (%@)", 
                                                                           talent,
                                                                           [talentDict objectForKey: @"Steigern"]]];
                  NSRect fieldValueRect = NSMakeRect(320, Offset, 20, 20);
                  NSTextField *talentFieldValue = [[NSTextField alloc] initWithFrame: fieldValueRect];
                  [talentFieldValue setIdentifier: [NSString stringWithFormat: @"talentFieldValue%@", talent]];
//                  NSLog(@"IDENTIFIER: %@", [talentFieldValue identifier]);
                  [talentFieldValue setSelectable: NO];
                  [talentFieldValue setEditable: NO];
                  [talentFieldValue setBordered: NO];
                  [talentFieldValue setBezeled: NO];
                  [talentFieldValue setBackgroundColor: [NSColor lightGrayColor]];
                  [talentFieldValue setStringValue: [talentDict objectForKey: @"Startwert"]];
/*                  [aktiverCharakter addObserver: self
                                     forKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@.Startwert", mainTabTitle, subTabTitle, talent]
                                        options: NSKeyValueObservingOptionNew
                                        context: nil];
*/                                        
                  [[talentFieldValue cell] setAlignment: NSTextAlignmentRight];
                  
                  NSRect buttonRect = NSMakeRect(340, Offset, 20, 20);    
                  NSButton *talentButton = [[NSButton alloc] initWithFrame: buttonRect];
                  [talentButton setIdentifier: [NSString stringWithFormat: @"talentButton%@", talent]];
                  [talentButton setImage: [NSImage _standardImageWithName: @"NSAddTemplate"]];
                  [talentButton setAlternateImage: [NSImage _standardImageWithName: @"common_outlineUnexpandable"]];
                  [talentButton setBezelStyle: NSRoundedBezelStyle];
                  [talentButton setButtonType: NSMomentaryPushButton];
                  [talentButton setTarget: self];
                  [talentButton setAction: @selector(talentSteigerungClicked:)];
                  //[talentButton setBordered: NO];
                  
//                  NSLog(@"Before adding to subcontentView");                                                         
                  [subcontentView addSubview: talentField];
                  [subcontentView addSubview: talentFieldValue];
                  [subcontentView addSubview: talentButton];
                }
              
              
              [subTabView addTabViewItem: subtabItem];
            }
          [contentView addSubview: subTabView];
        }
      else
        {
          
        }
      [mainTabView addTabViewItem: tabItem];
    }
  
  [talenteView addSubview: mainTabView];
    
/*    
  NSTextField *testTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(100, 50, 200, 30)];
  [testTextField setStringValue: @"just a test!!!!!!!"];
  
  NSTextField *grayTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(100, 200, 200, 30)];
  [grayTextField setStringValue: @"DANG IT DANG IT DANG IT"];

  [talenteView addSubview: testTextField positioned: NSWindowAbove relativeTo: nil];
  
  [talenteView addSubview: grayTextField positioned: NSWindowAbove relativeTo: nil];
  */
  [windowTalente makeKeyAndOrderFront: self];
}

- (void) talentSteigerungClicked: (id) sender
{
  NSLog(@"THE SENDER: %@", [sender identifier]);
  NSString *prefix = @"talentButton";
  
  NSScanner *scanner = [NSScanner scannerWithString: [sender identifier]];
  NSString *talent;
  
  if ([aktiverCharakter steigerungsTalente] == nil)
    {
      NSLog(@"talentSteigerungClicked: Steigerungstalente war NIL!!!");
    }
  else
    {
      NSLog(@"talentSteigerungClicked: Steigerungstalente war schon gesetzt!!!");   
    }
  
  [scanner scanString: prefix intoString: NULL];
  talent = [[sender identifier] substringFromIndex:[scanner scanLocation]];

//  NSString *verbleibendeVersuche = [NSString stringWithFormat: @"%li", [[[aktiverCharakter steigerungsTalente] objectForKey: @"verbleibendeVersuche"] integerValue] - 1];
  
  
//  [aktiverCharakter setValue: verbleibendeVersuche  forKeyPath: @"steigerungsTalente.verbleibendeVersuche"];

  [aktiverCharakter steigereTalent: talent];
  
  //NSString *talentGruppe = []
    
//  NSString *currentTalentValue = [NSString stringWithString: [[aktiverCharakter talente]]];
/*  
  NSView *contentView = [windowTalente contentView];
  NSTabView *foundView = (NSTabView *)[self viewWithIdentifier: @"talenteTabView" inView: talenteView];
  
  
  
  
  NSLog(@"FOUND VIEW: %@", [[foundView selectedTabViewItem] label]);
  NSLog(@"talent: %@", talent);
  */
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

  NSDictionary *charConstraints = [NSDictionary dictionaryWithDictionary: [utils getTypusForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  NSArray *positiveArr = [NSArray arrayWithArray: [utils positiveEigenschaftenGenerieren]];
  NSArray *negativeArr = [NSArray arrayWithArray: [utils negativeEigenschaftenGenerieren]];
//  NSDictionary *haarConstraints = [charConstraints objectForKey: @"Haarfarbe"];
  NSDictionary *geburtstag = [[NSDictionary alloc] init];
  NSDictionary *herkunftEltern = [utils famHerkunftGenerieren: [[popupWinCharDefTypus selectedItem] title]];
  NSDictionary *startvermoegenDict = [utils startvermoegenGenerieren: [herkunftEltern objectForKey: @"Stand"]];
  
  
  NSLog(@"HERE in generiereBasiswerte: %@", positiveArr);

  [fieldCharGenHaarfarbe setStringValue: [utils getHaarfarbeForTypus: [[popupWinCharDefTypus selectedItem] title]]];
  [fieldCharGenAugenfarbe setStringValue: [utils getAugenfarbeForTypus: [[popupWinCharDefTypus selectedItem] title] withHaarfarbe: [fieldCharGenHaarfarbe stringValue]]];  
  geburtstag = [utils geburtstagGenerieren];
  [fieldCharGenGeburtstag setStringValue: [geburtstag objectForKey: @"Datum"]];
  [fieldCharGenGottheit setStringValue: [geburtstag objectForKey: @"Monat"]];
  [fieldCharGenGroesse setStringValue: [utils groesseGenerieren: [[popupWinCharDefTypus selectedItem] title]]];
  [fieldCharGenGewicht setStringValue: [utils gewichtGenerieren: [[popupWinCharDefTypus selectedItem] title] groesse: [fieldCharGenGroesse stringValue]]];
  [fieldCharGenName setEnabled: YES];
  [fieldCharGenTitel setEnabled: YES];
  
  [popupCharGenGeschlecht removeAllItems];
  [popupCharGenGeschlecht addItemsWithTitles: [charConstraints objectForKey: @"Geschlecht"]];
  
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
  [fieldCharGenGeld setStringValue: [NSString stringWithFormat: @"%@D %@S %@H %@K", 
                                              [startvermoegenDict objectForKey: @"D"], 
                                              [startvermoegenDict objectForKey: @"S"], 
                                              [startvermoegenDict objectForKey: @"H"], 
                                              [startvermoegenDict objectForKey: @"K"]]];
  [fieldCharGenSterne setStringValue: [[[utils goetterDict] objectForKey: [geburtstag objectForKey: @"Monat"]] objectForKey: @"Sternbild"]];
  
  // positive Eigenschaften
  
  int i = 0;
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK" ])
    {
      [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setStringValue: [positiveArr objectAtIndex: i]];
      [self farbeFuerEigenschaftsfeldSetzen: field];
      i++;
    }
        
  // Negative Eigenschaften
  i = 0;
  for (NSString *field in @[ @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
    {
      [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] setStringValue: [negativeArr objectAtIndex: i]];
      [self farbeFuerEigenschaftsfeldSetzen: field];
      i++;
    }
      
  [self testButtonCharGenAuswahlEnable];

  [aktiverCharakter setGeburtstag: geburtstag];
  [aktiverCharakter setVermoegen: startvermoegenDict];
}

- (void) testButtonCharGenAuswahlEnable
{
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK", @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
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
      // Seems we're good to go, save everything to the active character
      NSDictionary *typusConstraints = [NSDictionary dictionaryWithDictionary: [utils getTypusForTypus: [aktiverCharakter typus]]];
      [aktiverCharakter setName: [fieldCharGenName stringValue]];
      [aktiverCharakter setTitel: [fieldCharGenTitel stringValue]];
      [aktiverCharakter setHaarfarbe: [fieldCharGenHaarfarbe stringValue]];      
      [aktiverCharakter setAugenfarbe: [fieldCharGenAugenfarbe stringValue]];            
      [aktiverCharakter setGroesse: [fieldCharGenGroesse stringValue]];                  
      [aktiverCharakter setGewicht: [fieldCharGenGewicht stringValue]];                        
      [aktiverCharakter setGottheit: [fieldCharGenGottheit stringValue]];                              
      [aktiverCharakter setSterne: [fieldCharGenSterne stringValue]];                                    
      [aktiverCharakter setStand: [fieldCharGenStand stringValue]];                                          
      [aktiverCharakter setEltern: [fieldCharGenEltern stringValue]];
      [aktiverCharakter setGeschlecht: [[popupCharGenGeschlecht selectedItem] title]];
      [aktiverCharakter setLe: [[typusConstraints objectForKey: @"LE"] integerValue]];
      [aktiverCharakter setAe: [[typusConstraints objectForKey: @"AE"] integerValue]];
      [aktiverCharakter setKe: [[typusConstraints objectForKey: @"KE"] integerValue]];
      [aktiverCharakter setMrBonus: [[typusConstraints objectForKey: @"MRBonus"] integerValue]];
      
      NSMutableDictionary *positiveEigenschaften = [[NSMutableDictionary alloc] init];
      for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK" ])
        {
          [positiveEigenschaften setObject: [NSNumber numberWithInt: [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] integerValue]] 
                                    forKey: field];  
        }
      [aktiverCharakter setPositiveEigenschaften: positiveEigenschaften];

      NSMutableDictionary *negativeEigenschaften = [[NSMutableDictionary alloc] init];        
      for (NSString *field in @[ @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
        {
          [negativeEigenschaften setObject: [NSNumber numberWithInt: [[self valueForKey: [NSString stringWithFormat: @"fieldCharGen%@", field]] integerValue]] 
                                    forKey: field];  
        }
      [aktiverCharakter setNegativeEigenschaften: negativeEigenschaften];      
      [aktiverCharakter setTalente: [utils getTalenteForTypus: [aktiverCharakter typus]]];    
      
      NSLog(@"aktiverCharakter: %@", aktiverCharakter);
      [utils apply: @"Goettergeschenke" toCharakter: aktiverCharakter];
      [utils apply: @"Herkunft" toCharakter: aktiverCharakter];
     
      
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

- (void) observeValueForKeyPath: (NSString *) keyPath
                       ofObject: (id) object
                         change: (NSDictionary *)change
                        context: (void *)context {
                        
  NSLog(@"observeValueForKeyPath GOT CALLED %@!!!", keyPath);
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK" ])
    {
      if ([[NSString stringWithFormat: @"positiveEigenschaften.%@", field] isEqualTo: keyPath])
        {
          NSLog(@"CHANGE OF FIELD: %@ value: %@", field, change);
          NSString *eigenschaftsFeldName = [NSString stringWithFormat: @"fieldTalente%@", field];
          NSTextField *eigenschaftsFeld = [[NSTextField alloc] init];
          eigenschaftsFeld = [self valueForKey: eigenschaftsFeldName];
          [eigenschaftsFeld setValue: [change objectForKey: @"new"] forKey: @"stringValue"];
        }
     }
   if ([@"steigerungsTalente.verbleibendeVersuche" isEqualTo: keyPath])
     {
       NSLog(@"updating FIELD: fieldVerbleibendeSteigerungsversuche with value: %@", [change objectForKey: @"new"]);
       [fieldVerbleibendeSteigerungsversuche setValue: [change objectForKey: @"new"] forKey: @"stringValue"];
     }
   if ([keyPath hasPrefix:@"talente.Kampftechniken."])
     {
        NSArray *keys = [keyPath componentsSeparatedByString:@"."];
        NSUInteger lastKeyIndex = [keys count] - 1;
        if ([[keys objectAtIndex: lastKeyIndex] isEqualTo: @"Startwert"])
          {
            NSString *talent = [keys objectAtIndex: lastKeyIndex - 1];
            NSString *talentFieldIdentifierName = [NSString stringWithFormat: @"talentField%@", talent];
            NSTextField *talentField = (NSTextField *)[self viewWithIdentifier: talentFieldIdentifierName inView: talenteView];
            [talentField setValue: [change objectForKey: @"new"] forKey: @"stringValue"];
          }
     }
     

}



// Find a view givent it's identifier
- (NSView *)viewWithIdentifier:(NSString *)identifier inView: (NSView *) parentView;
{
    NSArray *subviews = [self allSubviewsInView:parentView.window.contentView];

    for (NSView *view in subviews) {
        if ([view.identifier isEqualToString:identifier]) {
            return view; 
        }
    }

    return nil;
}

- (NSMutableArray *)allSubviewsInView:(NSView *)parentView {

    NSMutableArray *allSubviews     = [[NSMutableArray alloc] initWithObjects: nil];
    NSMutableArray *currentSubviews = [[NSMutableArray alloc] initWithObjects: parentView, nil];
    NSMutableArray *newSubviews     = [[NSMutableArray alloc] initWithObjects: parentView, nil];

    while (newSubviews.count) {
        [newSubviews removeAllObjects];

        for (NSView *view in currentSubviews) {
            for (NSView *subview in view.subviews) [newSubviews addObject:subview];
        }

        [currentSubviews removeAllObjects];
        [currentSubviews addObjectsFromArray:newSubviews];
        [allSubviews addObjectsFromArray:newSubviews];

    }

    for (NSView *view in allSubviews) {
        NSLog(@"View: %@, tag: %ld, identifier: %@", view, view.tag, view.identifier);
    }

    return allSubviews;
}

@end
