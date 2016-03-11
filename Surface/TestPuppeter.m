//
//  TestPuppeter.m
//  Surface
//
//  Created by Webchimp on 09/03/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "TestPuppeter.h"
#import "WebchimpUtilities.h"
#import "ViewController.h"
#import "Launch.h"

@interface TestPuppeter ()

@end

@implementation TestPuppeter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *blue = [WebchimpUtilities htmlColor:@"32a4e0"];
    //self.view.backgroundColor = blue;
    
    self.window = [[Puppeteer alloc] initWithTabBarinController:self];
    //window.box.backgroundColor = blue;
    
    NSArray *controllers = @[ [Puppeteer newController:[ViewController class] withTitle:@"Surface" andImage:[UIImage imageNamed:@"logo-tertulia"]], [Puppeteer newController:[Launch class] withTitle:@"Launch" andImage:nil] ];
    
    [self.window setTabBarControllers:controllers];
    
    Surface *body = [self.window getView];
    
    body.box.backgroundColor = blue;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"Hola textooooooo!!!"}];
    [params setObject:@"font" forKey:@"font"];
    [body add:@"button" width:-1 heigth:35 key:@"bt1" params:params controller:self];
    
    [body add:@"text_field" width:-1 heigth:35 key:@"t1" params:params controller:self];
    [body add:@"text_field" width:-1 heigth:35 key:@"t2" params:params controller:self];
    [body add:@"text" width:-1 heigth:35 key:@"label1" params:params controller:self];
    [body add:@"text" width:50 heigth:35 key:@"label2" params:params controller:self];
    [body add:@"text" width:-1 heigth:35 key:@"label3" params:params controller:self];
    [body add:@"text" width:-1 heigth:35 key:@"label4" params:params controller:self];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
