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

@interface Puppeteer : UIView

// Properties

    @property (nonatomic) float tabBarHeight;
    @property (nonatomic) float surfaceWidth;

    @property (retain, nonatomic) UIViewController *controller;
    @property (retain, nonatomic) NSArray *controllers;
    @property (retain, nonatomic) NSString *myType;
    @property (retain, nonatomic) NSMutableDictionary *tabsArray;

    // Surfaces
    @property (retain, nonatomic) Surface *full;
    @property (retain, nonatomic) Surface *tabBar;
    @property (retain, nonatomic) Surface *navigationBar;
    @property (retain, nonatomic) Surface *body;

    @property (retain, nonatomic) Surface *tabs;

// Constructors
    - (void)start;
    //- (id)initWithNavigationAndTabBarsinController:(UIViewController *)controller;
    //- (id)initWithNavigationBarinController:(UIViewController *)controller;
    - (id)initWithTabBarinController:(UIViewController *)controller;
    - (id)initPersonilized:(UIViewController *)controller hasTabBar:(BOOL)tabBar hasNavigation:(BOOL)navigation;

    + (NSDictionary *)newPropertie:(NSString *)propertie withValue:(id)value;

// Helpers
    - (void)getTabBarHeight;

// TabBar
    + (NSDictionary *)newController:(Class) class withTitle:(NSString *)title andImage:(UIImage *)image;
    - (void)setTabBarControllers:(NSArray *)controllers;
    - (void)tabPress:(UIButton *)sender;

    - (Surface *)getView;
    - (void)test;

// TABS

    - (NSArray *)makeTabs:(NSArray *)tabs position:(NSString *)aposition;
    + (NSDictionary *)newTabwithTitle:(NSString *)title andImage:(UIImage *)image;

@end
