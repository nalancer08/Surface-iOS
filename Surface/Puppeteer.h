//
//  Puppeteer.h
//  Surface
//
//  Created by Webchimp on 09/03/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#warning "This library complete depends of Surface"
#import "Surface.h"

@interface Puppeteer : NSObject

// Properties

    @property (nonatomic) float tabBarHeight;
    @property (nonatomic) float surfaceWidth;

    @property (retain, nonatomic) UIViewController *controller;

    // Surfaces
    @property (retain, nonatomic) Surface *full;
    @property (retain, nonatomic) Surface *tabBar;
    @property (retain, nonatomic) Surface *navigationBar;
    @property (retain, nonatomic) Surface *body;

// Constructors
    - (void)start;
    //- (id)initWithNavigationAndTabBarsinController:(UIViewController *)controller;
    //- (id)initWithNavigationBarinController:(UIViewController *)controller;
    - (id)initWithTabBarinController:(UIViewController *)controller;

// Helpers
    - (void)getTabBarHeight;

// TabBar
    + (NSArray *)controllers;
    + (NSDictionary *)newController:(Class) class withTitle:(NSString *)title andImage:(UIImage *)image;
    - (void)setTabBarControllers:(NSArray *)controllers;

@end
