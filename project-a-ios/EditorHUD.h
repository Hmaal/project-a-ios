//  EditorHUD.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "cocos2d.h"
#import "GameConfig.h"

#define NUMBER_OF_LABELS        4
@interface EditorHUD : CCLayerColor {
    CCLabelTTF *label;
}

@property (atomic) CCLabelTTF *label;

@end