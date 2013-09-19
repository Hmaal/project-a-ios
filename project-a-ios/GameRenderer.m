//  GameRenderer.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameRenderer.h"

@implementation GameRenderer

static BOOL modTableInitialized             = NO;
static BOOL strengthWeightTableInitialized  = NO;
static const NSInteger modTableSize         = 50;
static NSInteger modTable[ modTableSize ];
static NSInteger strengthWeightTable[ modTableSize ];

#define WEIGHT_FACTOR 3
#define WEIGHT_FORMULA(n) (n * WEIGHT_FACTOR + n)

void initModTable() {
    if ( ! modTableInitialized ) {
        NSInteger mod = -5;
        modTable[ 0 ] = mod;
        for (int i=1; i < modTableSize; i++) {
            if ( i % 2 == 0 ) {
                mod++;
            }
            modTable[ i ] = mod;
        }
        modTableInitialized = YES;
    }
}

void initStrengthWeightTable() {
    if ( ! strengthWeightTableInitialized ) {
        strengthWeightTable[ 0 ] = 0;
        for (int i=1; i<modTableSize; i++) {
            strengthWeightTable[ i ] = WEIGHT_FORMULA(i);
        }
        strengthWeightTableInitialized = YES;
    }
}

NSInteger getWeightForStrength( NSInteger str ) {
    ! strengthWeightTableInitialized ? initStrengthWeightTable() : 0;
    return strengthWeightTable[ str ];
}

NSInteger getMod( NSInteger n ) {
    ! modTableInitialized ? initModTable() : 0;
    return modTable[ n ];
}


// Tools...
+( NSInteger ) modifierForNumber: (NSInteger) n         { return getMod( n ); }
+( NSInteger ) maxWeightForStrength: (NSInteger) str    { return getWeightForStrength(str); }




static NSString *metalTable [3] = { @"", @"Iron", @"Steel" };
static NSString *woodTable  [2] = { @"", @"Fir" };
static NSString *stoneTable [2] = { @"", @"Rock" };
static NSString *clothTable [2] = { @"", @"Cloth" };



+( NSString * ) getMetalName:(Metal_t)metal {
    NSString *s = nil;
    if ( metal >= METAL_T_NONE && metal < METAL_T_COUNT )
        s = metalTable[ metal ];
    MLOG(@"Generated metal: \"%@\"", s);
    return s;
    
}

+( NSString * ) getWoodName:(Wood_t)wood {
    NSString *s = nil;
    if ( wood >= WOOD_T_NONE && wood < WOOD_T_COUNT )
        s = woodTable[ wood ];
    MLOG(@"Generated wood: \"%@\"", s);
    return s;
    
}

+( NSString * ) getStoneName:(Stone_t)stone {
    NSString *s = nil;
    if ( stone >= STONE_T_NONE && stone < STONE_T_COUNT )
        s = stoneTable[ stone ];
    MLOG(@"Generated stone: \"%@\"", s);
    return s;
    
}

+( NSString * ) getClothName:(Cloth_t)cloth {
    NSString *s = nil;
    if ( cloth >= CLOTH_T_NONE && cloth < CLOTH_T_COUNT )
        s = clothTable[ cloth ];
    MLOG(@"Generated cloth: \"%@\"", s);
    return s;
    
}






/*
 ====================
 colorScrambleTile
 ====================
 */
+( void ) colorScrambleTile: ( CCSprite * ) tileSprite {
    CCMutableTexture2D *tileTex = ( CCMutableTexture2D * ) tileSprite.texture;
    //srand( time( NULL ) );
    for ( int i = 0; i < TILE_SIZE; i++ ) {
        for ( int j = 0; j < TILE_SIZE; j++ ) {
            //Color_t randomColor = random_color;
            //[ tileTex setPixelAt: ccp( i, j ) rgba: randomColor ];
        }
        [ tileTex fill: random_color ];
    }
    [ tileTex apply ];
}


/*
 ====================
 colorScrambleAllTiles
 ====================
 */
+( void ) colorScrambleAllTiles: ( NSArray * ) tileArray {
    for ( int i = 0; i < [ tileArray count ]; i++ ) {
        CCSprite *tileSprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer colorScrambleTile: tileSprite ];
    }
}


+( void) renderTileColorFuzz: (CCMutableTexture2D *) texture {
    for (int i=0; i<texture.contentSizeInPixels.width; i++)
        for (int j=0; j<texture.contentSizeInPixels.height; j++)
            [texture setPixelAt:ccp(i,j) rgba:random_color];
    [texture apply];
}


/*
 ====================
 setTile
 ====================
 */
