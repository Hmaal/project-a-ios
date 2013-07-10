//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"
#import "GameConfig.h"

@implementation Entity

@synthesize wasBumped;

@synthesize isPC;
@synthesize isAlive;
@synthesize positionOnMap;
@synthesize texture;

@synthesize name;
@synthesize level;
@synthesize threatLevel;
@synthesize strength;
@synthesize dexterity;
@synthesize constitution;
@synthesize intelligence;
@synthesize wisdom;
@synthesize charisma;

@synthesize fireDamage;
@synthesize iceDamage;
@synthesize waterDamage;
@synthesize earthDamage;
@synthesize lightningDamage;

@synthesize alignment;

@synthesize xp;
@synthesize totalxp;
@synthesize nextLevelXP;

@synthesize hitDie;
@synthesize hp;
@synthesize maxhp;
@synthesize ac;

@synthesize money;
@synthesize hunger;
@synthesize maxHunger;

@synthesize healingBonus;
@synthesize healingRollBase;

@synthesize foodBase;

@synthesize itemType;
@synthesize damageBonus;

@synthesize weight;
@synthesize durability;
@synthesize totalDurability;

@synthesize totalKills;

@synthesize inventoryArray;
@synthesize equippedArmsLeft;
@synthesize equippedArmsRight;
@synthesize equippedArmorChest;

@synthesize pathFindingAlgorithm;
@synthesize itemPickupAlgorithm;

@synthesize equipment;

@synthesize pathTaken;

@synthesize entityType;

@synthesize potionType;
@synthesize monsterType;
@synthesize armorType;
@synthesize ringType;

@synthesize prefixes;
@synthesize effects;

@synthesize doorOpen;
@synthesize doorLocked;

@synthesize status;
@synthesize spell;
@synthesize charges;
@synthesize maxCharges;

@synthesize notetext;
@synthesize wood;
@synthesize metal;

@synthesize damageRollBase;

@synthesize earthRes;
@synthesize fireRes;
@synthesize waterRes;
@synthesize iceRes;
@synthesize lightningRes;

//@synthesize monsterPrefixGroup;
//@synthesize itemPrefixGroup;

/*
 ====================
 init
 
 initializes and returns the object
 ====================
 */
-( id ) init {
    if ( ( self = [super init] ) ) {
        //MLOG(@"init");
        wasBumped       = NO;
        isPC            = NO;
        isAlive         = YES;
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture         = nil;
        
        doorOpen        = NO;
        doorLocked      = NO;
        
        name        = [ [ NSMutableString alloc ] init ];
        level       = 1;
        threatLevel = THREAT_T_NONE;
        
        entityType  = ENTITY_T_VOID;
        potionType  = POTION_T_NONE;
        monsterType = MONSTER_T_NONE;
        itemType    = E_ITEM_T_NONE;
        armorType   = ARMOR_T_NONE;
        
        prefixes    = [[NSMutableArray alloc] init];
        effects     = [[NSMutableArray alloc] init];
        
        NSInteger numEquipSlots = 19;
        equipment = [NSMutableArray array];
        
        // add the 19 entity pointers
        for (int i=0; i<numEquipSlots; i++)
            [equipment addObject: [NSNull null] ];
        
        totalKills  = 0;
        
        itemType            = E_ITEM_T_NONE;
        damageRollBase      = 4;
        damageBonus         = 0;
        weight              = 0;
        durability          = 0;
        totalDurability     = 0;
        
        strength        = [Dice roll:6 nTimes:3];
        dexterity       = [Dice roll:6 nTimes:3];
        constitution    = [Dice roll:6 nTimes:3];
        intelligence    = [Dice roll:6 nTimes:3];
        wisdom          = [Dice roll:6 nTimes:3];
        charisma        = [Dice roll:6 nTimes:3];
        
        alignment       = ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL;
        
        xp          = 0;
        totalxp     = 0;
        
#define DEFAULT_LVL1_NEXT_LEVEL_XP      10
        nextLevelXP = DEFAULT_LVL1_NEXT_LEVEL_XP;
        
        maxhp   = 0;
        hitDie  = 12;
        NSInteger conMod    = [ GameRenderer modifierForNumber: constitution ];
        
        while ( maxhp <= 0 ) {
            maxhp               = [Dice roll:hitDie] + conMod;
            hp                  = maxhp;
        }
        
        ac = 10; // the higher the better
        
        hunger  = 0;
        money   = 0;
        
        // set maxHunger based on entity and monsterTypes
        if ( entityType == ENTITY_T_PC ) {
            maxHunger = 250;
        }
        else if ( entityType == ENTITY_T_NPC ) {
            switch (monsterType) {
                case MONSTER_T_GHOUL:   maxHunger = 250; break;
                case MONSTER_T_CAT:     maxHunger = 250; break;
                default:                maxHunger = 250; break;
            }
        }
        
        inventoryArray      = [ [ NSMutableArray alloc ] init ];
        equippedArmsLeft    = nil;
        equippedArmsRight   = nil;
        equippedArmorChest  = nil;
        
        pathTaken = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm    = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
        itemPickupAlgorithm     = ENTITYITEMPICKUPALGORITHM_T_NONE;
        
        status = [Status normal];
        
        spell = SPELL_T_NONE;
        charges = 0;
        maxCharges = 0;
        ringType = 0;
        
    }
    return self;
}



