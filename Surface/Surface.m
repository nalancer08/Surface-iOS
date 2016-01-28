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
    
    [self getScreenSize];
    
}

- (id)initFullSize:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL)adisplay params:(NSString *)aparams {
    
    if ( self = [super init] ) {
        
        // Inizialize margins, padding, parent, childre, and screen sizes
        [self start];
        
        // Save the original values of the Surface
        self.width = self.screenWidth;
        self.height = self.screenHeight;
        
        self.general_grid = agrid; // Save grid
        self.vc = acontroller; // Save controller
        [self setSizes_width:self.screenWidth height:self.screenHeight]; // Save the new sizes in the original frame
        [self setOrigins_x:0 y:0]; // Save the new origins
        [self setPaddingsleft:20 top:20 right:20 bottom:20]; // Set in paddings
        
        // Inizialize box and porperty of the box
        self.box = [[UIView alloc] init];
        self.box.frame = self.general_frame;
        self.box.backgroundColor = [UIColor redColor];
        
        // Generate scroll
        [self generateScroll];
        
        // Check to display the Surface
        if ( adisplay ) {
            
            [acontroller.view addSubview:self.box];
        }
        
    }
    
    return self;
}

- (id)initWithSizeWidth:(float)awidth height:(float)aheight controller:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL)adisplay params:(NSString *)aparams {
    
    if ( self = [super init] ) {
       
        // Inizialize margins, padding, parent, childre, and screen sizes
        [self start];
        
        // Save the original values of the Surface
        self.width = awidth;
        self.height = aheight;
        
        self.general_grid = agrid; // Save grid
        self.vc = acontroller; // Save controller
        
        awidth = awidth != -1 ? awidth : self.screenWidth;
        aheight = aheight != -1 ? aheight : self.screenHeight;
        
        [self setSizes_width:awidth height:aheight]; // Save the new sizes in the original frame
        
        [self setOrigins_x:0 y:0]; // Save the new origins
        [self setPaddingsleft:20 top:20 right:20 bottom:20]; // Set paddings
        [self setMarginsleft:0 top:0 right:0 bottom:20]; // Set paddings
        
        self.box = [[UIView alloc] init];
        self.box.frame = self.general_frame;
        self.box.backgroundColor = [UIColor greenColor];
        
        // Generate scroll
        [self generateScroll];
        
        // Check to display the Surface
        if ( adisplay ) {
            
            [acontroller.view addSubview:self.box];
        }
        
    }
    
    return self;
}

- (id)initWithView:(UIView *)aview {
    
    if ( self = [self init] ) {
        
        // Inizialize margins, padding, parent, childre, and screen sizes
        [self start];
        
        self.box = aview;
        
        self.width = self.box.frame.size.width;
        self.height = self.box.frame.size.height;
        self.position_x = self.box.frame.origin.x;
        self.position_y = self.box.frame.origin.y;
        
        [self setSizes_width:self.width height:self.height];
        [self setOrigins_x:self.position_x y:self.position_y];
        
        [self setMarginsleft:0 top:0 right:0 bottom:20];
        
    }
    
    return self;
}

// CONTROL LAYOUTS

- (void)generateScroll {
    
    self.layout_x = self.padding.left;
    self.layout_y = self.padding.top;
    
    if ( [self.general_grid isEqualToString:@"horizontal"] ) {
        
        self.scroll = [[UIScrollView alloc] initWithFrame:self.box.bounds];
        self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.scroll.contentSize = CGSizeMake(0, self.scroll.frame.size.height);
        [self.box addSubview:self.scroll];
        
    } else if ( [self.general_grid isEqualToString:@"fluid"] ) {
        
        self.scroll = [[UIScrollView alloc] initWithFrame:self.box.bounds];
        self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, 0);
        [self.box addSubview:self.scroll];
    }
}

- (CGRect)frame:(float)awidth heigth:(float)aheigth {
    
    CGRect frame;

    awidth = awidth != -1 ? awidth : ( self.scroll.frame.size.width - ( self.padding.left + self.padding.right ) );
    aheigth = aheigth != -1 ? aheigth : ( self.scroll.frame.size.height - ( self.padding.top + self.padding.bottom ) );
    
    frame = CGRectMake(self.layout_x, self.layout_y, awidth, aheigth);
    
    return frame;
}

- (void)layout {
    
    self.layout_x = self.padding.left;
    self.layout_y = self.padding.top;
    
    if ( [self.general_grid isEqualToString:@"fluid"] ) {
    
        for ( NSString* key in self.children ) {
            
            Surface *Surf = [self.children valueForKey:key];
            self.layout_y += (Surf.margin.top + Surf.margin.bottom + Surf.padding.top + Surf.padding.bottom + Surf.height);
            
        }
    }

}

- (void)updateScroll {
    
    [self layout];
    self.scroll.contentSize = CGSizeMake(self.screenWidth, self.layout_y);
}

- (void)update {
    
    if ( self.parent == nil || self.parent == NULL ) {
        
        [self getScreenSize];
        self.box.frame = CGRectMake(self.position_x, self.position_y, self.screenWidth, self.screenHeight);
        [self generateScroll];
    }
}


// ADDS

- (void)add:(NSString *)object width:(float)awidth heigth:(float)aheigth key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller {
    
    NSArray *items = @[@"text", @"image", @"text_field"];
    NSInteger item = [items indexOfObject:object];
    
    UILabel *label;
    //UIImageView *image;
    [self layout];
    CGRect frame = [self frame:awidth heigth:aheigth];
    Surface *child;
    
    switch (item) {
        case 0:
            
            label = [[UILabel alloc] init];
            if ( [aparams objectForKey:@"text"] ) {
                
                [label setText:[aparams objectForKey:@"text"]];
                [label setBackgroundColor:[UIColor whiteColor]];
            }
            
            //if ( [aparams objectForKey:@"font"] ) {NSLog(@"hay font");} else {NSLog(@"no hay font");}
            
            label.frame = frame;
            
            child = [[Surface alloc] initWithView:label];
            child.parent = self;
            
            [self.children setObject:child forKey:akey];
            
            [self.scroll addSubview:child.box];
            
            break;
    }
    
    [self updateScroll];

}


// HELPERS

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

- (void)getScreenSize {
    
    self.screenRect = [[UIScreen mainScreen] bounds];
    self.screenWidth = self.screenRect.size.width;
    self.screenHeight = self.screenRect.size.height;
    NSLog(@"screen width = %f and heigth = %f", self.screenWidth, self.screenHeight);
    
}

@end
