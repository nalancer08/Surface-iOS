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

- (void)getTabBarHeight {
    
    UITabBarController *tabBarOriginal = [[UITabBarController alloc] init];
    //NSLog(@"TabBar alto === %f", tabBarOriginal.tabBar.frame.size.height);
    self.tabBarHeight = tabBarOriginal.tabBar.frame.size.height;

}


- (void)setTabBarControllers:(NSArray *)controllers {
    
    //NSLog(@"controles === %@ son %lu elementos", controllers, (unsigned long)controllers.count);
    int numberdivs = (int)controllers.count;
    
    NSMutableDictionary *numberOfDivs = [NSMutableDictionary dictionaryWithDictionary:@{@"colums": [NSNumber numberWithInt:numberdivs]}];
    [self.tabBar modifiedParams:numberOfDivs];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"Hola textooooooo!!!"}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t1" params:params controller:self.controller];
    NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"lalitas 3000!!!"}];
    [self.tabBar add:@"button" width:-1 heigth:self.tabBarHeight key:@"t2" params:params2 controller:self.controller];

    UIButton *la = (UIButton *)[self.tabBar getObject:@"t2"];
    la.backgroundColor = [UIColor yellowColor];
}


+ (NSDictionary *)newController:(Class)class withTitle:(NSString *)title andImage:(UIImage *)image {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller", title, @"title", image, @"image", nil];
    
}

@end