+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data withSprites: (NSDictionary *) sprites withFloor: (DungeonFloor *) floor {
//+( void ) setTile: ( CCSprite * ) tileSprite withData: ( Tile * ) data {
    Tile_t tileType = data.tileType;
 
    CCMutableTexture2D *tileTexture =
    
    [sprites objectForKey:KEY_FOR_TILETYPE(tileType)]; // NEW :X MIGHT WORK!
    
    /*
    tileType == TILE_FLOOR_STONE_0               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_0)]      :
    tileType == TILE_FLOOR_STONE_1               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_1)]      :
    tileType == TILE_FLOOR_STONE_2               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_2)]      :
    tileType == TILE_FLOOR_STONE_3               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_3)]      :
    tileType == TILE_FLOOR_STONE_4               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_4)]      :
    tileType == TILE_FLOOR_STONE_5               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_5)]      :
    tileType == TILE_FLOOR_STONE_6               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_6)]      :
    tileType == TILE_FLOOR_STONE_7               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_7)]      :
    tileType == TILE_FLOOR_STONE_8               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_8)]      :
    tileType == TILE_FLOOR_STONE_9               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_9)]      :
    tileType == TILE_FLOOR_STONE_10               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_10)]      :
    tileType == TILE_FLOOR_STONE_11               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_11)]      :
    tileType == TILE_FLOOR_STONE_12               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_12)]      :
    tileType == TILE_FLOOR_STONE_13               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_13)]      :
    tileType == TILE_FLOOR_STONE_14               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_14)]      :
    tileType == TILE_FLOOR_STONE_15               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_15)]      :
    tileType == TILE_FLOOR_STONE_16               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_16)]      :
    tileType == TILE_FLOOR_STONE_17               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_17)]      :
    tileType == TILE_FLOOR_STONE_18               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_18)]      :
    tileType == TILE_FLOOR_STONE_19               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_19)]      :
    tileType == TILE_FLOOR_STONE_20               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_20)]      :
    tileType == TILE_FLOOR_STONE_21               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_21)]      :
    tileType == TILE_FLOOR_STONE_22               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_22)]      :
    tileType == TILE_FLOOR_STONE_23               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_23)]      :
    tileType == TILE_FLOOR_STONE_24               ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_STONE_24)]      :
    
    
    tileType == TILE_FLOOR_GRASS_0          ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_GRASS_0)]      :
    tileType == TILE_FLOOR_GRASS_1          ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_GRASS_1)]      :
    
    tileType == TILE_FLOOR_SAND_0 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_0)] : 
    tileType == TILE_FLOOR_SAND_1 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_1)] :
    tileType == TILE_FLOOR_SAND_2 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_2)] :
    tileType == TILE_FLOOR_SAND_3 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_3)] :
    tileType == TILE_FLOOR_SAND_4 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_4)] :
    tileType == TILE_FLOOR_SAND_5 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_5)] :
    tileType == TILE_FLOOR_SAND_6 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_6)] :
    tileType == TILE_FLOOR_SAND_7 ? [sprites objectForKey:KEY_FOR_TILETYPE(TILE_FLOOR_SAND_7)] :
    
    
    tileType == TILE_FLOOR_ACID           ? [sprites objectForKey:@"AcidTile"]      :
    tileType == TILE_FLOOR_LAVA           ? [sprites objectForKey:@"LavaTile"]      :
 
    tileType == TILE_FLOOR_VOID           ? [sprites objectForKey:@"VoidTile"]       :
    tileType == TILE_FLOOR_UPSTAIRS       ? [sprites objectForKey:@"UpstairsTile"]   :
    tileType == TILE_FLOOR_DOWNSTAIRS     ? [sprites objectForKey:@"DownstairsTile"] :
    
    tileType == TILE_FLOOR_WATER_0          ? [sprites objectForKey:@"WaterTile0"]      :
                                             nil;
 */
    
    // hidden traps
    //if ( tileType == TILE_FLOOR_STONE_TRAP_SPIKES_D6 && data.trapIsSet ) {
    //    tileTexture = [sprites objectForKey:@"StoneTile"];
    //} else if ( tileType == TILE_FLOOR_STONE_TRAP_SPIKES_D6 && ! data.trapIsSet ) {
    //    tileTexture = [sprites objectForKey:@"StoneTileTrap"];
   // }
    
    //if ( tileType == TILE_FLOOR_STONE_TRAP_POISON_D6 && data.trapIsSet ) {
    //    tileTexture = [sprites objectForKey:@"StoneTile"];
    //} else if ( tileType == TILE_FLOOR_STONE_TRAP_POISON_D6 && ! data.trapIsSet ) {
    //    tileTexture = [sprites objectForKey:@"StoneTileTrap"];
    //}
    
    
    // in most cases, we will fill our texture
    CCMutableTexture2D *texture = ( CCMutableTexture2D * ) tileSprite.texture;
    for ( int i = 0; i < 16; i++ ) {
        for ( int j = 0; j < 16; j++ ) {
            //tileTexture != nil ? [texture setPixelAt:ccp(i,j) rgba:[tileTexture pixelAt:ccp(i,j)]] : 0;
            //[[Maybe something:tileTexture] hasSomething] ? [texture setPixelAt:ccp(i,j) rgba:[tileTexture pixelAt:ccp(i,j)]] : 0;
            tileTexture != nil ? [texture setPixelAt:ccp(i,j) rgba:[tileTexture pixelAt:ccp(i,j)]] : 0;
        }
    }
    [ texture apply ];
    
    CCMutableTexture2D *t = nil;
    
    for ( int i = 0; i < data.contents.count; i++ ) {
    
        // Below, we define the draw routines for each entity-type
        // Last, we will upgrade to multi-layer drawings
        
        Entity *entity = [data.contents objectAtIndex:i];
        //MLOG(@"%@:%d", entity.name, entity.name.length);
        
        if ( entity.entityType == ENTITY_T_PC ) {
            t = [sprites objectForKey: @"Hero"];
        } else if ( [ [entity name] isEqualToString: @"Test1" ] ) {
            // Test1 will get rendered as colorFuzz
            [self renderTileColorFuzz:texture];
        } else if ( entity.entityType == ENTITY_T_NPC ) {
            
            if (entity.monsterType == MONSTER_T_GHOUL) {
                t = [sprites objectForKey: @"Ghoul"];
            
                if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@""] ||
                 [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Weak"]
                ) {
                    t = [sprites objectForKey: @"Ghoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Fire"] ) {
                    t = [sprites objectForKey: @"FireGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Ice"] ) {
                    t = [sprites objectForKey: @"IceGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Water"] ) {
                    t = [sprites objectForKey: @"WaterGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Earth"] ) {
                    t = [sprites objectForKey: @"EarthGhoul"];
                } else if ( [((Prefix_t *)[entity.prefixes objectAtIndex:0]).name isEqualToString:@"Lightning"] ) {
                    t = [sprites objectForKey: @"LightningGhoul"];
                }
            } else if ( entity.monsterType == MONSTER_T_CAT ) {
                t = [sprites objectForKey:@"Cat"];
            } else if ( entity.monsterType == MONSTER_T_TOTORO ) {
                t = [sprites objectForKey:@"Totoro"];
            } else if ( entity.monsterType == MONSTER_T_TREE ) {
                t = [sprites objectForKey:@"Tree"];
            }
            
            for ( int i = 0; i < 16; i++ )
                for ( int j = 0; j < 16; j++ )
                    if ( [t pixelAt:ccp(i,j)].a != 0 )
                        [texture setPixelAt:ccp(i,j) rgba:[t pixelAt:ccp(i,j)]];
            [texture apply];
            
        } else if ( entity.entityType == ENTITY_T_ITEM ) {
            
            if ( entity.itemType == E_ITEM_T_WEAPON ) {
                
              //  MLOG(@"");
                
                
                
                
                if ( entity.name.length >= @"Fir Short Sword".length &&
                    [[entity.name substringToIndex:@"Fir Short Sword".length ] isEqualToString: @"Fir Short Sword"] )
                    t = [sprites objectForKey:@"FirShortSword"];
                
                else if ( entity.name.length >= @"Iron Short Sword".length &&
                    [[entity.name substringToIndex:@"Iron Short Sword".length ] isEqualToString: @"Iron Short Sword"] )
                    t = [sprites objectForKey:@"IronShortSword"];
                
                else if ( entity.name.length >= @"Steel Short Sword".length &&
                    [[entity.name substringToIndex:@"Steel Short Sword".length ] isEqualToString: @"Steel Short Sword"] )
                    t = [sprites objectForKey:@"SteelShortSword"];
                
                
                else if ( entity.name.length >= @"Asura".length &&
                         [[entity.name substringToIndex:@"Asura".length ] isEqualToString: @"Asura"] ) {
                    t = [sprites objectForKey:@"AsuraSword"];
                    
                }
                
                else if ( entity.name.length >= @"Rock Short Sword".length &&
                         [[entity.name substringToIndex:@"Rock Short Sword".length ] isEqualToString: @"Rock Short Sword"] ) {
                    t = [sprites objectForKey:@"RockShortSword"];
                }
                
                else {
                    [GameRenderer renderTileColorFuzz: texture];
                }
//                MLOG(@"");
                
            } else if ( entity.itemType == E_ITEM_T_ARMOR ) {
                
                if ( entity.armorType == ARMOR_T_SHIELD ) {
                    t = [sprites objectForKey:@"SmallShield"];
                }
                else if ( entity.armorType == ARMOR_T_VEST ) {
                    t = [sprites objectForKey:@"LeatherArmor"];
                }
                else if ( entity.armorType == ARMOR_T_ROBE ) {
                    t = [sprites objectForKey:@"ClothRobe"];
                }
                
                
                
                else if ( entity.armorType == ARMOR_T_HELMET ) {
                    
                    if ( [entity.name isEqualToString:@"Blindfold" ] ) {
                        t = [sprites objectForKey:@"Blindfold"];
                    }
                }
                else if ( entity.armorType == ARMOR_T_SHOE ) {
                    if ( [entity.name isEqualToString:@"Boots of Anti-acid"]) {
                        t = [sprites objectForKey:@"BootsOfAntiacid"];
                    }
                }
                
            
            }
            
            // only one book so far...
            else if ( entity.itemType == E_ITEM_T_BOOK ) {
                t = [sprites objectForKey:@"BookOfAllKnowing"];
            }
            
            // potions
            else if ( entity.itemType == E_ITEM_T_POTION ) {
                if ( entity.potionType == POTION_T_HEALING )
                    t = [sprites objectForKey:@"PotionOfLightHealing"];
                else if ( entity.potionType == POTION_T_POISON_ANTIDOTE )
                    t = [sprites objectForKey:@"PotionOfAntidote"];
            }
            
            
            // food
            else if ( entity.itemType == E_ITEM_T_FOOD ) {
                t = [sprites objectForKey:@"SmallBlob"];
            }
            
            // fish
            else if ( entity.itemType == E_ITEM_T_FISH ) {
                if ( [entity.name isEqualToString:@"Catfish"] ) {
                    t = [sprites objectForKey:@"Catfish"];
                }
            }
            
            else if ( entity.itemType == E_ITEM_T_FISHING_ROD ) {
                if ( [entity.name isEqualToString:@"Wooden Fishing Rod"] ) {
                    t = [sprites objectForKey:@"WoodenFishingRod"];
                }
            }
            
            else if ( entity.itemType == E_ITEM_T_BASICBOULDER ) {
                t = [sprites objectForKey:@"BasicBoulder"];
            }
            
            else if ( entity.itemType == E_ITEM_T_DOOR_SIMPLE ) {
                t = (! entity.doorOpen) ? [sprites objectForKey:@"SimpleDoorClosed"] : [sprites objectForKey:@"SimpleDoorOpen"];
            }
            
            else if ( entity.itemType == E_ITEM_T_KEY_SIMPLE ) {
                t = [sprites objectForKey:@"SimpleKey"];
            }
            
            else if ( entity.itemType == E_ITEM_T_SCROLL ) {
                t = [sprites objectForKey:@"MagicScroll"];
            }
            
            else if ( entity.itemType == E_ITEM_T_WAND ) {
                t = [sprites objectForKey:@"MagicWand"];
            }
            
            else if ( entity.itemType == E_ITEM_T_RING ) {
                t = [sprites objectForKey:@"MagicRing"];
            }
            
            else if ( entity.itemType == E_ITEM_T_COIN ) {
                t = [sprites objectForKey:@"Coin"];
            }
            
            else if ( entity.itemType == E_ITEM_T_NOTE ) {
                t = [sprites objectForKey:@"Note"];
            }
            
            else if ( entity.itemType == E_ITEM_T_TORCH ) {
                t = [sprites objectForKey:@"Torch"];
            }
            
            
            
            
            
            
            
            /*
            else if ( entity.itemType == E_ITEM_T_ ) {
                t = [sprites objectForKey:@"Coin"];
            }
            */
            
        }
        
        // at this point, t is set to something from data.contents
        // typically, we'd enumerate and the last thing in data.contents is what gets drawn on top
        // since we're going numerically now, it should still be the same thing
 
        // copy the texture over
        
        //if ( [[Maybe something:t] hasSomething] )
        //if ( t != nil )
        
        [GameRenderer copyTexture:t ontoTexture:texture];
        
    }
 
    /*
    if ( t != nil ) {
        for ( int i = 0; i < 16; i++ )
            for ( int j = 0; j < 16; j++ )
                ( [t pixelAt:ccp(i,j)].a != 0 ) ? [texture setPixelAt:ccp(i,j) rgba:[t pixelAt:ccp(i,j)]] : 0;
        [texture apply];
    }
     */
    
    //[GameRenderer copyTexture:t ontoTexture:texture];
    
    // handle selected tiles
    //if ( data.isSelected && tileTexture != nil ) {
    //if ( data.isSelected && [[Maybe something:tileTexture] hasSomething] ) {
    
    [GameRenderer setLightTileForTexture:texture withData:data withFloor:floor];
    
    if ( data.isSelected && tileTexture != nil ) {
        
        [ GameRenderer setTileIsSelected: texture];
        
        /*
        for ( int i = 0; i < texture.contentSizeInPixels.width; i++ ) {
            for ( int j = 0; j < texture.contentSizeInPixels.height; j++ ) {
                Color_t px = [texture pixelAt:ccp(i,j)];
                px.a = 128;
                [texture setPixelAt:ccp(i,j) rgba:px];
            }
        }
         */
        
    }
    [texture apply];
}



