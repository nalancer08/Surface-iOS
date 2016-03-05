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
        //self.box.backgroundColor = [UIColor redColor];
        self.box.backgroundColor = [UIColor colorWithRed:0.717 green:0.97 blue:0.87 alpha:1.0];
        //self.box.backgroundColor = [UIColor clearColor];
        //self.box.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cheeseburger"]];
        
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
    NSLog(@"SurfaceW = %f y SurfaceH = %f", awidth, aheigth);
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
        [self updateScroll];
        
    } else {
        
        CGRect frame = [self frame:self.width heigth:self.height];
        self.frame = CGRectMake(self.general_frame.origin.x, self.general_frame.origin.y, frame.size.width, frame.size.height);
    }
    
    for( NSString* key in self.children ) {
        
        Surface *surf = [self.children valueForKey:key];
        [surf update];
    }
}


// ADDS

- (void)add:(NSString *)object width:(float)awidth heigth:(float)aheigth key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller {
    
    NSArray *items = @[@"text", @"image", @"text_field", @"button"];
    NSInteger item = [items indexOfObject:object];
    
    UILabel *label;
    UIImageView *image;
    UITextField *field;
    UIButton *button;
    
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
            
            child.width = awidth;
            child.height = aheigth;
            
            [self.children setObject:child forKey:akey];
            
            [self.scroll addSubview:child.box];
            
            break;
            
        case 1:
            
            image = [[UIImageView alloc] init];
            
            if ( [aparams objectForKey:@"name"] && [[aparams objectForKey:@"name"] length ] != 0 ) {
                
                NSString *name = [aparams objectForKey:@"name"];
                image.image = [UIImage imageNamed:name];
                
            }
            
            if ( [aparams objectForKey:@"position"] ) {
                
                NSString *position = [aparams objectForKey:@"position"];
                if ( [position isEqualToString:@"center"] ) {
                    frame = [self setPosition:position frame:frame];
                }
                
                
            }
            
            image.frame = frame;
            child = [[Surface alloc] initWithView:image];
            child.parent = self;
            
            child.width = awidth;
            child.height = aheigth;
            
            [self.children setObject:child forKey:akey];
            [self.scroll addSubview:child.box];
            
            break;
            
        case 2:
            field = [[UITextField alloc] init];
            field.delegate = self.vc;
            field.backgroundColor = [UIColor blueColor];
            
            field.frame = frame;
            child = [[Surface alloc] initWithView:field];
            child.parent = self;
            
            child.width = awidth;
            child.height = aheigth;
            
            [self.children setObject:child forKey:akey];
            [self.scroll addSubview:child.box];
            
            break;
        
        case 3:
            
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"boton chido" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            
            if ( [aparams objectForKey:@"function"] ) {
                
                SEL aSel = [[aparams objectForKey:@"function"] pointerValue];
                [button addTarget:self.vc action:aSel forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            button.frame = frame;
            child = [[Surface alloc] initWithView:button];
            child.parent = self;
            
            child.width = awidth;
            child.height = aheigth;
            
            [self.children setObject:child forKey:akey];
            [self.scroll addSubview:child.box];
            break;
    }
    
    [self updateScroll];

}

- (void)addCustom:(UIView *)aview key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller {
    
    float width = aview.frame.size.width;
    float heigth = aview.frame.size.height;
    [self layout];
    CGRect frame = [self frame:width heigth:heigth];
    Surface *child;
    
    if ( [aparams objectForKey:@"position"] ) {
        
        NSString *position = [aparams objectForKey:@"position"];
        if ( [position isEqualToString:@"center"] ) {
            frame = [self setPosition:position frame:frame];
        }
        
        
    }
    
    aview.frame = frame;
    
    child = [[Surface alloc] initWithView:aview];
    child.parent = self;
    
    child.width = width;
    child.height = heigth;
    
    [self.children setObject:child forKey:akey];
    
    [self.scroll addSubview:child.box];
    
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
    //NSLog(@"screen width = %f and heigth = %f", self.screenWidth, self.screenHeight);
    
}

- (CGRect)setPosition:(NSString *)position frame:(CGRect)aframe {

    float x;
    float y;
    
    x = ( self.box.bounds.size.width - aframe.size.width ) / 2;
    y = ( self.box.bounds.size.height - aframe.size.height ) / 2;
    
    CGRect new = CGRectMake(x, y, aframe.size.width, aframe.size.height);
     NSLog(@"x== %f and y== %f", x, y);
    return new;
}

- (UIView *)getObject:(NSString *)object {
    
    UIView *view;
    Surface *conteiner = [self.children objectForKey:object];
    view = conteiner.box;
    return view;
}

- (void)present {
    NSLog(@"cambiandoooo");
    //self.box.backgroundColor = [UIColor redColor];
    [self.vc.view addSubview:self.box];
}

@end
