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


/* generiert Haarfarbe, abhängig vom Typus. Haarfarbe Werte
   definiert im Typus.json, aus den entsprechenden Büchern */

- (NSString *) haarfarbeVonConstraintGenerieren: (NSDictionary *) haarConstraint
{
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  //NSLog(@"haarConstraint: %@", haarConstraint);
  //NSLog(@"wurf: %@", wurf);
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

/* generiert Augenfarbe, abhängig von Haarfarbe, nach Regel wie in 
   "Mit Mantel, Schwert und Zauberstab" S. 61. Einige dort nicht
   gelistete Haarfarben sind der Ähnlichkeit nach mit verteilt. 
   Haarfarben definiert in Haarfarben.json */

- (NSString *) augenfarbeVonHaarfarbeGenerieren: (NSString *) haarfarbe
{
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  //NSLog(@"AugenfarbenDict: %@", augenfarbenDict);
  
  //NSLog(@"Augenfarben WURF: %@", wurf);
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

- (NSDictionary *) famHerkunftGenerieren: (NSString *)characterType
{
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: @"1W20"];
  //NSLog(@"haarConstraint: %@", haarConstraint);
  //NSLog(@"wurf: %@", wurf);
  NSDictionary *herkuenfteDict = [NSDictionary dictionaryWithDictionary: [[self getTypusForTypus: characterType] objectForKey: @"Herkunft"]];
  NSArray *herkuenfteArr = [NSArray arrayWithArray: [herkuenfteDict allKeys]];
  NSMutableDictionary *retVal = [[NSMutableDictionary alloc] init];
  
  for (NSString *herkunft in herkuenfteArr)
    {
      if ([[[herkuenfteDict objectForKey: herkunft] objectForKey: @"W20"] containsObject: wurf])
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

@end