-(Entity *) initWithHitDie: (NSInteger) hd {
    Entity *e   = [[Entity alloc] init];
    maxhp       = 0;
    hitDie      = hd;
    NSInteger conMod    = [ GameRenderer modifierForNumber: e.constitution ];
    while ( maxhp <= 0 ) {
        maxhp               = [Dice roll:hitDie] + conMod;
        hp                  = maxhp;
    }
    return e;
}



-(Entity *) initWithLevel:(NSInteger)_level withHitDie: (NSInteger) hd {
    Entity *e = [[ Entity alloc ] initWithHitDie: hd];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
        [ e handleLevelUp ];
    }
    return e;
}


    
-(Entity *) initWithName: (NSString *) _name withPrefixes: (NSArray *) _prefixes withEntityType: (EntityTypes_t) _entityType withThreat: (Threat_t) _threat
         withMonsterType: (Monster_t) _monsterType withItemType: (EntityItemTypes_t) _itemType withLevel: (NSInteger) _level withHitDie: (NSInteger) _hd withPFA: (EntityPathFindingAlgorithm_t) _pfa withIPA: (EntityItemPickupAlgorithm_t) _ipa withDamageRollBase: (NSInteger) _damageRollBase withAttacks: (NSArray *) _attacks {


    Entity *e               = [[Entity alloc] initWithHitDie:_hd];
    e.entityType            = _entityType;
    e.pathFindingAlgorithm  = _pfa;
    e.itemPickupAlgorithm   = _ipa;
    e.damageRollBase        = _damageRollBase;
    
    e.threatLevel           = _threat;
    e.monsterType           = _monsterType;
    e.itemType              = _itemType;
    
    [e.prefixes             setArray: _prefixes];
    
    NSMutableString *prefixNames = [NSMutableString string];
    for (Prefix_t *prefix in e.prefixes) {
        [prefixNames appendFormat: @"%@ ", prefix.name ];
    }
    [prefixNames appendString: _name];
    
    [e.name setString:      prefixNames];
    // parse a big prefix
    // this is to get around an annoying bug involving commas and the C preprocessor
    // see Monsters.h and later Items/EntitySubtypeDefines
    
    //NSString *prefix = [_prefixes objectAtIndex:0];
    //MLOG(@"Prefix: '%@'", e.prefixes);
    
    // currently not setting attack_t objects yet
    for (int i=e.level; i<_level; i++) {
        [e handleLevelUp];
    }
    
    // handle the prefix processing...
    //MLOG(@"%@", e.name);
    
    return e;
}



-(Entity *) initWithName: (NSString *) _name
            withPrefixes: (NSArray *) _prefixes
          withEntityType: (EntityTypes_t) _entityType
              withThreat: (Threat_t) _threat
         withMonsterType: (Monster_t) _monsterType
            withItemType: (EntityItemTypes_t) _itemType
               withLevel: (NSInteger) _level
              withHitDie: (NSInteger) _hd
            withStrength: (NSInteger) _str
           withDexterity: (NSInteger) _dex
        withConstitution: (NSInteger) _con
        withIntelligence: (NSInteger) _int
              withWisdom: (NSInteger) _wis
            withCharisma: (NSInteger) _cha
                 withPFA: (EntityPathFindingAlgorithm_t) _pfa
                 withIPA: (EntityItemPickupAlgorithm_t) _ipa
      withDamageRollBase: (NSInteger) _damageRollBase
             withAttacks: (NSArray *) _attacks {
    
    
    Entity *e               = [[Entity alloc] initWithHitDie:_hd];
    e.entityType            = _entityType;
    e.pathFindingAlgorithm  = _pfa;
    e.itemPickupAlgorithm   = _ipa;
    e.damageRollBase        = _damageRollBase;
    
    e.strength              = _str;
    e.dexterity             = _dex;
    e.constitution          = _con;
    e.intelligence          = _int;
    e.wisdom                = _wis;
    e.charisma              = _cha;
    
    e.threatLevel           = _threat;
    e.monsterType           = _monsterType;
    e.itemType              = _itemType;
    
    [e.prefixes             setArray: _prefixes];
    
    NSMutableString *prefixNames = [NSMutableString string];
    for (Prefix_t *prefix in e.prefixes) {
        [prefixNames appendFormat: @"%@ ", prefix.name ];
    }
    [prefixNames appendString: _name];
    
    [e.name setString:      prefixNames];
    // parse a big prefix
    // this is to get around an annoying bug involving commas and the C preprocessor
    // see Monsters.h and later Items/EntitySubtypeDefines
    
    //NSString *prefix = [_prefixes objectAtIndex:0];
   // MLOG(@"Prefix: '%@'", e.prefixes);
    
    // currently not setting attack_t objects yet
    for (int i=e.level; i<_level; i++) {
        [e handleLevelUp];
    }
    
    // handle the prefix processing...
 //   MLOG(@"%@", e.name);
    
    return e;
}





