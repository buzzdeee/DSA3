/* All rights reserved */

#import <AppKit/AppKit.h>

@interface DSA3Main : NSObject
{
  IBOutlet NSWindow *winCharacterStartwerte;
}
- (IBAction) generateCharacter: (id)sender;
- (IBAction) loadGame: (id)sender;
- (IBAction) openBestiarium: (id)sender;
- (IBAction) openCharacterValues: (id)sender;
- (IBAction) openHerbarium: (id)sender;
- (IBAction) openSpells: (id)sender;
- (IBAction) openTrades: (id)sender;
- (IBAction) openWeapons: (id)sender;
- (IBAction) startGame: (id)sender;

@end