+(void) setTileIsSelected: (CCMutableTexture2D *) texture {
    for ( int i = 0; i < texture.contentSizeInPixels.width; i++ ) {
        for ( int j = 0; j < texture.contentSizeInPixels.height; j++ ) {
            Color_t px = [texture pixelAt:ccp(i,j)];
            px.a = px.a > 0 ? 255 : 0;
            [texture setPixelAt:ccp(i,j) rgba:px];
        }
    }
}



+(void) copyTexture: (CCMutableTexture2D *) texture0 ontoTexture: (CCMutableTexture2D *) texture1 {
    if ( [[Maybe something: texture0] hasSomething] &&
        [[Maybe something: texture1] hasSomething]) {
    
    /*
    if ( texture0 != nil &&
         texture1 != nil ) {
      */
            
        // assert that texture0 and texture1 have the same width and height in pixels
        NSAssert( texture0.contentSizeInPixels.width  == texture1.contentSizeInPixels.width,  @"Content size in pixels must match!");
        NSAssert( texture0.contentSizeInPixels.height == texture1.contentSizeInPixels.height, @"Content size in pixels must match!");
        for ( int i = 0; i < texture0.contentSizeInPixels.width; i++ ) {
            for ( int j = 0; j < texture0.contentSizeInPixels.height; j++ ) {
                // test the pixel alpha at (i,j) on texture0
                // if it isn't 0, copy it over. otherwise, do nothing
                [texture0 pixelAt:ccp(i,j)].a != 0 ? [texture1 setPixelAt:ccp(i,j) rgba:[texture0 pixelAt:ccp(i,j)]] : 0;
            }
        }
        [texture1 apply];
    }
}





