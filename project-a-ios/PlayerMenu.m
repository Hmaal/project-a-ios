//  PlayerMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "PlayerMenu.h"

@implementation PlayerMenu

@synthesize label;


/*
 ====================
 initWithColor: color width: w height: h
 
 initializes a new PlayerMenu with a set color, width, and height
 ====================
 */
-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        
        //Color3_t fontColor = black3;
        Color3_t fontColor = white3;
        
        CCLabelTTF *menuItemLabelMinimize       = [[CCLabelTTF alloc] initWithString:   @"Minimize"     fontName:@"Courier New" fontSize:16 ];
        menuItemLabelMinimize.color             = fontColor;
        
        CCLabelTTF *menuItemLabelStatus         = [[CCLabelTTF alloc] initWithString:   @"Status"       fontName:@"Courier New" fontSize:16 ];
        menuItemLabelStatus.color               = fontColor;
        
        CCLabelTTF *menuItemLabelEquip          = [[CCLabelTTF alloc] initWithString:   @"Equip"       fontName:@"Courier New" fontSize:16 ];
        menuItemLabelEquip.color                = fontColor;
        
        CCLabelTTF *menuItemLabelInventory      = [[CCLabelTTF alloc] initWithString:   @"Inventory"    fontName:@"Courier New" fontSize:16 ];
        menuItemLabelInventory.color            = fontColor;
        
        CCLabelTTF *menuItemLabelPickup         = [[CCLabelTTF alloc] initWithString:   @"Pickup"       fontName:@"Courier New" fontSize:16 ];
        menuItemLabelPickup.color               = fontColor;
        
        
        
        CCLabelTTF *menuItemLabelStep           = [[CCLabelTTF alloc] initWithString:   @"Step"         fontName:@"Courier New" fontSize:16 ];
        menuItemLabelStep.color                 = fontColor;
        
        CCLabelTTF *menuItemLabelAutostep       = [[CCLabelTTF alloc] initWithString:   @"Autostep"     fontName:@"Courier New" fontSize:16 ];
        menuItemLabelAutostep.color             = fontColor;
        
        CCLabelTTF *menuItemLabelMonitor        = [[CCLabelTTF alloc] initWithString:   @"Monitor"      fontName:@"Courier New" fontSize:16 ];
        menuItemLabelMonitor.color              = fontColor;
        
        CCLabelTTF *menuItemLabelHelp           = [[CCLabelTTF alloc] initWithString:   @"Help"         fontName:@"Courier New" fontSize:16 ];
        menuItemLabelHelp.color                 = fontColor;
        
        CCLabelTTF *menuItemLabelEntityInfo     = [[CCLabelTTF alloc] initWithString:   @"EntityInfo"   fontName:@"Courier New" fontSize:16 ];
        menuItemLabelEntityInfo.color           = fontColor;
        
        
        
        
        CCLabelTTF *menuItemLabelReset          = [[CCLabelTTF alloc] initWithString:   @"Reset"        fontName:@"Courier New" fontSize:16 ];
        menuItemLabelReset.color                = fontColor;
        
        NSInteger p = 24;
        NSInteger k = 1;
        CCMenuItem *menuItemMinimize    = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMinimize target:self selector:@selector(menuItemClosePressed) ];
        menuItemMinimize.position       = ccp( 0 + menuItemMinimize.contentSize.width/2, h - p*k++ );
        
        CCMenuItem *menuItemStatus      = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStatus target:self selector:@selector(menuItemStatusPressed) ];
        menuItemStatus.position         = ccp( 0 + menuItemStatus.contentSize.width/2, h - p*k++);
        
        CCMenuItem *menuItemEquip       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelEquip target:self selector:@selector(menuItemEquipPressed) ];
        menuItemEquip.position          = ccp( 0 + menuItemEquip.contentSize.width/2, h - p*k++);
        
        CCMenuItem *menuItemInventory   = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelInventory target:self selector:@selector(menuItemInventoryPressed) ];
        menuItemInventory.position      = ccp( 0 + menuItemInventory.contentSize.width/2, h - p*k++ );
        
        CCMenuItem *menuItemPickup      = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelPickup target:self selector:@selector(menuItemPickupPressed) ];
        menuItemPickup.position         = ccp( 0 + menuItemPickup.contentSize.width/2, h - p*k++ );
        
        
        CCMenuItem *menuItemStep        = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStep target:self selector:@selector(menuItemStepPressed) ];
        menuItemStep.position           = ccp( 0 + menuItemStep.contentSize.width/2, h - p*k++ );
        
        //CCMenuItem *menuItemAutostep    = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelAutostep target:self selector:@selector(menuItemAutostepPressed) ];
        //menuItemAutostep.position       = ccp( 0 + menuItemAutostep.contentSize.width/2, h - p*k++ );
        
        CCMenuItem *menuItemMonitor     = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMonitor target:self selector:@selector(menuItemMonitorPressed) ];
        menuItemMonitor.position        = ccp( 0 + menuItemMonitor.contentSize.width/2, h - p*k++ );
        
        CCMenuItem *menuItemHelp        = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelHelp target:self selector:@selector(menuItemHelpPressed) ];
        menuItemHelp.position           = ccp( 0 + menuItemHelp.contentSize.width/2, h - p*k++ );
        
        CCMenuItem *menuItemEntityInfo  = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelEntityInfo target:self selector:@selector(menuItemEntityInfoPressed) ];
        menuItemEntityInfo.position     = ccp( 0 + menuItemLabelEntityInfo.contentSize.width/2, h - p*k++ );
        
        
        
        CCMenuItem *menuItemReset       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelReset target:self selector:@selector(menuItemResetPressed) ];
        menuItemReset.position          = ccp( 0 + menuItemReset.contentSize.width/2, h -p*k++ );
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         menuItemMinimize,
                                                         menuItemStatus,
                                                         menuItemEquip,
                                                         menuItemInventory,
                                                         menuItemPickup,
                                                         menuItemStep,
                                                         //menuItemAutostep,
                                                         menuItemMonitor,
                                                         menuItemHelp,
                                                         menuItemEntityInfo,
                                                         menuItemReset,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
    }
    return self;
}


