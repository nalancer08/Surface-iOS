//
//  Launch.m
//  Surface
//
//  Created by Webchimp on 29/01/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Launch.h"
#import "MyScene.h"

@interface Launch ()

@end

@implementation Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash"]];
    
    Surface *launch = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    
    //NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"header"}];
    //[launch add:@"image" width:-1 heigth:200 key:@"header" params:header controller:self];
    
    NSMutableDictionary *logo = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"logo-tertulia", @"position": @"center"}];
    [launch add:@"image" width:290 heigth:290 key:@"logo" params:logo controller:self];
    
    UIImage* mars = [UIImage imageNamed:@"header"];
    CGSize sz = [mars size];
    UIGraphicsBeginImageContextWithOptions(
                                           CGSizeMake(sz.width/2.0, sz.height), NO, 0);
    [mars drawAtPoint:CGPointMake(-sz.width/2.0, 0)];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *la = [[UIImageView alloc] initWithFrame:CGRectMake(250, 350, 100, 100)];
    la.image = im;
    
    [self.view addSubview:la];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
