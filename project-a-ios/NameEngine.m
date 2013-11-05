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
//  NameEngine.m
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "NameEngine.h"
#import "Dice.h"

@implementation NameEngine

@synthesize catNameIndex;
@synthesize catNameArray;

static NameEngine *_sharedEngine;

+(NameEngine *) sharedEngine {
    static BOOL initialized = NO;
    if ( ! initialized ) {
        initialized = YES;
        _sharedEngine = [[ NameEngine alloc ] init ];
    }
    return _sharedEngine;
}


-(id) init {
    if ((self=[super init])) {
        catNameIndex = 0;
        catNameArray = [[NSArray alloc] initWithObjects:
                     @"Max",
                     @"Chloe",
                     @"Bella",
                     @"Oliver",
                     @"Asparagus",
                     @"Tiger",
                     @"Smokey",
                     @"Shadow",
                     @"Lucy",
                     @"Angel",
                        nil];
    }
    return self;
}


-(NSString *) getNextCatName {
    NSString *returnName = nil;
    
    if ( catNameIndex < [catNameArray count] && catNameIndex >= 0 ) {
        returnName = [catNameArray objectAtIndex: catNameIndex];
        catNameIndex++;
        if ( catNameIndex >= [catNameArray count] ) {
            catNameIndex = 0;
        }
    }
    
    //return returnName;
    return [NSString stringWithFormat: @"%@ the Cat", returnName];
}


-(NSString *) getRandomCatName {
    NSInteger index = [Dice roll:[catNameArray count]];
    //return [catNameArray objectAtIndex:index];
    return [NSString stringWithFormat: @"%@ the Cat", [catNameArray objectAtIndex:index]];
}




+(NSString *) nameForMonsterType: (Monster_t) monsterType {
    NSString *names[MONSTER_T_NUMTYPES];
    names[MONSTER_T_NONE]   = @"";
    names[MONSTER_T_CAT]    = @"Cat";
    names[MONSTER_T_GHOUL]  = @"Ghoul";
    names[MONSTER_T_TREE]   = @"Tree";
    names[MONSTER_T_TOTORO] = @"Totoro";
    return names[monsterType];
}




+(NSString *) randomNameForPrefix: (Prefix_t) prefix {
    NSString *fire[1] = { @"Fire" };
    NSString *ice[1] = { @"Ice" };
    NSString *water[1] = { @"Water" };
    NSString *earth[1] = { @"Earth" };
    NSString *lightning[1] = { @"Lightning" };
    NSString *weak[1] = { @"Weak" };

    NSString *retVal = @"";

    switch ( prefix ) {
        case PREFIX_T_NONE:
            retVal = @"";
            break;
        case PREFIX_T_FIRE:
            retVal = fire[0];
            break;
        case PREFIX_T_ICE:
            retVal = ice[0];
            break;
        case PREFIX_T_WATER:
            retVal = water[0];
            break;
        case PREFIX_T_EARTH:
            retVal = earth[0];
            break;
        case PREFIX_T_LIGHTNING:
            retVal = lightning[0];
            break;
        case PREFIX_T_WEAK:
            retVal = weak[0];
            break;
        default: break;
    }

    return retVal;
}


@end
