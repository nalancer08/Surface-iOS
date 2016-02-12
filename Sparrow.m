//
//  Sparrow.m
//  Surface
//
//  Created by Webchimp on 10/02/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Sparrow.h"

@implementation Sparrow

- (void)loadImageWithName:(NSString *)name In:(UIViewController *)controller {
    
    self.img = [UIImage imageNamed:name];
    self.size_image = self.img.size;
    self.sprite = 0;
    self.parent = controller;
    [self initImage];
    
}

-(void)setWidthSprite:(float)width Height:(float)height {
    
    self.size_sprite = CGSizeMake(width, height);
    self.parts_x = self.size_image.width / self.size_sprite.width;
    self.parts_y = self.size_image.height / self.size_sprite.height;
    
    NSLog(@"parts %i y ancho de: %f", self.parts_x, self.size_image.width);
    
}

-(void)setTimer:(float)second {
    
    self.second = second;
    self.seconds = self.second * self.parts_x;
    
}

-(void)run:(BOOL)recicle {
    
    self.recicle = recicle;
    self.time = [NSTimer scheduledTimerWithTimeInterval:self.second target:self selector:@selector(display) userInfo:nil repeats:NO];
}

-(void)initImage {
    
    self.image = [[UIImageView alloc] init];
    self.image.frame = self.frame;
    [self.parent.view addSubview:self.image];
    NSLog(@"x = %f, y = %f, w = %f, h =%f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)display {
    
    if( self.sprite < self.parts_x ) {
        
        
        // Process the image
        
        self.offset_x = ( (self.sprite)*(-self.size_sprite.width) );
        UIGraphicsBeginImageContextWithOptions(self.size_sprite, NO, 0);
        [self.img drawAtPoint:CGPointMake(self.offset_x, 0)];
        
        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.image.image = im;
        
        NSLog(@"conter = %i", self.sprite);
        self.sprite++;
        [self run:YES];
        
        
    } else {
        
        if(self.recicle == YES) {
            
            self.sprite = 0;
            [self run:YES];
        
        } else {
            [self.time invalidate];
            self.time = nil;
        }
    }
    
}

@end