-(Entity *) initWithLevel: (NSInteger) _level {
    Entity *e = [[ Entity alloc ] init];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
        [ e handleLevelUp ];
    }
    return e;
}


/*
 ====================
 attackBonus
 
 returns the entity's total attack bonus
 ====================
 */
-(NSInteger) attackBonus {
    NSInteger strengthBonus = [ GameRenderer modifierForNumber: strength ];
    NSInteger gearBonus     = 0;
    NSInteger prefixBonus   = 0;
    NSInteger effectsBonus  = 0;
    
    // any items / equipped gear would be counted here
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        Entity *larmTool = [self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL];
        if ( larmTool.itemType == E_ITEM_T_WEAPON ) {
            gearBonus += [larmTool attackBonus];
        }
    }
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        Entity *rarmTool = [self.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL];
        if ( rarmTool.itemType == E_ITEM_T_WEAPON ) {
            gearBonus += [rarmTool attackBonus];
        }
    }
    
    
    prefixBonus  += [self prefixDamageSum];
    effectsBonus += [self effectsDamageSum];
    
    MLOG(@"%@.attackBonus = %d", self.name, strengthBonus + gearBonus);
    return strengthBonus + gearBonus;
}


/*
 ====================
 attackRoll
 
 returns the total attack roll for this entity
 ====================
 */
-( NSInteger ) attackRoll {
    return [Dice roll: 20] + self.attackBonus;
}


/*
 ====================
 damageRoll
 
 returns the total damage roll for this entity
 ====================
 */
-( NSInteger ) damageRoll {
    //return rollDiceOnce(6) + self.attackBonus;
    NSInteger roll = 0;
    
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        roll = [ Dice roll: [[self.equipment objectAtIndex:EQUIPSLOT_T_LARMTOOL] damageRollBase] ] + self.attackBonus;
    }
    else {
        roll = [Dice roll: damageRollBase] + self.attackBonus;
    }
    
    // add any effect bonuses from prefixes and effects
    roll += [self prefixDamageSum];
    roll += [self effectsDamageSum];
    
    return roll;
}


-( NSInteger ) prefixDamageSum {
    NSInteger sum = 0;
    for (Prefix_t *prefix in self.prefixes) {
        sum += prefix.effect.fireDamage;
        sum += prefix.effect.waterDamage;
        sum += prefix.effect.earthDamage;
        sum += prefix.effect.iceDamage;
        sum += prefix.effect.lightningDamage;
    }
    return sum;
}

-(NSInteger) effectsDamageSum {
    NSInteger sum = 0;
    for (Effect_t *effect in self.effects) {
        sum += effect.fireDamage;
        sum += effect.waterDamage;
        sum += effect.earthDamage;
        sum += effect.iceDamage;
        sum += effect.lightningDamage;
    }
    return sum;
}



/*
 ====================
 damageRollBase
 
 returns the damage roll base for this entity
 ====================
 */
-( NSInteger ) damageRollBase {
    NSInteger base = damageRollBase;
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        base = [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] damageRollBase];
    }
    else {
        base = damageRollBase;
    }
    return base;
}


/*
 ====================
 setDamageRollBase: _damageRollBase
 
 sets the damage roll base
 ====================
 */
-(void) setDamageRollBase:(NSInteger) _damageRollBase {
    damageRollBase = _damageRollBase;
}



/*
 ====================
 ac
 
 returns the total ac 
 ====================
 */
-( NSInteger ) totalac {
    NSInteger dexterityBonus = [ GameRenderer modifierForNumber: dexterity ];
    NSInteger armorBonus = 0;
    
    // check chest for chest armor
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_CHEST] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        Entity *armor = [self.equipment objectAtIndex: EQUIPSLOT_T_CHEST];
        armorBonus += [armor ac];
    }
    
    // check left arm for shield
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        Entity *larmTool = [self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL];
        if ( larmTool.itemType == E_ITEM_T_ARMOR ) {
            if ( larmTool.armorType == ARMOR_T_SHIELD ) {
                armorBonus += [larmTool ac];
            }
        }
    }
    
    // check right arm for shield
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        Entity *rarmTool = [self.equipment objectAtIndex: EQUIPSLOT_T_RARMTOOL];
        if ( rarmTool.itemType == E_ITEM_T_ARMOR ) {
            if ( rarmTool.armorType == ARMOR_T_SHIELD ) {
                armorBonus += [rarmTool ac];
            }
        }
    }
    
    return ac + dexterityBonus + armorBonus;
}


