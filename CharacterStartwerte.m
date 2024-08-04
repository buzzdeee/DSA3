/* All rights reserved */

#import <AppKit/AppKit.h>
#import <Foundation/NSJSONSerialization.h>
#import "CharacterStartwerte.h"

static CharacterStartwerte *singleton;

@implementation CharacterStartwerte
+ new
{
  if (singleton == nil)
    singleton = [[self alloc] init];
  return singleton;
}

- (id) init
{
  if ((self = [super init]))
    {
      NSError *e = nil;
      talentStartWerte = [NSJSONSerialization 
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
        
    }
  if (singleton != nil)
    {
      RELEASE(self);
      self = RETAIN(singleton);
      NSLog(@"singleton existed");
    }
    else
    {
      singleton = self;
      NSLog(@"singleton didn't exist");
    }
  return self;
}

- (void) dealloc
{

}

- (NSArray *) getCharacterTypesList
{
  return [typusDict allKeys];
}

- (NSArray *) getBerufeList
{
  return [berufeDict allKeys];
}

- (NSArray *) getHerkunftList
{
  return [herkunftDict allKeys];
}

- (NSArray *) getMagierakademienList
{
  return [magierakademienDict allKeys];
}

- (NSDictionary *) getCharacterConstraintsForCharacter: (NSString *) characterType
{
  return [typusDict objectForKey: characterType];
}
- (NSDictionary *) getTypusForTypus: (NSString *) characterType
{
  return [typusDict objectForKey: characterType];
}

- (IBAction) selectCharacterType: (id)sender
{
  NSLog(@"%@", [allCharacterTypes itemTitles]);
  [allCharacterTypes addItemsWithTitles:[typusDict allKeys]];
}

@end
