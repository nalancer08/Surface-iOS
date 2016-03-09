//
//  ViewController.m
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "ViewController.h"
#import "WebchimpUtilities.h"


@interface ViewController () {
    
    Surface *surface1;
    WebchimpUtilities *utilities;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[WebchimpUtilities alerts:self Title:@"Hola mundo" Message:@"Jalando Utilities" Style:@"default"];
    
    UIDevice *device = [UIDevice currentDevice];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
    surface1 = [[Surface alloc] initFullSize:self grid:@"fluid" display:YES params:nil];
    Surface *surface2 = [[Surface alloc] initWithSizeWidth:-1 height:90 controller:self grid:@"boxes" display:NO params:nil];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"Hola textooooooo!!!"}];
    [params setObject:@"font" forKey:@"font"];
    [surface1 add:@"button" width:-1 heigth:35 key:@"bt1" params:params controller:self];
    [surface1 addSurface:surface2 key:@"s1" params:nil controller:self];
    
    [surface1 add:@"text_field" width:-1 heigth:35 key:@"t1" params:params controller:self];
    [surface1 add:@"text_field" width:-1 heigth:35 key:@"t2" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label1" params:params controller:self];
    [surface1 add:@"text" width:50 heigth:35 key:@"label2" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label3" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label4" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label5" params:params controller:self];
    //[surface1 add:@"text" width:-1 heigth:35 key:@"label6" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label7" params:params controller:self];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:@{@"function" : [NSValue valueWithPointer:@selector(alertitas)]}];
    [surface1 add:@"button" width:-1 heigth:35 key:@"bt12" params:params1 controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label8" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label9" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label10" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label11" params:params controller:self];
    [surface1 add:@"text" width:-1 heigth:35 key:@"label12" params:params controller:self];
    
    
    [surface2 add:@"text" width:-1 heigth:35 key:@"label103" params:params controller:self];
    [surface2 add:@"button" width:-1 heigth:35 key:@"bt1" params:params controller:self];
    [surface2 add:@"text" width:-1 heigth:35 key:@"label13" params:params controller:self];
    [surface2 add:@"text" width:-1 heigth:35 key:@"label1gg4" params:params controller:self];
    [surface2 add:@"text" width:-1 heigth:35 key:@"label1g4" params:params controller:self];

    [surface2 add:@"text" width:-1 heigth:35 key:@"label1ghg4" params:params controller:self];

    [surface2 add:@"text" width:-1 heigth:35 key:@"label1gjg4" params:params controller:self];

    [surface2 add:@"text" width:-1 heigth:35 key:@"label1gig4" params:params controller:self];

    
    //[surface2 add:@"text" width:-1 heigth:-1 key:@"label14" params:params controller:self];
    //[surface2 add:@"text" width:-1 heigth:-1 key:@"label15" params:params controller:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orientationChanged:(NSNotification *)note {
    //NSLog(@"me movi");
    //[surface1 update];
}


// FUNCION DEL BOTON NUMERO 1
- (void)alertitas {
    
    UIColor *rojo = [WebchimpUtilities htmlColor:@"e05c5e"];
    
    UITextField *texto = (UITextField *)[surface1 getObject:@"t1"];
    texto.backgroundColor = rojo;
    UIButton *bt = (UIButton *)[surface1 getObject:@"bt1"];
    bt.backgroundColor = [UIColor greenColor];
    
    Surface *ja = [surface1 getSurface:@"s1"];
    ja.box.backgroundColor = [UIColor magentaColor];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"text" : @"Hola mundo jajaaa!!!"}];
    [ja add:@"text" width:-1 heigth:35 key:@"label1" params:params controller:self];
    [ja add:@"text_field" width:-1 heigth:35 key:@"t1" params:params controller:self];
    [ja add:@"text_field" width:-1 heigth:35 key:@"t2" params:params controller:self];
    
    UILabel *label103 = (UILabel *)[ja getObject:@"label103"];
    label103.backgroundColor = [UIColor redColor];

    NSLog(@"aqui el boton jala bn chidonbgongo, texto== %@", texto.text);
}



// FUNCIONES DE DELEGADO DE TEXTFIELD
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",(long)textField.tag);

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}
/////////////

@end
