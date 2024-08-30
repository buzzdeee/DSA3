/*
   Project: DSA3

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-07-26 22:38:37 +0200 by sebastia

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#include <stdlib.h>
#include <math.h>
#import <dispatch/dispatch.h>
#import "Utils.h"
#import "Charakter.h"
#import "NSDictionary+Extras.h"
#import "NSMutableDictionary+Extras.h"



@implementation Utils

// Static variable to hold the shared instance
static dispatch_once_t onceToken;
static Utils *_sharedInstance = nil;


@synthesize talenteDict;
@synthesize typusDict;
@synthesize berufeDict;
@synthesize herkunftDict;
@synthesize magierakademienDict;
@synthesize augenfarbenDict;
@synthesize geburtstagDict;
@synthesize goetterDict;

// Define the class method to get 
// the shared instance of the class
+ (instancetype)sharedInstance {
  
    // Ensure the instance is created only once
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


- (id) init
{
  if ((self = [super init]))
    {
      NSError *e = nil;
      talenteDict = [NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Talente.json"]
        options: NSJSONReadingMutableContainers
        error: &e];
      typusDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Typus.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);      
      berufeDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Berufe.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);
      herkunftDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Herkunft.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);
      magierakademienDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Magierakademien.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);
      //NSLog(@"UTILS: magierakademienDict: %@", magierakademienDict); 
      augenfarbenDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Augenfarben.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);
      //NSLog(@"UTILS: augenfarbenDict: %@", augenfarbenDict);
      geburtstagDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Geburtstag.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);      
      goetterDict = RETAIN([NSJSONSerialization 
        JSONObjectWithData: [NSData dataWithContentsOfFile: @"/home/sebastia/GIT/DSA3/Resources/Goetter.json"]
        options: NSJSONReadingMutableContainers
        error: &e]);   
      NSLog(@"HERE IN UTILS GOETTER DICT: %@", goetterDict);
    }   
  return self; 
}


+ (NSDictionary *) parseWuerfel: (NSString *) wuerfelDefinition
{
  int anzahl, augen;
  NSMutableDictionary *wuerfel = [[NSMutableDictionary alloc] init];
  //NSLog(@"HERE IN parseWuerfel!!!");
  NSScanner *scanner = [NSScanner scannerWithString: wuerfelDefinition];
  [scanner scanInt: &anzahl];
  [scanner scanCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"W"] intoString: NULL];
  [scanner scanInt: &augen];
  
  [wuerfel setValue: [NSNumber numberWithInt: anzahl] forKey: @"Anzahl"];
  [wuerfel setValue: [NSNumber numberWithInt: augen] forKey: @"Augen"];

  //NSLog(@"HERE IN parseWuerfel returning WUERFEL: %@", wuerfel);  
  return wuerfel;
}

+ (NSDictionary *) parseConstraint: (NSString *) constraintDefinition
{
  int wert;
  NSString *cwert;
  NSMutableDictionary *constraint = [[NSMutableDictionary alloc] init];
  //NSLog(@"here in parseConstraint %@", constraintDefinition);
  NSScanner *scanner = [NSScanner scannerWithString: constraintDefinition];
  //NSLog(@"going to scanInt");
  [scanner scanInt: &wert];
  //NSLog(@"going to scanCharactersFromSet");
  [scanner scanCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"+-"] intoString: &cwert];
  
  //NSLog(@"setting constraint value Wert");
  [constraint setValue: [NSNumber numberWithInt: wert] forKey: @"Wert"];
  if ([cwert isEqualToString: @"+"])
    {
      //NSLog(@"IF +");
      [constraint setValue: @"MAX" forKey: @"Constraint"];
    }
  else
    {
      //NSLog(@"IF -");    
      [constraint setValue: @"MIN" forKey: @"Constraint"];
    }
    
  //NSLog(@"returning Constraint: %@", constraint);
  return constraint;
}


/* nimmt eine Würfeldefinition, z.B. 3W6 und würfelt das entsprechende
   Ergebnis aus. */

