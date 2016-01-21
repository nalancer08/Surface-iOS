//
//  Surface.m
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Surface.h"

@implementation Surface

- (void)start {
  
    [self setPaddingsleft:0 top:0 right:0 bottom:0];
    [self setMarginsleft:0 top:0 right:0 bottom:0];
    
    self.parent = nil;
    self.children = [[NSMutableDictionary alloc] init];
    
    self.screenRect = [[UIScreen mainScreen] bounds];
    self.screenWidth = self.screenRect.size.width;
    self.screenHeight = self.screenRect.size.height;
    
}

- (id)initFullSize:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL)adisplay params:(NSString *)aparams {
    
    if ( self = [super init] ) {
        
        // Inizialize margins, padding, parent, childre, amd screen sizes
        [self start];
        
        // Save the original values of the Surface
        self.width = self.screenWidth;
        self.height = self.screenHeight;
        
        self.general_grid = agrid; // Save grid
        self.vc = acontroller; // Save controller
        [self setSizes_width:self.screenWidth height:self.screenHeight]; // Save the new sizes in the original frame
        [self setOrigins_x:0 y:0]; // Save the nwe origins
        [self setPaddingsleft:20 top:20 right:20 bottom:20]; // Set in paddings
        
        // Inizialize box and porperty of the box
        self.box = [[UIView alloc] init];
        self.box.frame = self.general_frame;
        self.box.backgroundColor = [UIColor redColor];
        
        if ( adisplay ) {
            
            [acontroller.view addSubview:self.box];
        }
        
    }
    
    
    return self;
}

- (void)setMarginsleft:(float)aleft top:(float)atop right:(float)aright bottom:(float)abottom {
    
    CGValues margins = self.margin;
    margins.left = aleft;
    margins.top = atop;
    margins.right = aright;
    margins.bottom = abottom;
    self.margin = margins;
}

- (void)setPaddingsleft:(float)aleft top:(float)atop right:(float)aright bottom:(float)abottom {
    
    CGValues paddings = self.padding;
    paddings.left = aleft;
    paddings.top = atop;
    paddings.right = aright;
    paddings.bottom = abottom;
    self.padding = paddings;
}

- (void)setSizes_width:(float)awidth height:(float)aheight {
    
    CGRect frame = self.general_frame;
    frame.size.width = awidth;
    frame.size.height = aheight;
    self.general_frame = frame;
}

- (void)setOrigins_x:(float)ax y:(float)ay {
    
    CGRect frame = self.general_frame;
    frame.origin.x = ax;
    frame.origin.y = ay;
    self.general_frame = frame;
}


@end
