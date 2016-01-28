//
//  ViewController.m
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    
    Surface *surface1;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIDevice *device = [UIDevice currentDevice];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
    surface1 = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    //Surface *surface2 = [[Surface alloc] initWithSizeWidth:-1 height:150 controller:self grid:@"fluid" display:YES params:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"Hola textooooooo!!!"}];
    [params setObject:@"font" forKey:@"font"];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label1" params:params controller:self];
    [surface1 add:@"text" width:50 heigth:35 key:@"label2" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label3" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label4" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label5" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label6" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label7" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label8" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label9" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label10" params:params controller:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orientationChanged:(NSNotification *)note {
    NSLog(@"me movi");
    [surface1 update];
}

@end
