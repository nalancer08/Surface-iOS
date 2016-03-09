//
//  Surface.m
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Surface.h"
#import "Puppeteer.h"

@implementation Surface

- (void)start {
  
    [self setPaddingsleft:0 top:0 right:0 bottom:0];
    [self setMarginsleft:0 top:0 right:0 bottom:0];
    
    self.parent = nil;
    self.divs = 0;
    self.div_height = 0;
    self.children = [[NSMutableDictionary alloc] init];
    
    [self getScreenSize];
    
}

-(void)startGrid {
    
    //Options for grid
    self.divs = (self.divs == 0 ) ? 3 : self.divs;
    self.separadores = self.divs - 1;
    self.div_height = (self.div_height) ? self.div_height : 120;
    //NSLog(@"alto del surfaceeee = %f", self.div_height);
    self.div_width = self.general_frame.size.width / self.divs;
    
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

- (id)initWithSizeWidth:(float)awidth height:(float)aheight controller:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL)adisplay params:(NSMutableDictionary *)aparams {
    
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
        
        [self checkParams:aparams];
        
        
        self.box = [[UIView alloc] init];
        self.box.frame = self.general_frame;
        self.box.backgroundColor = [UIColor greenColor];
        
        // Generate grid and scroll
        [self startGrid];
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
    
    } else if ( [self.general_grid isEqualToString:@"boxes"] ) {
        
        self.scroll = [[UIScrollView alloc] initWithFrame:self.box.bounds];
        self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.scroll.contentSize = CGSizeMake(0, 0);
        [self.box addSubview:self.scroll];
        
        [self setPaddingsleft:0 top:0 right:0 bottom:20]; // Set paddings
        [self setMarginsleft:0 top:0 right:0 bottom:20]; // Set paddings
        
    }
}

- (CGRect)frame:(float)awidth heigth:(float)aheigth {
    
    CGRect frame;
    
    if ( [self.general_grid isEqualToString:@"fluid"] ) {

        awidth = awidth != -1 ? awidth : ( self.scroll.frame.size.width - ( self.padding.left + self.padding.right ) );
        aheigth = aheigth != -1 ? aheigth : ( self.scroll.frame.size.height - ( self.padding.top + self.padding.bottom ) );
    
    } else if  ( [self.general_grid isEqualToString:@"boxes"] ) {
        
        awidth = awidth != -1 ? awidth : self.div_width;
        aheigth = aheigth != -1 ? aheigth : self.div_height;
        //NSLog(@"x = %f, Y = %f", self.layout_x, self.layout_y);
    }
    
    frame = CGRectMake(self.layout_x, self.layout_y, awidth, aheigth);
    //NSLog(@"SurfaceW = %f y SurfaceH = %f", awidth, aheigth);
    
    return frame;
}

- (void)layout {
    
    self.layout_x = self.padding.left;
    self.layout_y = self.padding.top;
    
    if ( [self.general_grid isEqualToString:@"fluid"] ) {
    //NSLog(@"hijos %@", self.children);
        for ( NSString* key in self.children ) {
            
            Surface *Surf = [self.children valueForKey:key];
            self.layout_y += (Surf.margin.top + Surf.margin.bottom + Surf.general_frame.size.height);
            
        }
        
    } else if ( [self.general_grid isEqualToString:@"boxes"] ) {
        
        self.div_width = self.box.bounds.size.width / self.divs;
        self.div_height = 35;
        //NSLog(@"caja ancho == %f", self.box.bounds.size.width);
        //NSLog(@"div ancho == %f", self.div_width);
        
        //NSLog(@"div size = %f", self.div_width);
        //self.div_size = CGSizeMake(self.div_width, self.div_height);
        //NSLog(@"hijos %@", self.children);
        self.used_divs = 0;
        
        for ( NSString* key in self.children ) {
            
            self.used_divs ++;
            Surface *Surf = [self.children valueForKey:key];
            
            //self.layout_y += (Surf.margin.top + Surf.margin.bottom + Surf.padding.top + Surf.padding.bottom + Surf.height);
            //NSLog(@"surf width fucking maldito == %f", Surf.width);
            
            self.layout_x +=  self.div_width;
            
            if ( self.used_divs == self.divs ) {
                //NSLog(@"used = %i y divs = %i", self.used_divs, self.divs);
                self.used_divs = 0;
                self.layout_x = self.padding.left;                
                self.layout_y += self.div_height;
            }
            
            //NSLog(@"layX = %f punto %i", self.layout_x, self.used_divs);
            //NSLog(@"layY = %f punto %i", self.layout_y, self.used_divs);
            //NSLog(@"LayX == %f", self.layout_x);
        }
        
    }

}

