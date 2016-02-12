//
//  Launch.m
//  Surface
//
//  Created by Webchimp on 29/01/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Launch.h"
#import "MyScene.h"
#import "Sparrow.h"

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
    
    /*Sparrow *img = [[Sparrow alloc] init];
    [img loadImageWithName:@"header"];
    [img setWidthSprite:512];
    [img setTimer:5];
    [img run:NO];*/
    
    /*
    UIImage *test = [UIImage imageNamed:@"a"];
    CGImageRef temp = test.CGImage;
    CGImageRef top = CGImageCreateWithImageInRect(temp, CGRectMake(0, 0, test.size.width, test.size.height/2));
    UIImage *topp = [UIImage imageWithCGImage:top];
    CGImageRelease(top);
    
    UIImageView *la = [[UIImageView alloc] initWithImage:topp];
    la.frame = CGRectMake(100, 250, 100, 100);
    [self.view addSubview:la];
    

    CGImageRef bottom = CGImageCreateWithImageInRect(temp, CGRectMake(0, test.size.height/2, test.size.width, test.size.height/2));
    UIImage *bott = [UIImage imageWithCGImage:bottom];
    CGImageRelease(bottom);
    
    UIImageView *la1 = [[UIImageView alloc] initWithImage:bott];
    la1.frame = CGRectMake(370, 250, 100, 100);
    [self.view addSubview:la1];*/
    
    CGSize szsprite = CGSizeMake(136, 90);
    float sprite = 2;
    float offset_x = (sprite)*-szsprite.width;
    
    UIImage* mars = [UIImage imageNamed:@"carrito"];
    CGSize szimage = [mars size];
    NSLog(@"ancho %f", szimage.width);
    //CGImageRef q;
    UIGraphicsBeginImageContextWithOptions(szsprite, NO, 0);
    
    [mars drawAtPoint:CGPointMake(offset_x, 0)];
    
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *la = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, szsprite.width, szsprite.height)];
    la.image = im;
    [self.view addSubview:la];
    
    
    
    
    
    /*CGRect fromRect = CGRectMake(fromRect.origin.x * 100,
                          fromRect.origin.y * 1,
                          fromRect.size.width * sz.width,
                          fromRect.size.height * sz.height;
    CGImageRef imageRef = CGImageCreateWithImageInRect(q, fromRect);
    UIImage* crop = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIImageView *la = [[UIImageView alloc] initWithFrame:CGRectMake(250, 350, 100, 100)];
    la.image = im;*/
    
    //UIImageView *la = [[UIImageView alloc] initWithFrame:CGRectMake(200, 350, 200, 150)];
    //la.image = [UIImage imageNamed:@"header"];
    
    /*
    
    UIImage *image = [UIImage imageNamed:@"header"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // Get size of current image
    CGSize size = [image size];
    
    // Frame location in view to show original image
    [imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.view addSubview:imageView];
    
    // Create rectangle that represents a cropped image
    // from the middle of the existing image
    CGRect rect = CGRectMake(100, 100 ,
                             (100), (100));
    
    // Create bitmap image from original image data,
    // using rectangle to specify desired crop area
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    // Create and show the new image from bitmap data
    imageView = [[UIImageView alloc] initWithImage:img];
    [imageView setFrame:CGRectMake(0, 200, 100, 200)];
    [self.view addSubview:imageView];*/

    
   [self.view addSubview:la];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
