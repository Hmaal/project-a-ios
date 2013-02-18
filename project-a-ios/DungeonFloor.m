//  DungeonFloor.m
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "DungeonFloor.h"

@implementation DungeonFloor

@synthesize height;
@synthesize width;
@synthesize tileDataArray;

/*
 ====================
 init
 ====================
 */
-( id ) init {
    MLOG( @"init" );
    if ( ( self = [ super init ] ) ) {
        width = 0;
        height = 0;
        tileDataArray = [[ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 newFloor
 ====================
 */
+( DungeonFloor * ) newFloor {
    //MLOG( @"newFloor" );
    NSUInteger dw = 5; // true dungeon width
    NSUInteger dh = 5; // true dungeon width
    NSUInteger border = 20;
    NSUInteger dungeonWidth = border + dw;  // x-20
    NSUInteger dungeonHeight = border + dw; // x-20
    DungeonFloor *floor = [[ DungeonFloor alloc ] init ];
    floor->width = dungeonWidth;
    floor->height = dungeonHeight;
    for ( int j = 0 ; j < dungeonHeight ; j++ ) {
        for ( int i = 0; i < dungeonWidth; i++ ) {
            Tile *newTile = [ Tile newTileWithType: TILE_DEFAULT withPosition: ccp(i, j)];
            [ floor->tileDataArray addObject: newTile ];
        }
    }
    //MLOG( @"end newFloor" );
    return floor;
}

@end