+ (NSNumber *) wuerfelnMitWuerfel: (NSString *) wuerfelDefinition
{
  NSDictionary *wuerfel = [NSDictionary dictionaryWithDictionary: [Utils parseWuerfel: wuerfelDefinition]];
  int result = 0;
  for (int i=0; i<[[wuerfel objectForKey: @"Anzahl"] intValue];i++)
    {
      result += arc4random_uniform([[wuerfel objectForKey: @"Augen"] intValue]) + 1;
    }
  return [NSNumber numberWithInt: result];
}


/* The berufeDict contains all known Berufe. Some Characters can have
   Berufe from the beginning, find those in the dict. */

- (NSArray *) getBerufeForTypus: (NSString *) characterType
{
  NSMutableArray *berufe = [[NSMutableArray alloc] init];
  
  if (characterType == nil)
    {
      NSLog(@"getBerufeForTypus: characterType was NIL");
      [berufe addObject: @"Kein Beruf"];
      return berufe;
    }
  
  NSLog(@"the berufe dict: %@", berufeDict);  
    
  for (NSString *beruf in [berufeDict allKeys])
    {
      NSLog(@"checking BERUF: %@", beruf);
      NSLog(@"YIKES: %@", [berufeDict objectForKey: beruf]);
      if ([[berufeDict objectForKey: beruf] objectForKey: @"Typen"] != nil)
        {
          NSLog(@"BERUF contained Typen!!!!");
          if ([[[berufeDict objectForKey: beruf] objectForKey: @"Typen"] containsObject: characterType])
            {
              NSLog(@"BERUF contained characterType: %@", characterType);
              [berufe addObject: beruf];
            }
        }
      else
        {
          NSLog(@"BERUF din't contained Typen!!!!");        
        }
    }
    
  [berufe insertObject: @"Kein Beruf" atIndex: 0];
  return berufe;
}

/* Unterschiedliche Charaktere können Unterschiedlicher regionaler
   Herkunft sein, mit regionalen Talentunterschieden */

- (NSArray *) getHerkuenfteForTypus: (NSString *) characterType
{
  NSMutableArray *herkuenfte = [[NSMutableArray alloc] init];
  
  if (characterType == nil)
    {
      NSLog(@"getHerkuenfteForTypus: characterType was NIL");
      [herkuenfte addObject: @"Mittelreich"];
      return herkuenfte;
    }
  
  NSLog(@"the herkuenfte dict: %@", herkunftDict);  
    
  for (NSString *herkunft in [herkunftDict allKeys])
    {
      NSLog(@"checking HERKUNFT: %@", herkunft);
      NSLog(@"YIKES: %@", [herkunftDict objectForKey: herkunft]);
      if ([[herkunftDict objectForKey: herkunft] objectForKey: @"Typen"] != nil)
        {
          NSLog(@"HERKUNFT contained Typen!!!!");
          if ([[[herkunftDict objectForKey: herkunft] objectForKey: @"Typen"] containsObject: characterType])
            {
              NSLog(@"HERKUNFT contained characterType: %@", characterType);
              [herkuenfte addObject: herkunft];
            }
        }
      else
        {
          NSLog(@"HERKUNFT din't contained Typen!!!!");        
        }
    }
    
  [herkuenfte insertObject: @"Mittelreich" atIndex: 0];
  return herkuenfte;  
}

/* generiert Haarfarbe, abhängig vom Typus. Haarfarbe Werte
   definiert im Typus.json, aus den entsprechenden Büchern */
- (NSString *) getHaarfarbeForTypus: (NSString *) characterType
{
  NSDictionary *haarConstraint = [NSDictionary dictionaryWithDictionary: [[self getTypusForTypus: characterType] objectForKey: @"Haarfarbe"]];
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];

  NSArray *farben = [NSArray arrayWithArray: [haarConstraint allKeys]];
  
  for (NSString *farbe in farben)
    {
      if ([[haarConstraint objectForKey: farbe] containsObject: wurf])
        {
          //NSLog(@"Farbe gefunden: %@", farbe);
          return farbe;
        }
    }
  return @"nix";
}

