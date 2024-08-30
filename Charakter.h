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

#ifndef _CHARAKTER_H_
#define _CHARAKTER_H_

#import <Foundation/Foundation.h>

@class Utils;

@interface Charakter : NSObject <NSCoding> {
  Utils *utils;
}
@property (nonatomic) NSInteger stufe;
@property (nonatomic) NSInteger abenteuerPunkte;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *titel;
@property (nonatomic) NSString *typus;
@property (nonatomic) NSString *herkunft;
@property (nonatomic) NSArray *berufe;
@property (nonatomic) NSString *magischeSchule;
@property (nonatomic) NSString *geschlecht;
@property (nonatomic) NSString *haarfarbe;
@property (nonatomic) NSString *augenfarbe;
@property (nonatomic) NSString *groesse;
@property (nonatomic) NSString *gewicht;
@property (nonatomic) NSDictionary *geburtstag;
@property (nonatomic) NSString *gottheit;
@property (nonatomic) NSString *sterne;
@property (nonatomic) NSString *eltern;
@property (nonatomic) NSString *stand;
@property (nonatomic) NSDictionary *vermoegen;
@property (nonatomic) NSInteger le;
@property (nonatomic) NSInteger ae;
@property (nonatomic) NSInteger ke;
@property (nonatomic) NSInteger mrBonus;
@property (nonatomic) NSMutableDictionary *positiveEigenschaften;
@property (nonatomic) NSMutableDictionary *negativeEigenschaften;
@property (nonatomic) NSMutableDictionary *talente;
@property (nonatomic) NSMutableDictionary *steigerungsTalente;
@property (readonly) NSInteger atBasiswert;
@property (readonly) NSInteger paBasiswert;
@property (readonly) NSInteger fkBasiswert;
@property (readonly) NSInteger ausweichenBasiswert;
@property (readonly) NSInteger magieResistenz;
@property (readonly) NSInteger behinderung;
@property (readonly) NSInteger ausdauer;
@property (readonly) NSInteger tragkraft;
@property (readonly) NSInteger last;


- (void) steigereTalent: (NSString *) talent;
@end




#endif // _CHARAKTER_H_

