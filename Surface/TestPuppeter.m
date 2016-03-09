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
    
    Puppeteer *window = [[Puppeteer alloc] initWithTabBarinController:self];
    //window.box.backgroundColor = blue;
    
    NSArray *controllers = @[ [Puppeteer newController:[ViewController class] withTitle:@"Surface" andImage:[UIImage imageNamed:@"logo-tertulia"]], [Puppeteer newController:[Launch class] withTitle:@"Launch" andImage:nil] ];
    
    [window setTabBarControllers:controllers];


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