/* if no Augenfarbe in the Typus description, 
   use the formula as defined in "Mit Mantel, Schwert und Zauberstab" */
- (NSString *) getAugenfarbeForTypus: (NSString *) characterType withHaarfarbe: (NSString *) haarfarbe
{
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  
  if ([[self getTypusForTypus: characterType] objectForKey: @"Augenfarbe"] == nil)
    {
      // No special Augenfarbe defined for the characterType, we use the default calculation
      // algorithm as defined in "Mit Mantel, Schwert und Zauberstab S. 61"
      for (NSDictionary *entry in augenfarbenDict)
        {
          //NSLog(@"ENTRY1: %@", entry);
          for (NSString *farbe in [entry objectForKey: @"Haarfarben"])
            {
              //NSLog(@"ENTRY2: %@", farbe);
              if ([farbe isEqualTo: haarfarbe])
                {
                  //NSLog(@"FOUND HAARFARBE: %@", haarfarbe);
                  for (NSString *af in [[entry objectForKey: @"Augenfarben"] allKeys])
                    {
                      //NSLog(@"checking Augenfarbe: %@", [entry objectForKey: @"Augenfarben"]);
                      if ([[[entry objectForKey: @"Augenfarben"] objectForKey: af] containsObject: wurf])
                        {
                          //NSLog(@"Augenfarbe gefunden! %@", af);
                          return af;
                        }
                    }
                }
            }
        }        
    }
  else
    {
      // We're dealing with a Character that has special Augenfarben constraints
      NSDictionary *augenFarben = [NSDictionary dictionaryWithDictionary: [[self getTypusForTypus: characterType] objectForKey: @"Haarfarbe"]];
      
      for (NSString *farbe in [augenFarben allKeys])
        {
          if ([[augenFarben objectForKey: farbe] containsObject: wurf])
            {
              // we found the color
              return farbe;
            }
        }
    }
  return @"nix";
}

/* Generiert positive Eigenschaften, wie beschrieben in
   "Mit Mantel, Schwert und Zauberstab" S. 7,
   8 mal 1W6 + 7 würfeln, und das niedrigste Ergebnis verwerfen */

- (NSArray *) positiveEigenschaftenGenerieren
{
  NSMutableArray *eigenschaften = [[NSMutableArray alloc] init];
  // NSLog(@"HERE in positiveEigenschaftenGenerieren");
  NSInteger cnt;
  NSInteger kleinster = 14;
  for ( cnt = 1; cnt < 9; cnt++ )
    {
      NSInteger result;
      result = [[Utils wuerfelnMitWuerfel: @"1W6"] intValue] + 7;
      if (result < kleinster)
        {
          kleinster = result;
        }
      [eigenschaften addObject: [NSNumber numberWithInt: result]];
    }
  [eigenschaften removeObjectAtIndex:[eigenschaften indexOfObject: [NSNumber numberWithInt: kleinster]]];
  
  return eigenschaften;
}

/* Generiert negative Eigenschaften, wie beschrieben in
   "Mit Mantel, Schwert und Zauberstab" S. 7,
   7 mal 1W6 + 1 würfeln */

- (NSArray *) negativeEigenschaftenGenerieren
{
  NSMutableArray *eigenschaften = [[NSMutableArray alloc] init];
  NSInteger cnt;
  for ( cnt = 1; cnt < 8; cnt++ )
    {
      NSInteger result;
      result = [[Utils wuerfelnMitWuerfel: @"1W6"] intValue] + 1;
      [eigenschaften addObject: [NSNumber numberWithInt: result]];
    }
  
  return eigenschaften;
}

/* generiert den Geburtstag, siehe Die Helden des Schwarzen Auges,
   Regelbuch II, S. 9. */

