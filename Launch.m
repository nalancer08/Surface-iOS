//
//  Launch.m
//  Surface
//
//  Created by Webchimp on 29/01/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Launch.h"
#import "Sparrow.h"
#import "Buscador.h"
#import "AFNetworking.h"

@interface Launch ()

@end

@implementation Launch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data1 = [NSUserDefaults standardUserDefaults];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash"]];
    
    Surface *launch = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    NSString *liga = @"http://chimptest.com/tertulia_v2/api/1.0/categorias/";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:liga parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        json = (NSDictionary *)responseObject;
        js = json[@"data"];
        
        [self.data1 setObject:json[@"data"] forKey:@"categorias"];
       
        //NSLog(@"JSON: %@", json);
        
        //NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSLog(@"dataaaa %@", [self.data1 objectForKey:@"categorias"]);
    
    //NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"header"}];
    //[launch add:@"image" width:-1 heigth:200 key:@"header" params:header controller:self];
    
    //NSMutableDictionary *logo = [NSMutableDictionary dictionaryWithDictionary:@{@"name" : @"logo-tertulia", @"position": @"center"}];
    //[launch add:@"image" width:290 heigth:290 key:@"logo" params:logo controller:self];
    
    Sparrow *img = [[Sparrow alloc] init];
    img.frame = CGRectMake(0, 10, 300, 300);
    [img loadImageWithName:@"logoTertulia" In:self];
    [img setWidthSprite:300 Height:300];
    [img setTimer:.01 withRepeat:NO];
    [img endAnimation:@selector(alerta) fromObject:self];
    [img run];
    //[self.view addSubview:img];
    
    NSMutableDictionary *logo1 = [NSMutableDictionary dictionaryWithDictionary:@{@"position": @"center"}];
    [launch addCustom:img key:@"animation1" params:logo1 controller:self];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alerta {
    
    NSLog(@"lalitas jalando bn chido");
    Buscador *buscador = [[Buscador alloc] init];
    if ( [self.data1 objectForKey:@"categorias"] != NULL && [self.data1 objectForKey:@"categorias"] != nil ) {
        [self presentViewController:buscador animated:YES completion:nil];
    }
    
}


@end