/*
 ====================
 setAllTiles: withData
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray withData: ( NSArray * ) data {
    for ( int i = 0; i < [tileArray count]; i++ ) {
        CCSprite *sprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer setTile: sprite withData: [ data objectAtIndex: i ] ];
    }
}


+( void ) setTile: (CCSprite *) sprite toAlpha: (GLubyte) alpha {
    CCMutableTexture2D *texture = (CCMutableTexture2D *) sprite.texture;
    for (int _i=0; _i<texture.contentSizeInPixels.width; _i++) {
        for (int _j=0; _j<texture.contentSizeInPixels.height; _j++) {
            
            Color_t pixelColor = [texture pixelAt:ccp(_i,_j)];
            pixelColor.a = alpha;
            [texture setPixelAt:ccp(_i,_j) rgba:pixelColor];
            
        }
    }
    [texture apply];
}


+( void ) setLightTile:(CCSprite *) sprite withData:(Tile *) tile withFloor: (DungeonFloor *) floor {
    // calculate alpha value (light)
    //CCMutableTexture2D *texture;
    //Color_t pixelColor;
    
    // grab the pc
    Entity *pc;
    for (Entity *e in floor.entityArray) {
        if ( e.isPC ) {
            pc = e;
            break;
        }
    }
    
    int distance = [GameTools distanceFromCGPoint:pc.positionOnMap toCGPoint:tile.position];
    int factor = 64;
    
    // crude light calculation - 4 distances away from PC, nothing else (yet)
    GLubyte newAlpha =
        distance == 0 ? 255 :
        distance == 1 ||
        distance == 2 ||
        distance == 3 ? 255 - factor * distance : 0;
    
    [ GameRenderer setTile: sprite toAlpha: newAlpha ];
}


+( void) setLightTileForTexture: (CCMutableTexture2D *) texture withData:(Tile *) tile withFloor: (DungeonFloor *) floor {
    // calculate alpha value (light)
    
    // grab the pc
    Entity *pc;
    for (Entity *e in floor.entityArray) {
        if ( e.isPC ) {
            pc = e;
            break;
        }
    }
    
    int distance, factor, lightValue, lightBase;
    //itemsInInventory;
    GLubyte newAlpha;
    
    distance = [GameTools distanceFromCGPoint:pc.positionOnMap toCGPoint:tile.position];
    
    // crude light calculation
    lightBase = 2;
    //int itemsInInventory = pc.inventoryArray.count;
    int itemsInInventory = 0;
    
    for ( Entity *item in pc.inventoryArray ) {
        if ( [item.name isEqualToString:@"Torch"] )
            itemsInInventory += item.lightLevel;
    }
    
    
    lightValue = lightBase + itemsInInventory;
    //lightValue = lightBase;
    //lightValue = lightBase + gameLayer.karma;
    
    // check to see if pc is equipped with the blindfold
    Entity *maybeBlindfold = [pc.equipment objectAtIndex: EQUIPSLOT_T_HEAD];
    if ( [maybeBlindfold isKindOfClass:NSClassFromString(@"Entity")] && [maybeBlindfold.name isEqualToString:@"Blindfold"] ) {
        lightValue = lightBase;
    }
    
    /*
     other ways to think of light:
     
     1. torches, lanterns, candles, etc
     2. karma-tiers
     3. light-based magic items (rings, swords, armor, etc)
     4. light-spell
     */
    
    factor = 256 / lightValue;
    
    newAlpha =  distance == 0 ? 255 :
    distance < lightValue ? 255 - factor * distance : 0;
    
    [ GameRenderer setTileForTexture:texture toAlpha:newAlpha ];
}




+( void ) setTileForTexture: (CCMutableTexture2D *) texture toAlpha: (GLubyte) alpha {
    for (int _i=0; _i<texture.contentSizeInPixels.width; _i++) {
        for (int _j=0; _j<texture.contentSizeInPixels.height; _j++) {
            Color_t pixelColor = [texture pixelAt:ccp(_i,_j)];
            pixelColor.a = alpha;
            [texture setPixelAt:ccp(_i,_j) rgba:pixelColor];
        }
    }
    [texture apply];
}





/*
 ====================
 setAllVisibleTiles: tileArray withDungeonFloor: floor withCamera: camera
 ====================
 */
+( void ) setAllVisibleTiles: ( NSArray * ) tileArray withDungeonFloor: ( DungeonFloor * ) floor withCamera: ( CGPoint ) camera withSprites:(NSDictionary *)sprites {
    CGPoint c = camera;
    for ( int j = 0; j < NUMBER_OF_TILES_ONSCREEN_Y; j++ ) {
        for ( int i = 0; i < NUMBER_OF_TILES_ONSCREEN_X; i++ ) {
            CCSprite *sprite = [ tileArray objectAtIndex: i+j*NUMBER_OF_TILES_ONSCREEN_X ];
            Tile *tile = [ [floor tileDataArray] objectAtIndex: (i+c.x)+((j+c.y)*[floor width]) ];
            
            [ GameRenderer setTile: sprite withData: tile withSprites: sprites withFloor: floor ];
            
            //[ GameRenderer setLightTile: sprite withData: tile withFloor: floor ];
        }
    }
}

/*
 ====================
 setAllTiles: withEntityData
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray withEntityData: ( NSArray * ) data {
    for ( int i = 0; i < [tileArray count]; i++ ) {
        CCSprite *sprite = [ tileArray objectAtIndex: i ];
        [ GameRenderer setTile: sprite withData: [ data objectAtIndex: i ] ];
    }
}

/*
 ====================
 setTileArrayBoundary: floor toTileType: tileType withLevel: level
 ====================
 */
+( void ) setTileArrayBoundary: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType withLevel: ( NSInteger ) level {
    Tile *tile = nil;
    for ( int j = level-1; j < [floor height ]-(level-1); j++ ) {
        for ( int i = level-1; i < [floor width ]-(level-1); i++ ) {
            if ( (i == level-1 || i == [floor width]-level) ) {
                tile = [ [floor tileDataArray ] objectAtIndex: i + (j * [floor width]) ];
                tile.tileType = tileType;
            }
            if ( j == level-1 || j == [floor height ]-level ) {
                tile = [ [floor tileDataArray ] objectAtIndex: i + (j * [floor width ]) ];
                tile.tileType = tileType;
            }
        }
    }
}

/*
 ====================
 setDefaultTileArrayBoundary
 ====================
 */
+(void) setDefaultTileArrayBoundary: (DungeonFloor *) floor {
    [ GameRenderer setAllTilesInFloor: floor toTileType: TILE_FLOOR_VOID ];
}

/*
 ====================
 setTileAtPosition: position onFloor: floor toType: tileType
 ====================
 */
+(void) setTileAtPosition: (CGPoint) position onFloor: (DungeonFloor *) floor toType: (Tile_t) tileType {
    Tile *t = ((Tile *)[floor.tileDataArray objectAtIndex: position.x + ( position.y * floor.width) ]);
    [t setTileType: tileType ];
    [t handleTileType: tileType];
}



/*
 ====================
 setTile: tile toType: tileType
 ====================
 */
+(void) setTile: (Tile *) tile toType: (Tile_t) tileType {
    tile.tileType = tileType;
}

/*
 ====================
 setAllTiles: tileArray toTileType: tileType
 ====================
 */
+( void ) setAllTiles: ( NSArray * ) tileArray toTileType: ( Tile_t ) tileType {
    for ( Tile * tile in tileArray ) {
        tile.tileType = tileType;
    }
}

/*
 ====================
 setAllTilesInDungeon: dungeon toTileType: tileType
 ====================
 */
+( void ) setAllTilesInFloor: ( DungeonFloor * ) floor toTileType: ( Tile_t ) tileType {
    [ GameRenderer setAllTiles: [floor tileDataArray] toTileType: tileType ];
}

/*
 ====================
 generateDungeonFloor: floor
 ====================
 */
+( void ) generateDungeonFloor: ( DungeonFloor * ) floor {
    [ GameRenderer generateDungeonFloor: floor withAlgorithm: DF_ALGORITHM_T_ALGORITHM0 ];
}