- (NSDictionary *) geburtstagGenerieren
{
  NSString *monatName = [[NSString alloc] init];
  // NSNumber *monatNummer;
  NSLog(@"GEBURTSTAGSDICT: %@", geburtstagDict);
  NSNumber *tag = [[NSNumber alloc] init];
  NSNumber *jahr = [[NSNumber alloc] init];
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  NSMutableDictionary *retVal = [[NSMutableDictionary alloc] init];
  NSArray *monate = [[geburtstagDict objectForKey: @"Monat"] allKeys];
  NSLog(@"geburtstag: Monate: %@", monate);
  NSLog(@"Monat Wurf: %@", wurf);
  for (NSString *monat in monate)
    {
      NSLog(@"checking %@", monat);
      if ([[[geburtstagDict objectForKey: @"Monat"] objectForKey: monat] containsObject: wurf])
        {
          monatName = [NSString stringWithFormat: @"%@", monat];
        }
    }

  NSLog(@"found Monat: %@", monatName);
  wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  NSLog(@"fuenftelwurf: %@", wurf);
  NSArray *monatsfuenftel = [[geburtstagDict objectForKey: @"Monatsfuenftel"] allKeys];
  for (NSString *fuenftel in monatsfuenftel)  
    {
      NSLog(@"checking fuenftel: %@", fuenftel);
      if ([[[geburtstagDict objectForKey: @"Monatsfuenftel"] objectForKey: fuenftel] containsObject: wurf])
        {
          tag = [NSNumber numberWithInt: [fuenftel intValue] + [[Utils wuerfelnMitWuerfel: @"1W6"] intValue] - 1];
        }
    }
  jahr = [NSNumber numberWithInt: 0];
  //NSLog(@"Found TAG: %@", tag);
  //NSLog(@"building retVal: %@", retVal);
  [retVal setObject: monatName forKey: @"Monat"];
  //NSLog(@"building retVal: %@", retVal);
  [retVal setObject: tag forKey: @"Tag"];
  //NSLog(@"building retVal: %@", retVal);  
  [retVal setObject: jahr forKey: @"Jahr"];
  //NSLog(@"building retVal: %@", retVal);
  [retVal setObject: [NSString stringWithFormat: @"%@. %@ im Jahr %@ Hal", tag, monatName, jahr] forKey: @"Datum"];
  //NSLog(@"returning retVal: %@", retVal);
  return retVal;
}


- (NSDictionary *) getTypusForTypus: (NSString *) characterType
{
  return [typusDict objectForKey: characterType];
}

- (NSArray *) getAllTypusKategorien
{

  NSMutableOrderedSet *kategorien = [[NSMutableOrderedSet alloc] init];
  
  for (NSDictionary *typus in typusDict)
    {
      NSLog(@"adding Kategorie for typus: %@ %@", typus, [[typusDict objectForKey: typus] objectForKey: @"Typkategorie"] );
      [kategorien addObjectsFromArray: [[typusDict objectForKey: typus] objectForKey: @"Typkategorie"]];
    }
  NSLog(@"going to return!");
  return [kategorien array];
}

- (NSArray *) getAllTypusForKategorie: (NSString *) kategorie
{
  NSMutableArray *typus = [[NSMutableArray alloc] init];
    NSLog(@"here in getAllTypusForKategorie %@", kategorie);
    if ([@"Kategorie" isEqualTo: kategorie])
    {
      NSLog(@"getAllTypusForKategorie: kategorie was NIL");
      [typus addObject: @"Typus"];
      return typus;
    }
  
  for (NSString *type in [typusDict allKeys])
    {
      NSLog(@"checking type: %@ for kategorie: %@", type, kategorie);
      NSLog(@"type: %@", [typusDict objectForKey: type]);
      if ([[[typusDict objectForKey: type] objectForKey: @"Typkategorie"] containsObject: kategorie])
        {
          [typus addObject: type];
        }
    }
  return typus;
}

