/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
//  Items.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@interface Items : NSObject { }

+(Entity *) randomItem;
+(Entity *) bookOfAllKnowing;
+(Entity *) potionOfLightHealing:(NSInteger) bonus;
+(Entity *) poisonAntidote;
+(Entity *) greenBlob;

// Fishing
+(Entity *) catfish;
+(Entity *) woodenFishingRod;

+(Entity *) torch: (NSInteger) light;

// Doors
+(Entity *) simpleDoor;
+(Entity *) simpleKey;
+(Entity *) basicBoulder;

// Magic items
+(Entity *) scrollOfCureLightWounds;
+(Entity *) wandOfCureLightWounds;

+(Entity *) ringOfRegeneration;
+(Entity *) ringOfAntihunger;

+(Entity *) coin: (NSInteger) coinValue;

+(Entity *) note: (NSString *) text;



@end