/*
   Project: DSA3

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-07-31 20:31:00 +0200 by sebastia

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

#import "Charakter.h"
#import "Utils.h"
#import "NSDictionary+Extras.h"

@implementation Charakter
//#pragma mark - NSCoding

@synthesize stufe;
@synthesize abenteuerPunkte;
@synthesize name;
@synthesize titel;
@synthesize typus;
@synthesize herkunft;
@synthesize berufe;
@synthesize magischeSchule;
@synthesize geschlecht;
@synthesize haarfarbe;
@synthesize augenfarbe;
@synthesize groesse;
@synthesize gewicht;
@synthesize geburtstag;
@synthesize gottheit;
@synthesize sterne;
@synthesize eltern;
@synthesize stand;
@synthesize vermoegen;
@synthesize le;
@synthesize ae;
@synthesize ke;
@synthesize mrBonus;
@synthesize positiveEigenschaften;
@synthesize negativeEigenschaften;
@synthesize talente;
@synthesize steigerungsTalente;


- (id) init
{
  if ((self = [super init]))
    {
      utils = [Utils sharedInstance];      
    }
  return self;
}

- (void) setStufe: (NSInteger)inStufe
{
  [self willChangeValueForKey: @"stufe"];
  stufe = inStufe;
  [self didChangeValueForKey: @"stufe"];
}

- (void) setAbenteuerPunkte: (NSInteger)inAbenteuerPunkte
{
  [self willChangeValueForKey: @"abenteuerPunkte"];
  abenteuerPunkte = inAbenteuerPunkte;
  [self didChangeValueForKey: @"abenteuerPunkte"];
}

- (void) setName: (NSString *)inName
{
  [self willChangeValueForKey: @"name"];
  name = inName;
  [self didChangeValueForKey: @"name"];
}

- (void) setTitel: (NSString *)inTitel
{
  [self willChangeValueForKey: @"titel"];
  titel = inTitel;
  [self didChangeValueForKey: @"titel"];
}

- (void) setTypus: (NSString *)inTypus
{
  [self willChangeValueForKey: @"typus"];
  typus = inTypus;
  [self didChangeValueForKey: @"typus"];
}

- (void) setHerkunft: (NSString *)inHerkunft
{
  [self willChangeValueForKey: @"herkunft"];
  herkunft = inHerkunft;
  [self didChangeValueForKey: @"herkunft"];
}

- (void) setBerufe: (NSArray *)inBerufe
{
  [self willChangeValueForKey: @"berufe"];
  berufe = inBerufe;
  [self didChangeValueForKey: @"berufe"];
}

- (void) setMagischeSchule: (NSString *)inMagischeSchule
{
  [self willChangeValueForKey: @"magischeSchule"];
  magischeSchule = inMagischeSchule;
  [self didChangeValueForKey: @"magischeSchule"];
}

- (void) setGeschlecht: (NSString *)inGeschlecht
{
  [self willChangeValueForKey: @"geschlecht"];
  geschlecht = inGeschlecht;
  [self didChangeValueForKey: @"geschlecht"];
}

- (void) setHaarfarbe: (NSString *)inHaarfarbe
{
  [self willChangeValueForKey: @"haarfarbe"];
  haarfarbe = inHaarfarbe;
  [self didChangeValueForKey: @"haarfarbe"];
}

- (void) setAugenfarbe: (NSString *)inAugenfarbe
{
  [self willChangeValueForKey: @"augenfarbe"];
  augenfarbe = inAugenfarbe;
  [self didChangeValueForKey: @"augenfarbe"];
}

- (void) setGroesse: (NSString *)inGroesse
{
  [self willChangeValueForKey: @"groesse"];
  groesse = inGroesse;
  [self didChangeValueForKey: @"groesse"];
}

- (void) setGewicht: (NSString *)inGewicht
{
  [self willChangeValueForKey: @"gewicht"];
  gewicht = inGewicht;
  [self didChangeValueForKey: @"gewicht"];
}

- (void) setGeburtstag: (NSDictionary *)inGeburtstag
{
  [self willChangeValueForKey: @"geburtstag"];
  geburtstag = inGeburtstag;
  [self didChangeValueForKey: @"geburtstag"];
}

- (void) setGottheit: (NSString *)inGottheit
{
  [self willChangeValueForKey: @"gottheit"];
  gottheit = inGottheit;
  [self didChangeValueForKey: @"gottheit"];
}

- (void) setSterne: (NSString *)inSterne
{
  [self willChangeValueForKey: @"sterne"];
  sterne = inSterne;
  [self didChangeValueForKey: @"sterne"];
}

- (void) setEltern: (NSString *)inEltern
{
  [self willChangeValueForKey: @"eltern"];
  eltern = inEltern;
  [self didChangeValueForKey: @"eltern"];
}

- (void) setStand: (NSString *)inStand
{
  [self willChangeValueForKey: @"stand"];
  stand = inStand;
  [self didChangeValueForKey: @"stand"];
}

- (void) setVermoegen: (NSDictionary *)inVermoegen
{
  [self willChangeValueForKey: @"vermoegen"];
  vermoegen = inVermoegen;
  [self didChangeValueForKey: @"vermoegen"];
}

- (void) setLe: (NSInteger)inLe
{
  [self willChangeValueForKey: @"le"];
  le = inLe;
  [self didChangeValueForKey: @"le"];
}

- (void) setAe: (NSInteger)inAe
{
  [self willChangeValueForKey: @"ae"];
  ae = inAe;
  [self didChangeValueForKey: @"ae"];
}

- (void) setKe: (NSInteger)inKe
{
  [self willChangeValueForKey: @"ke"];
  ke = inKe;
  [self didChangeValueForKey: @"ke"];
}

- (void) setMrBonus: (NSInteger)inMrBonus
{
  [self willChangeValueForKey: @"mrBonus"];
  mrBonus = inMrBonus;
  [self didChangeValueForKey: @"mrBonus"];
}

- (void) setPositiveEigenschaften: (NSMutableDictionary *)inPositiveEigenschaften
{
  [self willChangeValueForKey: @"positiveEigenschaften"];
  positiveEigenschaften = inPositiveEigenschaften;
  [self didChangeValueForKey: @"positiveEigenschaften"];
}

- (void) setNegativeEigenschaften: (NSMutableDictionary *)inNegativeEigenschaften
{
  [self willChangeValueForKey: @"negativeEigenschaften"];
  negativeEigenschaften = inNegativeEigenschaften;
  [self didChangeValueForKey: @"negativeEigenschaften"];
}

- (void) setTalente: (NSMutableDictionary *)inTalente
{
  [self willChangeValueForKey: @"talente"];
  talente = inTalente;
  [self didChangeValueForKey: @"talente"];
}

- (void) setSteigerungsTalente: (NSMutableDictionary *)inSteigerungsTalente
{
  [self willChangeValueForKey: @"steigerungsTalente"];
  steigerungsTalente = inSteigerungsTalente;
  [self didChangeValueForKey: @"steigerungsTalente"];
}


- (void) steigereTalent: (NSString *) talent
{
  NSMutableDictionary *steigerungsTalentDict = [utils getTalentDictFromTalenteDict: steigerungsTalente forTalent: talent];
  NSMutableDictionary *talentDict = [utils getTalentDictFromTalenteDict: talente forTalent: talent];
  
  NSLog(@"steigereTalent: AM ANFANG: talentDict: %@", talentDict);
  NSLog(@"steigereTalent: AM ANFANG: steigerungsTalentDict: %@", steigerungsTalentDict);
  NSLog(@"steigereTalent: AM ANFANG: steigerungsTalente: %@", steigerungsTalente);
  NSString *wuerfel = [[NSString alloc] init];
  
  if ([[steigerungsTalentDict objectForKey: @"Versuche"] integerValue] == 0)
    {
      NSLog(@"steigern von %@ nicht mehr möglich!", talent);
      return;
    }
  
  if ([[steigerungsTalentDict objectForKey: @"Startwert"] integerValue] < 10)
    {
      wuerfel = @"2W6";
    }
  else
    {
      wuerfel = @"3W6";
    }
  
  NSNumber *wurf = [Utils wuerfelnMitWuerfel: wuerfel];
  NSLog(@"THE WURF: %@", wurf);
  NSInteger currentTalentValue = [[steigerungsTalentDict objectForKey: @"Startwert"] integerValue];
  NSInteger versuche = [[steigerungsTalentDict objectForKey: @"Versuche"] integerValue];
  NSInteger steigern = [[steigerungsTalentDict objectForKey: @"Steigern"] integerValue];  

  NSString *verbleibendeVersuche = [NSString stringWithFormat: @"%li", 
                                   [[steigerungsTalente
                                         objectForKey: @"verbleibendeVersuche"] integerValue] - 1];
  [steigerungsTalente setValue: verbleibendeVersuche  forKey: @"verbleibendeVersuche"];  
    
  if ([wurf integerValue] > currentTalentValue)
    {
      NSLog(@"Steigern SUCCESS!!!");
     steigern = steigern - 1;
     versuche = steigern * 3;
     currentTalentValue = currentTalentValue + 1;
     NSLog(@"NACH BERECHNUNG!!! %@", steigerungsTalentDict);

     
          
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", steigern] forKey: @"Steigern"];
     NSLog(@"NACH STEIGERN");
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", versuche] forKey: @"Versuche"];
          NSLog(@"NACH VERSUCHE");
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", currentTalentValue] forKey: @"Startwert"];
     NSLog(@"NACH STARTWERT");
     [talentDict setValue: [NSString stringWithFormat: @"%li", currentTalentValue] forKey: @"Startwert"];

     NSLog(@"steigerungsTalentDict: %@, talentDict: %@", steigerungsTalentDict, talentDict);
     NSLog(@"SUCCESS ENDE!!!");
    }
  else
    {
      NSLog(@"Steigern FAILURE!!!");
      versuche = versuche - 1;
      if (versuche % steigern == 0)
        {
          steigern = steigern -1;
        }
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", steigern] forKey: @"Steigern"];
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", versuche] forKey: @"Versuche"];
     [steigerungsTalentDict setValue: [NSString stringWithFormat: @"%li", currentTalentValue] forKey: @"Startwert"];
    }
  
  NSString *keyPath = [talente findKeyPathForKey: talent];
  NSLog(@"FOUND KEY PATH: %@", keyPath);
  [talente setValue: talentDict forKeyPath: keyPath];
  keyPath = [steigerungsTalente findKeyPathForKey: talent];
  NSLog(@"FOUND KEY PATH: %@", keyPath);
  NSLog(@"setting BEFORE setValue steigerungsTalente %@!!!", steigerungsTalente);
  [steigerungsTalente setValue: steigerungsTalentDict forKeyPath: keyPath];
  NSLog(@"steigereTalent: AM ENDE: talentDict: %@", [utils getTalentDictFromTalenteDict: talente forTalent: talent]);
  NSLog(@"steigereTalent: AM ENDE: steigerungsTalentDict: %@", [utils getTalentDictFromTalenteDict: steigerungsTalente forTalent: talent]);
  
  NSLog(@"steigereTalent: AM ENDE: steigerungsTalente: %@", steigerungsTalente);
  //NSLog(@"steigereTalent: AM ENDE: talente: %@", talente);
  
  
}

- (id)initWithCoder:(NSCoder *)decoder
{
  self = [super init];
  if (!self)
  {
    NSLog(@"Charakter initWithCoder returning NIL!");
    return nil;
  }
  
  NSLog(@"Charakter initWithCoder!");
  [self setStufe: [decoder decodeIntegerForKey:@"stufe"]];
  [self setAbenteuerPunkte: [decoder decodeIntegerForKey:@"abenteuerPunkte"]];  
  [self setName: [decoder decodeObjectForKey:@"name"]];
  [self setTitel: [decoder decodeObjectForKey:@"titel"]];
  [self setTypus: [decoder decodeObjectForKey:@"typus"]];
  [self setHerkunft: [decoder decodeObjectForKey:@"herkunft"]];
  [self setBerufe: [decoder decodeObjectForKey:@"berufe"]];
  [self setMagischeSchule: [decoder decodeObjectForKey:@"magischeSchule"]];
  [self setGeschlecht: [decoder decodeObjectForKey:@"geschlecht"]];
  [self setHaarfarbe: [decoder decodeObjectForKey:@"haarfarbe"]];
  [self setAugenfarbe: [decoder decodeObjectForKey:@"augenfarbe"]];
  [self setGroesse: [decoder decodeObjectForKey:@"groesse"]];
  [self setGewicht: [decoder decodeObjectForKey:@"gewicht"]];
  [self setGeburtstag: [decoder decodeObjectForKey:@"geburtstag"]];
  [self setGottheit: [decoder decodeObjectForKey:@"gottheit"]];
  [self setSterne: [decoder decodeObjectForKey:@"sterne"]];
  [self setEltern: [decoder decodeObjectForKey:@"eltern"]];
  [self setStand: [decoder decodeObjectForKey:@"stand"]];
  [self setVermoegen: [decoder decodeObjectForKey:@"vermoegen"]];  
  [self setLe: [decoder decodeIntegerForKey:@"le"]];
  [self setAe: [decoder decodeIntegerForKey:@"ae"]];
  [self setKe: [decoder decodeIntegerForKey:@"ke"]];
  [self setMrBonus: [decoder decodeIntegerForKey:@"mrBonus"]];  
  [self setPositiveEigenschaften: [decoder decodeObjectForKey:@"positiveEigenschaften"]];
  [self setNegativeEigenschaften: [decoder decodeObjectForKey:@"negativeEigenschaften"]];
  [self setTalente: [decoder decodeObjectForKey:@"talente"]];
  [self setSteigerungsTalente: [decoder decodeObjectForKey:@"steigerungsTalente"]];  
  return self;                          
}

- (void)encodeWithCoder:(NSCoder *)encoder {

  NSLog(@"Charakter encodeWithCoder!");

    [encoder encodeInteger: stufe forKey:@"stufe"];                                        
    [encoder encodeInteger: abenteuerPunkte forKey:@"abenteuerPunkte"];
    [encoder encodeObject: name forKey:@"name"];
    [encoder encodeObject: titel forKey:@"titel"];
    [encoder encodeObject: typus forKey:@"typus"];
    [encoder encodeObject: herkunft forKey:@"herkunft"];
    [encoder encodeObject: berufe forKey:@"berufe"];
    [encoder encodeObject: magischeSchule forKey:@"magischeSchule"];
    [encoder encodeObject: geschlecht forKey:@"geschlecht"];
    [encoder encodeObject: haarfarbe forKey:@"haarfarbe"];
    [encoder encodeObject: augenfarbe forKey:@"augenfarbe"];
    [encoder encodeObject: groesse forKey:@"groesse"];
    [encoder encodeObject: gewicht forKey:@"gewicht"];
    [encoder encodeObject: geburtstag forKey:@"geburtstag"];
    [encoder encodeObject: gottheit forKey:@"gottheit"];
    [encoder encodeObject: sterne forKey:@"sterne"];
    [encoder encodeObject: eltern forKey:@"eltern"];
    [encoder encodeObject: eltern forKey:@"stand"];    
    [encoder encodeObject: eltern forKey:@"vermoegen"];        
    [encoder encodeInteger: le forKey:@"le"];                                        
    [encoder encodeInteger: ae forKey:@"ae"];
    [encoder encodeInteger: ke forKey:@"ke"];
    [encoder encodeInteger: mrBonus forKey:@"mrBonus"];    
    [encoder encodeObject: positiveEigenschaften forKey:@"positiveEigenschaften"];                                        
    [encoder encodeObject: negativeEigenschaften forKey:@"negativeEigenschaften"];
    [encoder encodeObject: talente forKey:@"talente"];       
    [encoder encodeObject: steigerungsTalente forKey:@"steigerungsTalente"];                                           
}


// calculated propperties below

- (NSInteger) atBasiswert {
  NSInteger retVal;
  
  retVal = round(([[positiveEigenschaften objectForKey: @"MU"] integerValue] + 
                  [[positiveEigenschaften objectForKey: @"GE"] integerValue] + 
                  [[positiveEigenschaften objectForKey: @"KK"] integerValue]) / 5);
  return retVal;
}


- (NSInteger) paBasiswert {
  NSInteger retVal;
  
  retVal = round(([[positiveEigenschaften objectForKey: @"IN"] integerValue] + 
                  [[positiveEigenschaften objectForKey: @"GE"] integerValue] + 
                  [[positiveEigenschaften objectForKey: @"KK"] integerValue]) / 5);
  return retVal;
}


- (NSInteger) fkBasiswert {
  NSInteger retVal;
  
  retVal = floor(([[positiveEigenschaften objectForKey: @"IN"] integerValue] + 
                 [[positiveEigenschaften objectForKey: @"FF"] integerValue] + 
                 [[positiveEigenschaften objectForKey: @"KK"] integerValue]) / 4);
  return retVal;
}

- (NSInteger) ausweichenBasiswert {
  NSInteger retVal;
  
  retVal = floor(([[positiveEigenschaften objectForKey: @"MU"] integerValue] + 
                 [[positiveEigenschaften objectForKey: @"IN"] integerValue] + 
                 [[positiveEigenschaften objectForKey: @"GE"] integerValue]) / 4) - [self behinderung];
  return retVal;
}

- (NSInteger) behinderung {
  NSLog(@"Berechnung Behinderung fehlt!!!");
  return 0;
}

- (NSInteger) magieResistenz {
  NSInteger retVal;
  
  retVal = floor(([[positiveEigenschaften objectForKey: @"MU"] integerValue] + 
                 [[positiveEigenschaften objectForKey: @"KL"] integerValue] +
                 [self stufe]) / 3) - 2 * [[negativeEigenschaften objectForKey: @"AG"] integerValue];
  return retVal;
}

/* Ausdauer, wie beschrieben in: Abenteuer Basis Spiel, Regelbuch II, S. 9 */
- (NSInteger) ausdauer {
  NSInteger retVal;

  retVal = [self le] * [[positiveEigenschaften objectForKey: @"KK"] integerValue];
  
  return retVal;
}