- (NSMutableDictionary *) getTalenteForTypus: (NSString *) characterType
{
  NSMutableDictionary *talente = [[NSMutableDictionary alloc] init];
  
  NSArray *talentGruppen = [NSArray arrayWithArray: [[self talenteDict] allKeys]];
//  NSLog(@"talentGruppen: %@", talentGruppen);
  for (NSString *talentGruppe in talentGruppen)
    {
//      NSLog(@"Checking talentGruppe: %@", talentGruppe);
      if ([@"Kampftechniken" isEqualTo: talentGruppe])
        {
//          NSLog(@"Talentgruppe: %@", [[self talenteDict] objectForKey: talentGruppe]);
//          NSLog(@"Steigern: %@", [[[self talenteDict] objectForKey: talentGruppe] objectForKey: @"Steigern"]);

          NSString *steigern = [NSString stringWithFormat: @"%@", [[[self talenteDict] objectForKey: talentGruppe] objectForKey: @"Steigern"]];
          NSString *versuche = [NSString stringWithFormat: @"%li", [steigern integerValue] * 3];
//          NSLog(@"Steigern: %@", steigern);
         
          for (NSString *key in [[self talenteDict] objectForKey: talentGruppe])
            {
              NSString *waffentyp;
              NSString *startwert;
              if ([@"Steigern" isEqualTo: key])
                {
//                  NSLog(@"Found Steigern!!!, jumping over!!!!");
                  continue;
                }
              else
                {
//                  NSDictionary *tG = [NSDictionary dictionaryWithDictionary: [[self talenteDict] objectForKey: talentGruppe]];
                  //NSLog(@"tG: %@", tG);
                  waffentyp = [NSString stringWithFormat: @"%@", [[[[self talenteDict] objectForKey: talentGruppe] objectForKey: key] objectForKey: @"Waffentyp"]];
                  startwert = [NSString stringWithFormat: @"%@", [[[[[self talenteDict] objectForKey: talentGruppe] objectForKey: key] objectForKey: @"Startwerte"] objectForKey: characterType]];
                }
//              NSLog(@"Waffentyp: %@ Startwert: %@, key: %@", waffentyp, startwert, key);  
//              NSDictionary *technik = [NSDictionary dictionaryWithObject: @{@"Startwert": startwert, @"Steigern": steigern } forKey: key];
//              NSLog(@"Technik: %@", technik);
                [talente setValue: @{@"Startwert": startwert, @"Steigern": steigern, @"Versuche": versuche} forKeyHierarchy: @[talentGruppe, waffentyp, key]];
//              NSLog(@"talente: %@", talente);
            } 
        }
      else
        {
          //NSLog(@"talentGruppe: %@", talentGruppe);
          //NSLog(@"Talentgruppe: %@", [[self talenteDict] objectForKey: talentGruppe]);
          //NSLog(@"Steigern: %@", [[[self talenteDict] objectForKey: talentGruppe] objectForKey: @"Steigern"]);

          NSString *steigern = [NSString stringWithFormat: @"%@", [[[self talenteDict] objectForKey: talentGruppe] objectForKey: @"Steigern"]];
          NSString *versuche = [NSString stringWithFormat: @"%li", [steigern integerValue] * 3];
          //NSLog(@"Steigern: %@", steigern);   
          for (NSString *key in [[self talenteDict] objectForKey: talentGruppe])
            {
              NSArray *probe;
              NSString *startwert;
              if ([@"Steigern" isEqualTo: key])
                {
                  //NSLog(@"Found Steigern!!!, jumping over!!!!");
                  continue;
                }
              else
                {
//                  NSDictionary *tG = [NSDictionary dictionaryWithDictionary: [[self talenteDict] objectForKey: talentGruppe]];
                  //NSLog(@"tG: %@", tG);
                  probe = [NSArray arrayWithArray: [[[[self talenteDict] objectForKey: talentGruppe] objectForKey: key] objectForKey: @"Probe"]];
                  //NSLog(@"PROBE: %@", probe);
                  startwert = [NSString stringWithFormat: @"%@", [[[[[self talenteDict] objectForKey: talentGruppe] objectForKey: key] objectForKey: @"Startwerte"] objectForKey: characterType]];
                }
                [talente setValue: @{@"Startwert": startwert, @"Probe": probe, @"Steigern": steigern, @"Versuche": versuche} forKeyHierarchy: @[talentGruppe, key]];
//              NSLog(@"talente: %@", talente);
            }       
        }
    }
//  NSLog(@"talente: %@", talente);
  return talente;
}