/*
 ====================
 movement
 
 returns the total allowed move speed per turn
 ====================
 */
-( NSInteger ) movement {
    return 1;
}


/*
 ====================
 gainXP: exp
 
 adds exp to your xp and handles level ups
 ====================
 */
-( void ) gainXP: (NSInteger) exp {
    xp += exp;
    totalxp += exp;
    
    if ( xp >= nextLevelXP ) {
        [ self handleLevelUp ];
    }
}


/*
 ====================
 handleLevelUp
 
 manages level up events
 ====================
 */

-( void ) handleLevelUp {
    level++;
    xp = 0;
    nextLevelXP *= 2;
    
    // all entities leveling up get a random point into a stat
    // player will get to choose their point
    if ( ! self.isPC ) {
        NSInteger r = [Dice roll:6];
    
        r==1 ? strength++       :
        r==2 ? dexterity++      :
        r==3 ? constitution++   :
        r==4 ? intelligence++   :
        r==5 ? wisdom++         :
        r==6 ? charisma++       :
        0;
        
        // lets up our hp
        NSInteger conMod = [ GameRenderer modifierForNumber: constitution ];
        maxhp = (conMod > 0) ? (maxhp + [Dice roll: hitDie ] + conMod) : (maxhp + [Dice roll: hitDie]);
        hp = maxhp;
        
    }
    
    else if ( self.isPC ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerLevelUpNotification" object:nil];
    }
    
}


/*
 ====================
 handleLevelDown
 
 handles the level down event (unfortunate!)
 ====================
 */
-( void ) handleLevelDown {
    level--;
    nextLevelXP /= 2;
}



/*
 ====================
 step
 
 steps the entity's logic one turn
 ====================
 */
-( void ) step {
    //MLOG( @"Entity step" );
}


/*
 ====================
 getHungry
 
 advances the entity's hunger
 ====================
 */
-( void ) getHungry {
    
    // check if wearing the antihunger ring...
    Entity *lring = [self.equipment objectAtIndex:EQUIPSLOT_T_LRING];
    Entity *rring = [self.equipment objectAtIndex:EQUIPSLOT_T_RRING];
    
    BOOL hasAntihungerRing =
    ([lring isKindOfClass:NSClassFromString(@"Entity")] && lring.ringType == E_RING_T_ANTIHUNGER) ||
    ([rring isKindOfClass:NSClassFromString(@"Entity")] && rring.ringType == E_RING_T_ANTIHUNGER);
    
    if ( ! hasAntihungerRing ) hunger++;
    
    // various levels of hunger...
    // lets start with
    // 50  = a little hungry
    // 100 = hungry
    // 150 = very hungry
    // 200 = starving
    // 250 = dead
    
    isAlive = ( ! hunger >= maxHunger );
    hp = ( isAlive ? hp : 0 );
    

}


/*
 ====================
 equipItem: item forEquipSlot: equipSlot
 ====================
 */
-(void) equipItem: (Entity *) item forEquipSlot: (EquipSlot_t) equipSlot {
    // MLOG(@"equipItem: %@ forEquipSlot: %@", item.name, EquipSlotToStr(equipSlot));
    [self unequipItemForEquipSlot:equipSlot];
    [self.equipment setObject: item atIndexedSubscript: equipSlot];
    [self.inventoryArray removeObject: item];
}

-(void) unequipItemForEquipSlot: (EquipSlot_t) equipSlot {
    // MLOG(@"equipItem: %@ forEquipSlot: %@", item.name, EquipSlotToStr(equipSlot));
    NSObject *oldItem = [self.equipment objectAtIndex: equipSlot];
    [self.equipment setObject: [NSNull null] atIndexedSubscript: equipSlot];
    [oldItem isKindOfClass:NSClassFromString(@"Entity")] ? [self.inventoryArray addObject: oldItem] : 0;
}





/*
 ====================
 totalWeight
 ====================
 */
-(NSInteger) totalWeight {
    int total = 0;
    if ( self.entityType==ENTITY_T_PC || self.entityType==ENTITY_T_NPC ) {
        //for (Entity *e in self.equipment) {
        for (Entity *e in self.inventoryArray) {
            if ( [e isKindOfClass:NSClassFromString(@"Entity")])
                total += e.weight;
        }
        
        for (Entity *e in self.equipment) {
            if ( [e isKindOfClass:NSClassFromString(@"Entity")] ) {
                total += e.weight;
            }
        }

    } else {
        total = self.weight;
    }
    return total;
}

@end