/* Tragkraft, wie beschrieben in: Abenteuer Basis Spiel, Regelbuch II, S. 9 */
- (NSInteger) tragkraft {
  NSInteger retVal;
  
  retVal = [[positiveEigenschaften objectForKey: @"KK"] integerValue] * 50;
  
  return retVal;
}

/* Last, wie beschrieben in: Abenteuer Basis Spiel, Regelbuch II, S. 9 */
- (NSInteger) last {
  NSLog(@"Berechnung Last fehlt!!!");
  return 1;
}

+ (NSSet *) keyPathsForValuesAffectingValueForKey: (NSString *)key
{
  NSSet *paths = [super keyPathsForValuesAffectingValueForKey: key];
  if ([@"atBasiswert" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.MU",  
                                       @"positiveEigenschaften.GE", 
                                       @"positiveEigenschaften.KK", nil]];
    }
  else if ([@"paBasiswert" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.IN",  
                                       @"positiveEigenschaften.GE", 
                                       @"positiveEigenschaften.KK", nil]];
    }
  else if ([@"fkBasiswert" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.IN",  
                                       @"positiveEigenschaften.FF", 
                                       @"positiveEigenschaften.KK", nil]];
    }
  else if ([@"ausweichenBasiswert" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.MU",  
                                       @"positiveEigenschaften.IN", 
                                       @"positiveEigenschaften.GE", nil]];
    }
  else if ([@"magieResistenz" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.MU",  
                                       @"positiveEigenschaften.KL", 
                                       @"positiveEigenschaften.AG", 
                                       @"stufe", nil]];
    }  
  else if ([@"ausdauer" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.KK", 
                                       @"le", nil]];
    }  
  else if ([@"tragkraft" isEqualTo: key])
    {
      paths = [paths setByAddingObjectsFromSet: 
                [NSSet setWithObjects: @"positiveEigenschaften.KK", nil]];
    }                
  return paths;
}

@end
