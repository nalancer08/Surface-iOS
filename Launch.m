//
//  Launch.m
//  Surface
//
//  Created by Webchimp on 29/01/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Launch.h"

@interface Launch ()

@end

@implementation Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Surface *launch = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"header"}];
    [launch add:@"image" width:-1 heigth:200 key:@"header" params:header controller:self];
    
    NSMutableDictionary *logo = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"logo-tertulia"}];
    [launch add:@"image" width:290 heigth:290 key:@"logo" params:logo controller:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