- (NSDictionary *) famHerkunftGenerieren: (NSString *)characterType
{

  NSString *wuerfel = [[[self getTypusForTypus: characterType] objectForKey: @"Herkunft"] objectForKey: @"Würfel"];
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: wuerfel];
  NSLog(@"wurf: %@", wurf);

  NSDictionary *herkuenfteDict = [NSDictionary dictionaryWithDictionary: [[self getTypusForTypus: characterType] objectForKey: @"Herkunft"]];
  NSArray *herkuenfteArr = [NSArray arrayWithArray: [herkuenfteDict allKeys]];
  NSMutableDictionary *retVal = [[NSMutableDictionary alloc] init];
  
  for (NSString *herkunft in herkuenfteArr)
    {
      NSLog(@"Checking Herkunft: %@", herkunft);
      if ([@"Würfel" isEqualTo: herkunft])
        {
          continue;
        }
      
      if ([[[herkuenfteDict objectForKey: herkunft] objectForKey: wuerfel] containsObject: wurf])
        {
          NSLog(@"Herkunft gefunden: wurf: %@ herkunft: %@", wurf, herkunft);
          [retVal setObject: herkunft forKey:@"Stand"];
          NSLog(@"alle elterntypen: %@", [[[herkuenfteDict objectForKey: herkunft] objectForKey: @"Eltern"] allKeys]);
          for (NSString *eltern in [[[herkuenfteDict objectForKey: herkunft] objectForKey: @"Eltern"] allKeys])
            {
              NSLog(@"teste: %@", [[[herkuenfteDict objectForKey: herkunft] objectForKey: @"Eltern"] allKeys]);
              if ([[[[herkuenfteDict objectForKey: herkunft] objectForKey: @"Eltern"] objectForKey: eltern] containsObject: wurf])
                {
                  NSLog(@"Eltern gefunden: %@ vs. %@", eltern, [[herkuenfteDict objectForKey: herkunft] objectForKey: eltern]);
                  [retVal setObject: eltern forKey: @"Eltern"];
                  break;
                }
              else
                {
                  NSLog(@"Eltern nicht gefunden: %@ vs. %@ XXX %@", eltern, [[herkuenfteDict objectForKey: herkunft] objectForKey: eltern], [herkuenfteDict objectForKey: herkunft]);
                }
            }
          break;
        }
    }
  return retVal;
} 

/* Generiert das Startvermoegen, siehe Mit Mantel, Schwert
   und Zauberstab S. 61 */
- (NSDictionary *) startvermoegenGenerieren: (NSString *)stand
{
   NSMutableDictionary *geld = [NSMutableDictionary dictionaryWithDictionary: @{@"K": [NSNumber numberWithInt: 0], @"H": [NSNumber numberWithInt: 0], @"S": [NSNumber numberWithInt: 0], @"D": [NSNumber numberWithInt: 0]}];
   if ([stand isEqualTo: @"unfrei"])
     {
       [geld setObject: [Utils wuerfelnMitWuerfel: @"1W6"] forKey: @"S"];
     }
   else if ([stand isEqualTo: @"arm"])
     {
       [geld setObject: [Utils wuerfelnMitWuerfel: @"1W6"] forKey: @"D"];
     }
   else if ([stand isEqualTo: @"mittelständisch"])
     {
       [geld setObject: [Utils wuerfelnMitWuerfel: @"3W6"] forKey: @"D"];
     }
   else if ([stand isEqualTo: @"reich"])
     {
       [geld setObject: [NSNumber numberWithInt: [[Utils wuerfelnMitWuerfel: @"2W20"] integerValue] + 20] forKey: @"D"];
     }
   else if ([stand isEqualTo: @"adelig"])
     {
       [geld setObject: [Utils wuerfelnMitWuerfel: @"3W20"] forKey: @"D"];
     }
  NSLog(@"GELD: %@", geld);
  return geld;
}

