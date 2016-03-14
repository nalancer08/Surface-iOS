//
//  Puppeteer.m
//  Surface
//
//  Created by Webchimp on 09/03/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Puppeteer.h"

@implementation Puppeteer

-(void)start {
    
    self.tabBar = nil;
    self.navigationBar = nil;
    self.body = nil;
    self.tabs = nil;
    
    self.controller = nil;
    
}

- (id)initWithTabBarinController:(UIViewController *)controller {

    if ( self = [super init] ) {
        
        [self start];
        
        self.controller = controller;
        
        self.full = [[Surface alloc] initFullSize:self.controller grid:@"fluid" display:YES params:nil];
        
        [self getTabBarHeight];
        
        self.tabBar = [[Surface alloc] initWithSizeWidth:self.full.box.bounds.size.width height:self.tabBarHeight controller:controller grid:@"boxes" display:NO params:nil];
        
        self.tabBar.box.backgroundColor = [UIColor greenColor];
        
        self.surfaceWidth = self.full.box.bounds.size.width;
        
        NSMutableDictionary *tab = [NSMutableDictionary dictionaryWithDictionary:@{@"position": @"bottom"}];
        [self.full addSurface:self.tabBar key:@"tabBar" params:tab controller:self.controller];
    }
                                                                 
    return self;
    
}

- (id)initPersonilized:(UIViewController *)controller hasTabBar:(BOOL)tabBar hasNavigation:(BOOL)navigation {
    
    if ( self = [super init] ) {
        
        [self start];
        
        self.controller = controller;
        self.myType = @"personalized";
        
        [self getTabBarHeight];
        
        if ( tabBar && navigation ) {
            
            self.surfaceWidth = self.controller.view.bounds.size.width;
            float height = (self.controller.view.bounds.size.height) - (self.controller.tabBarController.tabBar.frame.size.height) - (self.controller.navigationController.navigationBar.frame.size.height);
            
            self.full = [[Surface alloc] initWithSizeWidth:self.surfaceWidth height:height controller:self.controller grid:@"fluid" display:YES params:nil];
            
        } else if ( tabBar && !navigation ) {
            
            self.surfaceWidth = self.controller.view.bounds.size.width;
            float height = (self.controller.view.bounds.size.height) - (self.controller.tabBarController.tabBar.frame.size.height);
            
            self.full = [[Surface alloc] initWithSizeWidth:self.surfaceWidth height:height controller:self.controller grid:@"fluid" display:YES params:nil];
        }

    }
    
    return self;
}



/*
+ (Surface *)initWithNavigationBarinController:(UIViewController *)controller {

    Surface *full = [[Surface alloc] initFullSize:controller grid:@"fluid" display:YES params:nil];
    
    return full;

}

+ (Surface *)initWithNavigationAndTabBarsinController:(UIViewController *)controller {

    Surface *full = [[Surface alloc] initFullSize:controller grid:@"fluid" display:YES params:nil];
    
    return full;
}*/

/////////////////////////////////////////////// METHODS FOR TAB BAR /////////////////////////////////////////////////////////////////


- (void)getTabBarHeight {
    
    UITabBarController *tabBarOriginal = [[UITabBarController alloc] init];
    //NSLog(@"TabBar alto === %f", tabBarOriginal.tabBar.frame.size.height);
    self.tabBarHeight = tabBarOriginal.tabBar.frame.size.height;

}


- (void)setTabBarControllers:(NSArray *)controllers {
    
    //NSLog(@"controles === %@ son %lu elementos", controllers, (unsigned long)controllers.count);
    self.controllers = controllers;
    int numberdivs = (int)self.controllers.count;
    
    NSMutableDictionary *numberOfDivs = [NSMutableDictionary dictionaryWithDictionary:@{@"colums": [NSNumber numberWithInt:numberdivs]}];
    [self.tabBar modifiedParams:numberOfDivs];
    
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"hola mundooo!!!", @"function" : [NSValue valueWithPointer:@selector(tabPress:)], @"newClass" : self, @"tag" : [NSNumber numberWithInt:1]}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t1" params:params1 controller:self.controller];
    
    /*UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"boton chido" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];

    [button addTarget:self action:@selector(tabPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addCustom:button key:@"t1" params:nil controller:self.controller];
*/
    NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"lalitas 3000!!!", @"function" : [NSValue valueWithPointer:@selector(tabPress:)], @"newClass" : self, @"tag" : [NSNumber numberWithInt:12]}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t2" params:params2 controller:self.controller];

    UIButton *la = (UIButton *)[self.tabBar getObject:@"t2"];
    la.backgroundColor = [UIColor yellowColor];
}