-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h isMinimized:(BOOL)isMin {
    if ( ( self = [ super initWithColor: black_alpha(255) width: w height: h ] ) ) {
        
        if ( isMin ) {
            // close button
            CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"Maximize" fontName:@"Courier New" fontSize:16 ];
            menuItemLabelClose.color = white3;
 
            CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose  target:self selector:@selector(menuItemClosePressed)];
            menuItemClose.position = ccp( 0 + menuItemClose.contentSize.width/2, h - 24 );
            
            CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                             menuItemClose,
                                                             nil] ];
            menu.position = ccp( 0, 0 );
            [ self addChild: menu ];
            
        } else {
            self = [ self initWithColor:color width:w height:h];
        }
    }
    return self;
}



#define MENUITEMCLOSE_NOTIFICATIONNAME @"PlayerMenuCloseNotification"
-( void ) menuItemClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEMCLOSE_NOTIFICATIONNAME  object:self];
}

-( void ) menuItemStatusPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStatusNotification"  object:self];
}

-( void ) menuItemEquipPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuEquipNotification"  object:self];
}

-( void ) menuItemInventoryPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuInventoryNotification"  object:self];
}

-( void ) menuItemPickupPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuPickupNotification"  object:self];
}


-( void ) menuItemStepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStepNotification"  object:self];
}

-( void ) menuItemAutostepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuAutostepNotification"  object:self];
}

-( void ) menuItemMonitorPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuMonitorNotification"  object:self];
}


-( void ) menuItemTogglePositionPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuTogglePositionNotification"  object:self];
}

-( void ) menuItemToggleHUDsPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuToggleHUDsNotification"  object:self];
}

-( void ) menuItemResetPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuResetNotification"  object:self];
}

-( void ) menuItemHelpPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuHelpNotification"  object:self];
}

-(void) menuItemEntityInfoPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuEntityInfoNotification"  object:self];
}

@end