- (NSString *) groesseGenerieren: (NSString *) characterType
{
  NSArray *groesseArr = [NSArray arrayWithArray: [[typusDict objectForKey: characterType] objectForKey: @"Körpergröße"]];
  unsigned int groesse = [[groesseArr objectAtIndex: 0] intValue];
  unsigned int count = [groesseArr count];
  for (unsigned int i = 1;i<count; i++)
    {
      groesse += [[Utils wuerfelnMitWuerfel: [groesseArr objectAtIndex: i]] intValue];
    }
  return [NSString stringWithFormat: @"%u", groesse];
}
- (NSString *) gewichtGenerieren: (NSString *) characterType groesse: (NSString *) groesse
{
  int gewicht = [[[typusDict objectForKey: characterType] objectForKey: @"Gewicht"] intValue];
  return [NSString stringWithFormat: @"%u", (gewicht + [groesse intValue])];
}

// Creates string i.e. MU/KK/FF
- (NSString *) getProbeStringFromProbeDict: (NSArray *) probe
{
  return [NSString stringWithFormat: @"%@/%@%@",
                   [probe objectAtIndex: 0],
                   [probe objectAtIndex: 1],
                   [probe objectAtIndex: 2]];
}


- (NSMutableDictionary *) getTalentDictFromTalenteDict: (NSMutableDictionary *) dict forTalent: (NSString *) talent
{
  //NSLog(@"looking for talent: %@ in dict: %@", talent, dict);
  return [dict findMutableObjectForKey: talent];
}



