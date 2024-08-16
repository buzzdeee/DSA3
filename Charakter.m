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




@implementation Charakter
//#pragma mark - NSCoding

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
@synthesize positiveEigenschaften;
@synthesize negativeEigenschaften;

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

- (void) setPositiveEigenschaften: (NSDictionary *)inPositiveEigenschaften
{
  [self willChangeValueForKey: @"positiveEigenschaften"];
  positiveEigenschaften = inPositiveEigenschaften;
  [self didChangeValueForKey: @"positiveEigenschaften"];
}

- (void) setNegativeEigenschaften: (NSDictionary *)inNegativeEigenschaften
{
  [self willChangeValueForKey: @"negativeEigenschaften"];
  negativeEigenschaften = inNegativeEigenschaften;
  [self didChangeValueForKey: @"negativeEigenschaften"];
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
  [self setPositiveEigenschaften: [decoder decodeObjectForKey:@"positiveEigenschaften"]];
  [self setNegativeEigenschaften: [decoder decodeObjectForKey:@"negativeEigenschaften"]];          
  return self;                          
}

- (void)encodeWithCoder:(NSCoder *)encoder {

  NSLog(@"Charakter encodeWithCoder!");

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
    [encoder encodeObject: positiveEigenschaften forKey:@"positiveEigenschaften"];                                        
    [encoder encodeObject: negativeEigenschaften forKey:@"negativeEigenschaften"];                                                
}

@end
