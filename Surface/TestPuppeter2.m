//
//  TestPuppeter2.m
//  Surface
//
//  Created by Webchimp on 14/03/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "TestPuppeter2.h"
#import "WebchimpUtilities.h"
#import "Puppeteer.h"
#import "Launch.h"
#import "Buscador.h"

@interface TestPuppeter2 ()

@end

@implementation TestPuppeter2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *orange = [WebchimpUtilities htmlColor:@"d14a26"];
    self.view.backgroundColor = orange;
    
    self.window = [[Puppeteer alloc] initPersonilized:self hasTabBar:YES hasNavigation:NO];
    
    NSArray *objects = @[ [Puppeteer newTabwithTitle:@"uno" andImage:nil], [Puppeteer newTabwithTitle:@"dos" andImage:nil] ];
    
    NSArray *tabs = [self.window makeTabs:objects position:@"top"];
    
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
