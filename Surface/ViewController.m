//
//  ViewController.m
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "ViewController.h"
#import "Surface.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Surface *surface1 = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    Surface *surface2 = [[Surface alloc] initWithSizeWidth:-1 height:250 controller:self grid:@"fkuid" display:YES params:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