- (void) apply: (NSString *) what toCharakter: (Charakter *) charakter
{
  NSMutableDictionary *basisWerte = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *talente = [[NSMutableDictionary alloc] init];
  if ([@"Goettergeschenke" isEqualTo: what])
    {
      NSLog(@"applying: %@", what);
      NSLog(@"charakter: %@", charakter);
      basisWerte = [[[self goetterDict] objectForKey: [charakter gottheit]] objectForKey: @"Basiswerte"];
      talente = [[[self goetterDict] objectForKey: [charakter gottheit]] objectForKey: @"Talente"];
      NSLog(@"basisWerte: %@", basisWerte);
       
    }
  else if ([@"Herkunft" isEqualTo: what])
    {
      NSLog(@"applying: %@", what);
      NSLog(@"HERKUNFT: %@", [charakter herkunft]);
      NSLog(@"TALENTE DICT %@", [self herkunftDict]);
      talente = [[[self herkunftDict] objectForKey: [charakter herkunft]] objectForKey: @"Talente"]; 
    }
  else
    {
      NSLog(@"Don't know how to apply: %@", what);
    }
  // positive Eigenschaften
  for (NSString *field in @[ @"MU", @"KL", @"IN", @"CH", @"FF", @"GE", @"KK" ])
    {
      if ([[basisWerte allKeys] containsObject: field])
        {
          NSLog(@"setting positive field: %@", field);
          NSLog(@"charakter positiveEigenschaften BEFORE: %@", [charakter positiveEigenschaften]);
          [charakter setValue: [NSNumber numberWithInteger: [[charakter valueForKeyPath: [NSString stringWithFormat: @"positiveEigenschaften.%@", field]] integerValue]  + 
                               [[basisWerte objectForKey: field] integerValue]]
                   forKeyPath: [NSString stringWithFormat: @"positiveEigenschaften.%@", field]];
          NSLog(@"charakter positiveEigenschaften AFTER: %@", [charakter positiveEigenschaften]);                       
        }
    }
  // negative Eigenschaften
  for (NSString *field in @[ @"AG", @"HA", @"RA", @"TA", @"NG", @"GG", @"JZ" ])
    {
      if ([[basisWerte allKeys] containsObject: field])
        {
          NSLog(@"setting negative field: %@", field);            
          [charakter setValue: [NSNumber numberWithInteger: [[charakter valueForKeyPath: [NSString stringWithFormat: @"negativeEigenschaften.%@", field]] integerValue]  + 
                               [[basisWerte objectForKey: field] integerValue]]
                   forKeyPath: [NSString stringWithFormat: @"negativeEigenschaften.%@", field]];
        }
    }

  // Talente
  NSLog(@"TALENTE VORHER: %@", [charakter talente]);
  NSLog(@"ALLE TALENTE: %@", [talente allKeys]);
  for (NSString *talentGruppe in [talente allKeys])
    {
      if ([talentGruppe isEqualTo: @"Kampftechniken"])
        {
          NSLog(@"TALENTGRUPPE: %@", talentGruppe);
          for (NSString *talentSubGruppe in [talente objectForKey: talentGruppe])
            {
              NSLog(@"TALENTSUBGRUPPE: %@", talentSubGruppe);
              for (NSString *talent in [[talente objectForKey: talentGruppe] objectForKey: talentSubGruppe])
                {
                  NSLog(@"THE GESCHENK TALENT: %@", talent);
                  NSLog(@"BEFORE GOETTER: Talentwert: %@", [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@", talentGruppe, talentSubGruppe, talent]]);
                  NSInteger geschenk = [[charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@.Startwert", talentGruppe, talentSubGruppe, talent]] integerValue] + 
                                                                    [[[[talente objectForKey: talentGruppe] objectForKey: talentSubGruppe] objectForKey: talent] integerValue];
                  NSLog(@"THE GESCHENK: %li", geschenk);
                  NSMutableDictionary *currentTalent = [NSMutableDictionary dictionaryWithDictionary: [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@", talentGruppe, talentSubGruppe, talent]]];
                  NSLog(@"CURRENT TALENT BEFORE: %@", currentTalent);
                  [currentTalent setObject: [NSString stringWithFormat: @"%li", geschenk] forKey: @"Startwert"];
                  NSLog(@"CURRENT TALENT NOWISH: %@", currentTalent);
                  [charakter setValue: currentTalent
                           forKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@", talentGruppe, talentSubGruppe, talent]];
                  NSLog(@"AFTER GOETTER: %@", [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.%@.Startwert", talentGruppe, talentSubGruppe, talent]]);                
                }
            }
        }
      else
        {
          NSLog(@"TALENTGRUPPE: %@", talentGruppe);
          for (NSString *talent in [[talente objectForKey: talentGruppe] allKeys])
            {
              NSLog(@"Updating Goetter Talent: %@", talent);
              NSLog(@"BEFORE GOETTER: Talentwert: %@ Geschenk: %@", [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.Startwert", talentGruppe, talent]],[[talente objectForKey: talentGruppe] objectForKey: talent]);
              NSInteger geschenk = [[charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.Startwert", talentGruppe, talent]] integerValue] + [[[talente objectForKey: talentGruppe] objectForKey: talent] integerValue];
              NSLog(@"XXXXXXX %@", [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@", talentGruppe, talent]]);
              NSMutableDictionary *currentTalent = [NSMutableDictionary dictionaryWithDictionary: [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@", talentGruppe, talent]]];
              [currentTalent setObject: [NSString stringWithFormat: @"%li", geschenk] forKey: @"Startwert"];
//              [aktiverCharakter setValue: [NSString stringWithFormat: @"%li", geschenk]
              [charakter setValue: currentTalent              
                       forKeyPath: [NSString stringWithFormat: @"talente.%@.%@", talentGruppe, talent]];
              NSLog(@"AFTER GOETTER: %@", [charakter valueForKeyPath: [NSString stringWithFormat: @"talente.%@.%@.Startwert", talentGruppe, talent]]);                              
            }
        }
    }
  NSLog(@"TALENTE NACHER: %@", [charakter talente]);       
}



@end
