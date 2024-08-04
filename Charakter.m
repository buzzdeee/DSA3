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
@synthesize geschlecht;
@synthesize haarfarbe;
@synthesize augenfarbe;
@synthesize groesse;
@synthesize gewicht;
@synthesize geburtstag;
@synthesize gottheit;
@synthesize sterne;
@synthesize eltern;
@synthesize le;
@synthesize ae;
@synthesize ke;
@synthesize positiveEigenschaften;
@synthesize negativeEigenschaften;

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
  [self setGeschlecht: [decoder decodeObjectForKey:@"geschlecht"]];
  [self setHaarfarbe: [decoder decodeObjectForKey:@"haarfarbe"]];
  [self setAugenfarbe: [decoder decodeObjectForKey:@"augenfarbe"]];
  [self setGroesse: [decoder decodeObjectForKey:@"groesse"]];
  [self setGewicht: [decoder decodeObjectForKey:@"gewicht"]];
  [self setGeburtstag: [decoder decodeObjectForKey:@"geburtstag"]];
  [self setGottheit: [decoder decodeObjectForKey:@"gottheit"]];
  [self setSterne: [decoder decodeObjectForKey:@"sterne"]];
  [self setEltern: [decoder decodeObjectForKey:@"eltern"]];
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
    [encoder encodeObject: geschlecht forKey:@"geschlecht"];
    [encoder encodeObject: haarfarbe forKey:@"haarfarbe"];
    [encoder encodeObject: augenfarbe forKey:@"augenfarbe"];
    [encoder encodeObject: groesse forKey:@"groesse"];
    [encoder encodeObject: gewicht forKey:@"gewicht"];
    [encoder encodeObject: geburtstag forKey:@"geburtstag"];
    [encoder encodeObject: gottheit forKey:@"gottheit"];
    [encoder encodeObject: sterne forKey:@"sterne"];
    [encoder encodeObject: eltern forKey:@"eltern"];
    [encoder encodeInteger: le forKey:@"le"];                                        
    [encoder encodeInteger: ae forKey:@"ae"];
    [encoder encodeInteger: ke forKey:@"ke"];
    [encoder encodeObject: positiveEigenschaften forKey:@"positiveEigenschaften"];                                        
    [encoder encodeObject: negativeEigenschaften forKey:@"negativeEigenschaften"];                                                
}

@end