- (void)tabPress:(UIButton *)sender {
    
    NSLog(@"jalando el boton en esta mierda");
    UIButton *tab = (UIButton *)sender;
    (NSLog(@"TAG ==== %ld  controller", (long)tab.tag));
    
    Surface *ojala = self.tabsArray[[NSString stringWithFormat:@"tab%ld", tab.tag]];
    [ojala present];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


+ (NSDictionary *)newController:(Class)class withTitle:(NSString *)title andImage:(UIImage *)image {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller", title, @"title", image, @"image", nil];
    
}

+ (NSDictionary *)newTabwithTitle:(NSString *)title andImage:(UIImage *)image {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title", image, @"image", nil];
    
}

+ (NSDictionary *)newPropertie:(NSString *)propertie withValue:(id)value {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:propertie, @"propertie", value, @"value", nil];
}

//////////////////////////// GENERAL TABS //////////////////////////////

- (NSArray *)makeTabs:(NSArray *)tabs position:(NSString *)aposition {
    
    NSLog(@"tabs send == %@", tabs[1]);
    
    int i;
    self.controllers = tabs;
    int numberdivs = (int)self.controllers.count;
    NSLog(@"son == %d", numberdivs);
    self.tabsArray = [[NSMutableDictionary alloc] init];
    
    self.tabs = [[Surface alloc] initWithSizeWidth:self.surfaceWidth height:self.tabBarHeight controller:self.controller grid:@"boxes" display:YES params:nil];
    
    NSMutableDictionary *numberOfDivs = [NSMutableDictionary dictionaryWithDictionary:@{@"colums": [NSNumber numberWithInt:numberdivs]}];
    [self.tabs modifiedParams:numberOfDivs];
    
    
    for ( i = 0; i < numberdivs ; i ++ ) {
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"hola mundooo!!!", @"function" : [NSValue valueWithPointer:@selector(tabPress:)], @"newClass" : self, @"tag" : [NSNumber numberWithInt:1]}];
        [self.tabs add:@"button" width:-1 heigth:self.tabBarHeight key:[NSString stringWithFormat:@"t%d", (i+1)] params:params1 controller:self.controller];
        
        Surface *surface = [[Surface alloc] initWithSizeWidth:50 height:50 controller:self.controller grid:@"fluid" display:NO params:nil];
        
        [self.tabsArray setObject:surface forKey:[NSString stringWithFormat:@"tab%d", (i+1)]];
        
    }
    
    
    UIButton *la = (UIButton *)[self.tabs getObject:@"t2"];
    la.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"arreglo de tabs ====   %@", self.tabsArray);
    //eri.box.backgroundColor = [UIColor yellowColor];
    Surface *testing = self.tabsArray[@"tab2"];
    testing.box.backgroundColor = [UIColor magentaColor];
    
    return @[];
}



////////////////////////////////////////////////////////////////////////////////////


- (Surface *)getView {
    
    if ( self.tabBar != nil && self.navigationBar != nil ) {
        
        
    } else if ( self.tabBar != nil && self.navigationBar == nil ) {
        //
        NSLog(@"si hay tabBar");
        float hBody = self.full.box.bounds.size.height - self.tabBarHeight;
        NSLog(@"pantalla alto %f, tb = %f  final = %f", self.full.box.bounds.size.height, self.tabBarHeight, hBody);
        self.body = [[Surface alloc] initWithSizeWidth:self.surfaceWidth height:hBody controller:self.controller grid:@"fluid" display:YES params:nil];
        //
    } else if ( self.tabBar == nil && self.navigationBar != nil ) {
        //
    }
    
    return self.body;
}



- (void)test {
    NSLog(@"si sis sisisisis");
}



@end
