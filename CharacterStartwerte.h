/* All rights reserved */

#import <AppKit/AppKit.h>



@interface CharacterStartwerte : NSObject
{
  IBOutlet NSPopUpButton *allCharacterTypes;
  NSMutableDictionary *talentStartWerte;
  NSMutableDictionary *typusDict;
  NSMutableDictionary *berufeDict;
  NSMutableArray *berufeArray;
  NSMutableDictionary *herkunftDict;
  NSMutableArray *herkunftArray;
  NSMutableDictionary *magierakademienDict;
  NSMutableArray *magierakademienArray;
  
}
- (IBAction) selectCharacterType: (id)sender;
- (NSArray *) getCharacterTypesList;
- (NSArray *) getBerufeList;
- (NSArray *) getHerkunftList;
- (NSArray *) getMagierakademienList;
- (NSDictionary *) getCharacterConstraintsForCharacter: (NSString *) characterType;
- (NSDictionary *) getTypusForTypus: (NSString *) characterType;

@end