- (void)updateScroll {
    
    [self layout];
    self.scroll.contentSize = CGSizeMake(self.layout_x, self.layout_y);
    
    if ( [self.general_grid isEqualToString:@"boxes"] ) {
        self.scroll.contentSize = CGSizeMake(self.layout_x, self.layout_y + self.padding.bottom + self.padding.top + self.div_height);
    }
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
    
    if ( ![self checkItem:akey] ) {
        
        if ( [aparams objectForKey:@"position"] ) {
            
            NSString *position = [aparams objectForKey:@"position"];
            frame = [self setPosition:position frame:frame];
            
        }
        
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
                field.delegate = (self.vc != nil) ? self.vc : nil;
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
                
                if ( [aparams objectForKey:@"function"] && [aparams objectForKey:@"newClass"] ) {
                    
                    NSLog(@"clase nueva == %@", [aparams objectForKey:@"newClass"] );
                    SEL aSel = [[aparams objectForKey:@"function"] pointerValue];
                    [button addTarget:[[aparams objectForKey:@"newClass"] class] action:aSel forControlEvents:UIControlEventTouchUpInside];
                    
                } else if ( [aparams objectForKey:@"function"] ) {
                    SEL aSel = [[aparams objectForKey:@"function"] pointerValue];
                    [button addTarget:self.vc action:aSel forControlEvents:UIControlEventTouchUpInside];
                }
                
                if ( [aparams objectForKey:@"tag"] ) {
                    button.tag = self.used_divs;
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
    } else {
        NSLog(@"Ya existia un objeto con ese nombre");
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
        frame = [self setPosition:position frame:frame];
        
    }
    
    aview.frame = frame;
    
    child = [[Surface alloc] initWithView:aview];
    child.parent = self;
    
    child.width = width;
    child.height = heigth;
    
    [self.children setObject:child forKey:akey];
    
    [self.scroll addSubview:child.box];
    
}

- (void)addSurface:(Surface *)surface key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller {

    [self layout];
    CGRect frame = [self frame:surface.width heigth:surface.height];
    Surface *child;
    child = surface;
    
    if ( [aparams objectForKey:@"position"] ) {
        
        NSString *position = [aparams objectForKey:@"position"];
        frame = [self setPosition:position frame:frame];
        
    }
    
    child.box.frame = frame;
    
    //child.width = child.box.frame.size.width;
    //child.height = child.box.frame.size.height;
    child.position_x = child.box.frame.origin.x;
    child.position_y = child.box.frame.origin.y;
    
    [child setSizes_width:frame.size.width height:frame.size.height];
    [child setOrigins_x:child.position_x y:child.position_y];
    
    [child setMarginsleft:0 top:0 right:0 bottom:20];
    [child setPaddingsleft:20 top:20 right:20 bottom:20]; // Set paddings
    [child generateScroll];
    
    child.parent = self;
   
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
    CGRect new;
    
    NSArray *items = @[@"center", @"top", @"bottom"];
    NSInteger item = [items indexOfObject:position];
    
    switch (item) {
        case 0:
            
            x = ( self.box.bounds.size.width - aframe.size.width ) / 2;
            y = ( self.box.bounds.size.height - aframe.size.height ) / 2;
            
            new = CGRectMake(x, y, aframe.size.width, aframe.size.height);
            
        break;
            
        case 2:
            
            x = 0;
            y = ( self.box.bounds.size.height - aframe.size.height );
            NSLog(@"caja alto == %f  Y  elemento alto == %f", self.box.bounds.size.height, aframe.size.height );
            new = CGRectMake(x, y, aframe.size.width, aframe.size.height);
            
        break;
    }
    
     NSLog(@"x== %f and y== %f", x, y);
    return new;
}

- (UIView *)getObject:(NSString *)object {
    
    UIView *view;
    Surface *conteiner = [self.children objectForKey:object];
    view = conteiner.box;
    return view;
}

- (Surface *)getSurface:(NSString *)object {
    Surface *conteiner = [self.children objectForKey:object];
    return conteiner;

}

- (void)checkParams:(NSMutableDictionary *)params {
    
    if ( [params objectForKey:@"colums"] ) {
        
        NSLog(@"divs viejos === %i", self.divs);
        NSLog(@"divs nuevos === %d", [[params objectForKey:@"colums"] intValue]);
        
        self.divs = [[params objectForKey:@"colums"] intValue];
    }
    
    if ( [params objectForKey:@"height_element"] ) {
        
        self.div_height = [[params objectForKey:@"height_element"] floatValue];
    }
}

- (BOOL)checkItem:(NSString *)object {
    
    if ( self.children ) {
        if ( [self.children objectForKey:object] ) {
            return TRUE;
        } else {
            return FALSE;
        }
    } else {
        return  FALSE;
    }
}

- (void)modifiedParams:(NSMutableDictionary *)params {
    
    [self checkParams:params];
}

- (void)present {
    //NSLog(@"cambiandoooo");
    //self.box.backgroundColor = [UIColor redColor];
    [self.vc.view addSubview:self.box];
}

@end
