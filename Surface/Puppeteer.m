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
        
        NSMutableDictionary *tab = [NSMutableDictionary dictionaryWithDictionary:@{@"position": @"bottom"}];
        [self.full addSurface:self.tabBar key:@"tabBar" params:tab controller:self.controller];
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
    
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"hola mundooo!!!", @"function" : [NSValue valueWithPointer:@selector(tabPress:)], @"newClass" : [self class], @"tag" : [NSNumber numberWithInt:1]}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t1" params:params1 controller:self.controller];
    
    /*UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"boton chido" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];

    [button addTarget:self action:@selector(tabPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addCustom:button key:@"t1" params:nil controller:self.controller];
*/
    NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"lalitas 3000!!!", @"function" : [NSValue valueWithPointer:@selector(tabPress:)], @"newClass" : [self class], @"tag" : [NSNumber numberWithInt:12]}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t2" params:params2 controller:self.controller];

    UIButton *la = (UIButton *)[self.tabBar getObject:@"t2"];
    la.backgroundColor = [UIColor yellowColor];
}

+ (void)tabPress:(UIButton *)sender {
    NSLog(@"jalando el boton en esta mierda");
    UIButton *tab = (UIButton *)sender;
    NSLog(@"TAG ==== %ld", (long)tab.tag);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


+ (NSDictionary *)newController:(Class)class withTitle:(NSString *)title andImage:(UIImage *)image {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller", title, @"title", image, @"image", nil];
    
}



@end
