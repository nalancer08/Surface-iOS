//
//  Sparrow.m
//  Surface
//
//  Created by Webchimp on 10/02/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Sparrow.h"

@implementation Sparrow

- (void)loadImageWithName:(NSString *)name {
    
    self.img = [UIImage imageNamed:name];
    self.size = self.img.size;
    self.width = self.img.size.width;
    self.height = self.img.size.height;
    self.counter = 0;
    self.image = [[UIImageView alloc] init];
    
    NSLog(@"ancho = %f, alto= %f", self.width, self.height);
    
}

-(void)setWidthSprite:(float)single {
    
    self.parts = self.width / single;
    NSLog(@"parts %i", self.parts);
    
}

-(void)setTimer:(float)second {
    
    self.second = second;
    self.seconds = self.second * self.parts;
    
}

-(void)run:(BOOL)recicle {
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:self.second target:self selector:@selector(display) userInfo:nil repeats:NO];
}

-(void)display {
    
    if( self.counter < self.parts ) {
        
        NSLog(@"conter = %i", self.counter);
        self.counter++;
        [self run:NO];
        
        
    } else {
        
        [self.time invalidate];
        self.time = nil;
    }
    
}

@end
