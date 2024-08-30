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

#ifndef _UTILS_H_
#define _UTILS_H_

#import <Foundation/Foundation.h>

@class Charakter;


@interface Utils : NSObject

@property (readonly) NSMutableDictionary *talenteDict;
@property (readonly) NSMutableDictionary *typusDict;
@property (readonly) NSMutableDictionary *berufeDict;
@property (readonly) NSMutableDictionary *herkunftDict;
@property (readonly) NSMutableDictionary *magierakademienDict;
@property (readonly) NSMutableDictionary *augenfarbenDict;
@property (readonly) NSMutableDictionary *geburtstagDict;
@property (readonly) NSMutableDictionary *goetterDict;


// Declare a class method to get the
// shared instance of the class
// Use instancetype for modern Objective-C
+ (instancetype)sharedInstance;

+ (NSDictionary *) parseWuerfel: (NSString *) wuerfelDefinition;
+ (NSDictionary *) parseConstraint: (NSString *) constraintDefinition;
+ (NSNumber *) wuerfelnMitWuerfel: (NSString *) wuerfelDefinition;

- (NSArray *) positiveEigenschaftenGenerieren;
- (NSArray *) negativeEigenschaftenGenerieren;
- (NSDictionary *) geburtstagGenerieren;
- (NSString *) groesseGenerieren: (NSString *) characterType;
- (NSString *) gewichtGenerieren: (NSString *) characterType groesse: (NSString *) groesse;
- (NSDictionary *) famHerkunftGenerieren: (NSString *)characterType;
- (NSDictionary *) startvermoegenGenerieren: (NSString *)stand;
- (NSDictionary *) getTypusForTypus: (NSString *) characterType;
- (NSArray *) getAllTypusKategorien;
- (NSArray *) getAllTypusForKategorie: (NSString *) kategorie;
- (NSMutableDictionary *) getTalenteForTypus: (NSString *) characterType;
- (NSArray *) getBerufeForTypus: (NSString *) characterType;
- (NSArray *) getHerkuenfteForTypus: (NSString *) characterType;

- (NSString *) getHaarfarbeForTypus: (NSString *) characterType;
- (NSString *) getAugenfarbeForTypus: (NSString *) characterType withHaarfarbe: (NSString *) haarfarbe;
- (NSString *) getProbeStringFromProbeDict: (NSArray *) probe;
- (NSMutableDictionary *) getTalentDictFromTalenteDict: (NSMutableDictionary *) dict forTalent: (NSString *) talent;

- (void) apply: (NSString *) what toCharakter: (Charakter *) charakter;


@end

#endif // _UTILS_H_