/*
 ====================
 generateDungeonFloor: floor withAlgorithm: algorithm
 ====================
*/
+( void ) generateDungeonFloor:(DungeonFloor *)floor withAlgorithm: ( DungeonFloorAlgorithm_t ) algorithm {
    [ self setAllTilesInFloor: floor toTileType:TILE_FLOOR_VOID ];
    if ( algorithm == DF_ALGORITHM_T_LARGEROOM ) {
        [self largeRoomAlgorithm:floor];
    } else if ( algorithm == DF_ALGORITHM_T_ALGORITHM0 ||
              algorithm == DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR
             ) {
        [ self algorithm0:algorithm withFloor:floor ];
    }
}

+(void) largeRoomAlgorithm: (DungeonFloor *) floor {
    [ self setAllTilesInFloor:floor toTileType:TILE_FLOOR_STONE_0 ];
}

+(void) algorithm0: (DungeonFloorAlgorithm_t) algorithm withFloor: (DungeonFloor *) floor {
    // calc the top-left editable tile
    NSUInteger x = floor.border/2;
    NSUInteger y = floor.border/2;
    NSUInteger w = floor.width - floor.border;
    NSUInteger h = floor.height - floor.border;
    
    NSUInteger numTilesPlaced = 0;
    NSUInteger maxTilesPlaced = 0;
    NSUInteger numTiles = [Dice roll:10 nTimes:10] + 10;

    NSUInteger xo = 0;
    NSUInteger yo = 0;
    
    NSUInteger roll;
    NSUInteger totalRolls = 0;
    
    NSUInteger rerolls = 0;
    NSUInteger totalRerolls = 0;
    NSUInteger rerollTolerance = 100;
    NSUInteger toleranceBreaks = 0;
    
    const NSUInteger MAX_REROLLS = 4;
    NSUInteger prevroll[ MAX_REROLLS ];
    for ( int i = 0; i < MAX_REROLLS; i++ ) { prevroll[ i ] = -1; }
    
    NSMutableArray *placedTilesArray = [[ NSMutableArray alloc ] init ];
    NSMutableArray *triedTilesArray = [[ NSMutableArray alloc ] init ];
    
    BOOL doPrintMaxTiles = NO;
    
    
    
    // determine a tile-type as the base tile type to use
    roll = [Dice roll:10];
    Tile_t baseTileType =
    roll == 1 ? TILE_FLOOR_STONE_0 :
    roll == 2 ? TILE_FLOOR_GRASS_0 :
    roll == 3 ? TILE_FLOOR_DIRT_0  :
    roll == 4 ? TILE_FLOOR_METAL_0  :
    roll == 5 ? TILE_FLOOR_SAND_0 :
    roll == 6 ? TILE_FLOOR_SNOW_0 :
    roll == 7 ? TILE_FLOOR_SWAMP_0 :
    roll == 8 ? TILE_FLOOR_WATER_0 :
    roll == 9 ? TILE_FLOOR_QUANTUMFOAM_0 :
    roll == 10 ? TILE_FLOOR_SPACE_0  :
    TILE_FLOOR_STONE_0;
    
    
    CGPoint point = ccp( x, y );
    [ self setTileAtPosition:point onFloor:floor toType:baseTileType ];
    [ placedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
    numTilesPlaced++;
    
    for ( int i = numTilesPlaced; i < numTiles; i++ ) {
        BOOL willReroll = NO;
        
        // handle the roll
        // direction type
        // 0 = standard : ULDR
        // 1 = cross    : UL UR DL DR
        // 2 = mix      : 0 + 1
        NSInteger dirType = 1;
        //NSInteger dirType = [Dice roll:3];
        if ( dirType == 1 ) {
            roll = [Dice roll:4];
            xo +=
            roll == 1 || roll == 2  ?  0  :
            roll == 3               ? -1  :
            roll == 4               ?  1  :
            0;
            
            yo +=
            roll == 1              ? -1  :
            roll == 2              ?  1  :
            roll == 3 || roll == 4 ?  0  :
            0;
            
        } else if ( dirType == 2 ) {
            roll = [Dice roll:4];
            xo +=
            roll == 1 || roll == 3 ? -1  :
            roll == 2 || roll == 4 ?  1  :
            0;
            
            yo +=
            roll == 1 || roll == 2 ? -1  :
            roll == 3 || roll == 4 ?  1  :
            0;
            
        } else if ( dirType == 3 ) {
            roll = [Dice roll:8];
            xo +=
            roll == 1 || roll == 2              ?  0  :
            roll == 3 || roll == 5 || roll == 7 ? -1  :
            roll == 4 || roll == 6 || roll == 8 ?  1  :
            0;
            
            yo +=
            roll == 1 || roll == 5 || roll == 6 ? -1  :
            roll == 2 || roll == 7 || roll == 8 ?  1  :
            roll == 3 || roll == 4              ?  0  :
            0;
        }
        totalRolls++;
        
        CGPoint point = ccp( x+xo, y+yo );
        // roll-checking
        // check if this value exists in our placedTilesArray
        NSValue *v = [ NSValue valueWithCGPoint: point ];
        
        for ( NSValue *p in triedTilesArray ) {
            if ( [p isEqualToValue: v ] ) {
                willReroll = YES;
                break;
            }
        }
        
        if ( !willReroll ) {
            for ( NSValue *p in placedTilesArray ) {
                if ( [p isEqualToValue:v ] ) {
                    willReroll = YES;
                    break;
                }
            }
        }
        
        // check to see if we are going out-of-bounds
        if ( !willReroll ) {
            willReroll = willReroll || (x+xo < x || y+yo < y) || (x+xo >= w+x || y+yo >= h+y );
        }
        
        if ( ! willReroll ) {
            
            
            
            // Programmatically set the tile type
            Tile_t tileType = baseTileType;
            int tileTypeOffset, tileTypeOffsetBase;
            tileTypeOffsetBase = 1;
           
            
/*
 Here, we have the list of tileOffsets when generating floors
 Basically, we can hard-code in the offset 
 This is useful for debugging and expanding the tiles used
 */
            
#define TILEOFFSET_STONE       [Dice roll:23]
#define TILEOFFSET_GRASS       23
#define TILEOFFSET_DIRT        23
#define TILEOFFSET_WATER        1
#define TILEOFFSET_SAND        15
#define TILEOFFSET_METAL       29
#define TILEOFFSET_SNOW        23
#define TILEOFFSET_SWAMP       23
#define TILEOFFSET_QUANTUMFOAM  0
#define TILEOFFSET_SPACE        4

            //baseTileType = TILE_FLOOR_STONE_0;
            //baseTileType = TILE_FLOOR_GRASS_0;
            //baseTileType = TILE_FLOOR_METAL_0;
            //baseTileType = TILE_FLOOR_SWAMP_0;
            //baseTileType = TILE_FLOOR_DIRT_0;
            //baseTileType = TILE_FLOOR_SNOW_0;
            //baseTileType = TILE_FLOOR_QUANTUMFOAM_0;
            //baseTileType = TILE_FLOOR_SPACE_0;
            
            switch (baseTileType) {
                case TILE_FLOOR_METAL_0:
                    baseTileType = baseTileType + ([Dice roll: 29]-1) ;
                    tileTypeOffsetBase = floor.floorNumber;
                    break;
                    
                case TILE_FLOOR_STONE_0:
                    baseTileType = baseTileType + ([Dice roll: 23]-1) ;
                    tileTypeOffsetBase = floor.floorNumber;
                    break;
                    
                    
                    
                default:
                    tileTypeOffsetBase =
                    //baseTileType == TILE_FLOOR_STONE_0 ? TILEOFFSET_STONE  :
                    baseTileType == TILE_FLOOR_GRASS_0 ? TILEOFFSET_GRASS  :
                    baseTileType == TILE_FLOOR_DIRT_0  ?  TILEOFFSET_DIRT  :
                    baseTileType == TILE_FLOOR_WATER_0 ?  TILEOFFSET_WATER :
                    baseTileType == TILE_FLOOR_SAND_0  ?  TILEOFFSET_SAND  :
                    //baseTileType == TILE_FLOOR_METAL_0 ?  TILEOFFSET_METAL :
                    baseTileType == TILE_FLOOR_SNOW_0  ?  TILEOFFSET_SNOW  :
                    baseTileType == TILE_FLOOR_SWAMP_0 ?  TILEOFFSET_SWAMP :
                    baseTileType == TILE_FLOOR_QUANTUMFOAM_0 ? TILEOFFSET_QUANTUMFOAM :
                    baseTileType == TILE_FLOOR_SPACE_0 ?  TILEOFFSET_SPACE :
                    0;
                    break;
            }
            
            
            tileTypeOffset = [Dice roll: tileTypeOffsetBase]-1;
            tileType = baseTileType + tileTypeOffset;
            
            // setTileAtPosition will call handleTile and set if trapped
            [ self setTileAtPosition:point onFloor:floor toType:tileType ];
            
            
            Tile *_t = ((Tile *)[floor.tileDataArray objectAtIndex: point.x + ( point.y * floor.width) ]);
            // roll savagery
            _t.savagery = [Dice roll: 101] - 1;
            
            [ placedTilesArray addObject: v ];
            [ triedTilesArray removeAllObjects ];
            numTilesPlaced++;
            if ( maxTilesPlaced > numTilesPlaced ) {
                maxTilesPlaced = maxTilesPlaced;
            }
            else {
                maxTilesPlaced = numTilesPlaced;
                doPrintMaxTiles = YES;
            }
        } else if ( willReroll ) {
            [ triedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
            
            // undo the roll
            roll == 1 ? yo++ :
            roll == 2 ? yo-- :
            roll == 3 ? xo++ :
            roll == 4 ? xo-- : 0;
            
            rerolls++;
            totalRerolls++;
            i--;
            
            // check reroll tolerance
            if ( totalRerolls >= rerollTolerance ) {
                xo = 0;
                yo = 0;
                
                [ placedTilesArray removeAllObjects ];
                [ triedTilesArray removeAllObjects ];
                
                numTilesPlaced = 0;
                
                CGPoint point = ccp( x, y );
                [ self setTileAtPosition:point onFloor:floor toType:baseTileType ];
                [ placedTilesArray addObject: [NSValue valueWithCGPoint:point] ];
                numTilesPlaced++;
                
                i = numTilesPlaced;
                
                totalRerolls = 0;
                toleranceBreaks++;
            }
        }
    }

    // place the upstairs/downstairs tiles
    BOOL isUpstairsPlaced = NO;

    /*
     Upstairs algorithm:
        for each tile on this floor,
          roll 1d100. 
          if roll <= 5
            place upstairs
     */
    while ( !isUpstairsPlaced ) {
        for ( NSValue *p in placedTilesArray ) {
            roll = [Dice roll:100];
            NSUInteger percentage = 5;
            if ( roll <= percentage ) {
                [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_UPSTAIRS ];
                isUpstairsPlaced = YES;
                break;
            }
        }
    }
    
    

    /*
     with the upstairs-tile places, it is time to place the downstairs.
     we grab the upstairsPoint for comparison. make sure that:
        -The upstairsPoint is NOT equal to the downstairsPoint
        -The upstairsPoint is a total [M,N] distance away from the downstairsPoint
     
     The old algorithm:
        for each tile on this floor,
          roll 1d100. 
          if roll <= 5
            check tile validity
            if valid
              place tile
     
     The new algorithm:
       for each tile on this floor,
         check candidacy for downstairsTile
         if candidate,
           add to candidate array
       roll 1dN where N=candidateArray.count
       use the tile at location roll-1 in the candidateArray
     */


   // CGPoint upstairsPoint = [ self getUpstairsTileForFloor: floor ];
 
    // compute the downstairs probability-space and select a tile
    /*
    NSMutableArray *candidateArray = [NSMutableArray array];
    NSInteger distanceMin = 5;
    NSInteger distanceMax = 20;
    */
    
    // only add downstairs-tile if this isn't the final floor
    if ( algorithm != DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR ) {
        
        // define the "buildCandidateArray" function block
        
        
        /*
        void (^buildCandidateArray)(int,int) = ^(int _min,int _max) {
            // start with a full array - everything is candidate
            for ( Tile *object in floor.tileDataArray ) {
                [candidateArray addObject: object];
            }
            
            // now, remove items based on the checks
            for (int i=0; i < candidateArray.count; i++) {
                Tile *possibleCandidateTile     = [candidateArray objectAtIndex:i];
                CGPoint thePoint                = [possibleCandidateTile position];
                Tile *theTile                   = [self getTileForFloor:floor forCGPoint:thePoint];
                    
                BOOL check0 = ( !CGPointEqualToPoint(upstairsPoint, thePoint ) );
                BOOL check1 = [ GameTools distanceFromCGPoint:upstairsPoint toCGPoint:thePoint ] >= _min;
                BOOL check2 = [ GameTools distanceFromCGPoint:upstairsPoint toCGPoint:thePoint ] <  _max;
                BOOL check3 = theTile.tileType != TILE_FLOOR_VOID;
                
                if ( !(check0 && check1 && check2 && check3) ) {
                    [candidateArray removeObjectAtIndex: i];
                    i = 0;
                }
            }
        };
        
        // bootstrap the candidate array
        [ candidateArray removeAllObjects ];
        buildCandidateArray( distanceMin, distanceMax );
        MLOG(@"Candidates this pass [%d,%d]: %d", distanceMin, distanceMax, candidateArray.count);
        
        // rebuild candidateArray with new minimum and maximum
        //distanceMin = distanceMax / 2;
        
        NSInteger roll = [Dice roll: candidateArray.count];
        CGPoint downstairsPoint = ((Tile *)[candidateArray objectAtIndex:roll-1]).position;
        [ self setTileAtPosition:ccp(downstairsPoint.x, downstairsPoint.y) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS ];
        
         */
        
        BOOL isDownstairsPlaced = NO;
        CGPoint upstairsPoint = [ self getUpstairsTileForFloor: floor ];
        int _min = 5;
        int _max = 20;
        
        while ( ! isDownstairsPlaced ) {
            for ( NSValue *p in placedTilesArray ) {
                //
                Tile *theTile = [ self getTileForFloor:floor forCGPoint:p.CGPointValue ];
                
                BOOL check0 = ( !CGPointEqualToPoint(upstairsPoint, p.CGPointValue ) );
                BOOL check1 = [ GameTools distanceFromCGPoint:upstairsPoint toCGPoint:p.CGPointValue ] >= _min;
                BOOL check2 = [ GameTools distanceFromCGPoint:upstairsPoint toCGPoint:p.CGPointValue ] <  _max;
                BOOL check3 = theTile.tileType != TILE_FLOOR_VOID;
                
                if ( check0 && check1 && check2 && check3 ) {
                    
                    // theTile is a candidate, roll for placement
                    roll = [Dice roll:100];
                    NSUInteger percentage = 5;
                    if ( roll <= percentage ) {
                        [ self setTileAtPosition:ccp(p.CGPointValue.x, p.CGPointValue.y) onFloor:floor toType:TILE_FLOOR_DOWNSTAIRS];
                        isDownstairsPlaced = YES;
                        break;
                    }
                    
                }
            }
        }
        
    }
    
}

/*
 ====================
 getUpstairsTileForFloor: floor
 ====================
 */
+( CGPoint ) getUpstairsTileForFloor: ( DungeonFloor * ) floor {
    CGPoint p = { -1, -1 };
    for ( Tile *t in [floor tileDataArray] ) {
        if ( t.tileType == TILE_FLOOR_UPSTAIRS ) {
            p = t.position;
            break;
        }
    }
    return p;
}

/*
 ====================
 getDownstairsTileForFloor: floor
 ====================
 */
+( CGPoint ) getDownstairsTileForFloor: ( DungeonFloor * ) floor {
    CGPoint p = { -1, -1 };
    for ( Tile *t in [floor tileDataArray] ) {
        if ( t.tileType == TILE_FLOOR_DOWNSTAIRS ) {
            p = t.position;
            break;
        }
    }
    return p;
}

/*
 ====================
 getTileForFloor: floor forCGPoint: p
 returns a tile on the given floor for a given p. returns nil
 ====================
 */
+( Tile * ) getTileForFloor: (DungeonFloor *) floor forCGPoint: (CGPoint) p {
    Tile *tile = nil;
    CGFloat calcedArrayIndex = p.x + ( p.y * floor.width );
    if ( calcedArrayIndex >= 0 && calcedArrayIndex < floor.tileDataArray.count )
        tile = [ floor.tileDataArray objectAtIndex: calcedArrayIndex ];
    return tile;
}

/*
 ====================
 distanceFromTile: toTile:
 returns distance from a tile to another
 ====================
 */
+( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b {
    //MLOG( @"distanceFromTile: a toTile: b" );
    NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
    
    return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
}

#pragma mark - Entity-spawning code

/*
 ====================
 randomEntity
 ====================
 */
+( Entity * ) randomEntity {
    Entity *e = [[Entity alloc] init];
    
    [e.name setString:@"EntityName"];
    e.entityType = ENTITY_T_VOID;
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
     
    e.maxhp = [Dice roll:10];
    e.hp = e.maxhp;
    e.alignment = ENTITYALIGNMENT_T_CHAOTIC_EVIL;
    return e;
}


/*
 ====================
 randomItem
 ====================
 */
+( Entity * ) randomItem {
    Entity *e = [[Entity alloc] init];
    e.entityType = ENTITY_T_ITEM;
    e.isPC = NO;
    [e.name setString: [self generateNameForEntityType: e.entityType ] ];
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_NONE;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}

/*
 ====================
 randomMonster
 ====================
 */
+( Entity * ) randomMonster {
    //MLOG(@"randomMonster");
    Entity *e = [[Entity alloc] init];
    [e.name setString: [self generateNameForEntityType:e.entityType]];
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}

/*
 ====================
 randomMonsterForFloor: floor
 ====================
 */
+( Entity * ) randomMonsterForFloor: (DungeonFloor *) floor {
    // calc a level in range of floorNumber
    NSUInteger randomLevel = [Dice roll: floor.floorNumber];
    NSUInteger mod =
    floor.floorNumber <= 4  ?  0 :
    floor.floorNumber <= 8  ?  1 :
    floor.floorNumber <= 12 ?  2 :
    floor.floorNumber <= 16 ?  3 :
    floor.floorNumber <= 20 ?  4 :
    5;
 
    NSUInteger calculatedLevel = randomLevel + mod;
    NSInteger randomHitDie = [Dice roll:12] + mod;
    
    Entity *e = [[Entity alloc] initWithLevel: calculatedLevel withHitDie:randomHitDie ];
    e.entityType = ENTITY_T_NPC;
    e.isPC = NO;
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
    NSUInteger roll = [Dice roll:4];
    if ( roll == 1 ) {
        [randomString setString:@"Goblin"];
    } else if ( roll == 2 ) {
        [randomString setString:@"Dwarf"];
    } else if ( roll == 3 ) {
        [randomString setString:@"Kobold"];
    } else if ( roll == 4 ) {
        [randomString setString:@"Imp"];
    }
    
    [e.name setString: randomString ];
    e.pathFindingAlgorithm = ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM;
    e.itemPickupAlgorithm = ENTITYITEMPICKUPALGORITHM_T_NONE;
    return e;
}

/*
 ====================
 spawnEntityAtRandomLocation: entity onFloor: floor
 ====================
 */
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor {
    BOOL locationIsAcceptable = NO;
    Tile *spawnTile = nil;
    
    while ( ! locationIsAcceptable ) {
        NSUInteger diceroll = [Dice roll: [[floor tileDataArray] count]] - 1;
        
        Tile *tile = [[ floor tileDataArray ] objectAtIndex: diceroll ];
        if ( tile.tileType != TILE_FLOOR_VOID &&
            tile.tileType != TILE_FLOOR_UPSTAIRS &&
            tile.tileType != TILE_FLOOR_DOWNSTAIRS
            ) {
            
            BOOL tileIsFree = YES;
            
            // check if a pc/npc occupies the tile contents
            for ( Entity *e in tile.contents ) {
                if ( e.entityType == ENTITY_T_PC ||
                    e.entityType == ENTITY_T_NPC ) {
                    tileIsFree = NO;
                    break;
                }
            }
            
            if ( tileIsFree ) {
                spawnTile = tile;
                locationIsAcceptable = YES;
                break;
            }
        }
    }
    
    if ( spawnTile != nil ) {
        [ GameRenderer setEntity: entity onTile: spawnTile ];
        [[ floor entityArray ] addObject: entity];
    }
}




/*
 ====================
 spawnEntityAtRandomLocation: entity onFloor: floor onTileType: tileType
 ====================
 */
+( void ) spawnEntityAtRandomLocation: (Entity *) entity onFloor: (DungeonFloor *) floor onTileType: (Tile_t) tileType {
    BOOL locationIsAcceptable = NO;
    Tile *spawnTile = nil;
    
    while ( ! locationIsAcceptable ) {
        NSArray *tileDataArray = [floor tileDataArray];
        //NSUInteger diceroll = [Dice roll: [[floor tileDataArray] count]] - 1;
        NSUInteger diceroll = [Dice roll: [tileDataArray count]] - 1;
        
        //Tile *tile = [[ floor tileDataArray ] objectAtIndex: diceroll ];
        Tile *tile = [tileDataArray objectAtIndex: diceroll ];
        if ( tile.tileType != TILE_FLOOR_VOID &&
            tile.tileType != TILE_FLOOR_UPSTAIRS &&
            tile.tileType != TILE_FLOOR_DOWNSTAIRS
            ) {
            
            BOOL tileIsFree = YES;
            
            // check if a pc/npc occupies the tile contents
            for ( Entity *e in tile.contents ) {
                if ( e.entityType == ENTITY_T_PC ||
                    e.entityType == ENTITY_T_NPC ) {
                    tileIsFree = NO;
                    break;
                }
            }
            
            if ( tileIsFree && tile.tileType == tileType ) {
                spawnTile = tile;
                locationIsAcceptable = YES;
                break;
            }
        }
    }
    
    if ( spawnTile != nil ) {
        [ GameRenderer setEntity: entity onTile: spawnTile ];
        [[ floor entityArray ] addObject: entity];
    }
}








+( void ) spawnEntity: (Entity *) entity onFloor: (DungeonFloor *) floor atLocation: (CGPoint) location {
    Tile *tile = nil;
    for (Tile *t in [floor tileDataArray]) {
        if ( location.x == t.position.x && location.y == t.position.y ) {
            tile = t;
            break;
        }
    }
    BOOL g =    tile != nil &&
                tile.tileType != TILE_FLOOR_VOID &&
                tile.tileType != TILE_FLOOR_UPSTAIRS &&
                tile.tileType != TILE_FLOOR_DOWNSTAIRS;
    if ( ! g ) return;
    
    // check if a pc/npc occupies the tile contents
    BOOL tileIsFree = YES;
    for ( Entity *e in tile.contents ) {
        tileIsFree = ! ( e.entityType == ENTITY_T_PC || e.entityType == ENTITY_T_NPC );
        if ( ! tileIsFree ) break;
    }
    if ( tileIsFree ) {
        [GameRenderer setEntity:entity onTile:tile];
        [[floor entityArray] addObject: entity];
    }
}

/*
 ====================
 spawnRandomMonsterAtRandomLocationOnFloor: floor withPC: pc
 ====================
 */
+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc {
    [ self spawnRandomMonsterAtRandomLocationOnFloor:floor withPC:pc withChanceDie: 1 ];
}





+( void ) spawnMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor {
    BOOL locationIsAcceptable = NO;
    Tile *spawnTile = nil;
    
    // Spawn-call chance: 10%
    int roll = [Dice roll:10];
    
    if ( roll == 1 ) {

        NSArray *tileDataArray = [floor tileDataArray];
        
        
            int tolerance = 100;
        
            while ( ! locationIsAcceptable ) {
                NSUInteger diceroll = [Dice roll: [tileDataArray count]] - 1;
                BOOL tileIsFree = YES;
                
                Tile *tile = [tileDataArray objectAtIndex: diceroll ];
                //MLOG(@"tile.savagery = %d", tile.savagery);
                
    #define SAVAGERY_MIN 95
                if ( tile.savagery > SAVAGERY_MIN ) {
                    
                    // check if a pc/npc occupies the tile contents
                    for ( Entity *e in tile.contents ) {
                        if ( e.entityType == ENTITY_T_PC ||
                            e.entityType == ENTITY_T_NPC ) {
                            tileIsFree = NO;
                            tolerance--;
                            break;
                        }
                    }
                    
                    // doesn't matter what tile is. check savagery
                    if ( tileIsFree ) {
                        spawnTile = tile;
                        locationIsAcceptable = YES;
                        break;
                    }
                    
                    else {
                        if ( tolerance == 0 ) {
                            MLOG(@"Tolerance limit reached, returning...");
                            return;
                        }
                    }
                }
            }
            
            if ( spawnTile != nil ) {
                Entity *e;
                
                // set number of monsterTypes
                NSUInteger numMonsterTypes = 3; //4;
                NSUInteger m0 = [Dice roll: numMonsterTypes];
                
                // define monsters to spawn below
                e =
                ( m0 == 1 ) ? Cat :
                ( m0 == 2 ) ? Ghoul :
                ( m0 == 3 ) ? Totoro :
 //               ( m0 == 4 ) ? Tree :
                Cat;

                // level up monster appropriately
                NSInteger levelRoll = [Dice roll: floor.floorNumber + 1];
                for (int i=e.level; i<levelRoll; i++) [e handleLevelUp];
                
                [ GameRenderer setEntity: e onTile: spawnTile ];
                [[ floor entityArray ] addObject: e ];
                
                MLOG(@"placed monster: %@", e.name);
            }
    }
    //}
}





+( void ) spawnRandomMonsterAtRandomLocationOnFloor: (DungeonFloor *) floor withPC: (Entity *) pc withChanceDie: (NSInteger) chanceDie {
    NSUInteger spawnChancePercent = 1;
    NSUInteger diceroll = chanceDie == 1 ? 1 : [Dice roll:chanceDie];
    
    if ( diceroll <= spawnChancePercent ) {
        Entity *e;
        
        // set number of monsterTypes
        NSUInteger numMonsterTypes = 3;
        NSUInteger m0 = [Dice roll: numMonsterTypes];
        
        // define monsters to spawn below
        e =
        ( m0 == 1 ) ? Cat :
        ( m0 == 2 ) ? Ghoul :
        ( m0 == 3 ) ? Totoro :
        Cat;
        
        
        // level up monster appropriately
        NSInteger levelRoll = [Dice roll: floor.floorNumber + 1];
        for (int i=e.level; i<levelRoll; i++)
            [e handleLevelUp];
        
        
        // spawn monsters on grass tiles
        
        /*
         bug exists:
         
         ---will loop forever if tileType doesn't exist on floor
         
         solution:
         
         ---add 'savagery' field to tiles, spawn anywhere based on savagery
         */
        [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor onTileType:TILE_FLOOR_GRASS_0 ];
    }
}

/*
 ====================
 spawnRandomItemAtRandomLocationOnFloor: floor
 ====================
 */
+( void ) spawnRandomItemAtRandomLocationOnFloor: (DungeonFloor *) floor {
    Entity *e = [ Items randomItem ];
    [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];
}

/*
 ====================
 spawnBookOfAllKnowingAtRandomLocationOnFloor: floor
 ====================
 */
+( void ) spawnBookOfAllKnowingAtRandomLocationOnFloor: (DungeonFloor *) floor {
    Entity *e = [ Items bookOfAllKnowing ];
    [ GameRenderer spawnEntityAtRandomLocation:e onFloor:floor ];    
}

#pragma mark - Entity code

/*
 ====================
 setEntity: entity onTile: tile
 ====================
 */
+( void ) setEntity: ( Entity * ) entity onTile: ( Tile * ) tile {
    entity.positionOnMap = tile.position;
    [ tile addObjectToContents: entity ];
}

/*
 ====================
 generateName
 
 returns a name
 ====================
 */
+( NSString * ) generateNameForEntityType: (EntityTypes_t) type {
    
    NSMutableString *randomString = [ NSMutableString stringWithString:@"" ];
    
    if (type == ENTITY_T_NPC) {
        
        NSInteger nameLen = 8;
        NSString *alphanumeric = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for ( int i = 0; i < nameLen ; i++ ) {
            //[ randomString appendString: [alphanumeric substringWithRange:NSMakeRange(rollDiceOnce([alphanumeric length])-1, 1)] ];
            [ randomString appendString: [alphanumeric substringWithRange:NSMakeRange([Dice roll:[alphanumeric length]]-1, 1)] ];
        }
    }
    else if ( type == ENTITY_T_ITEM ) {
        [randomString setString:@"Book of All-Knowing" ];
    }
    
    return [ NSString stringWithString: randomString ];
}

@end