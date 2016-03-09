//
//  Surface.h
//  Surface
//
//  Created by Erick on 1/20/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

struct CGValues {
    
    float left;
    float top;
    float right;
    float bottom;
    
}; typedef struct CGValues CGValues;

@interface Surface : UIView

    //////////////////////////////////////// Propiedades //////////////////////////////////////////

    // Propiedades variables de sizes and origins
    @property (nonatomic) float height;
    @property (nonatomic) float width;
    @property (nonatomic) float position_x;
    @property (nonatomic) float position_y;

    @property (nonatomic) float layout_x;
    @property (nonatomic) float layout_y;

    // Size screen
    @property (nonatomic) CGRect screenRect;
    @property (nonatomic) CGFloat screenWidth;
    @property (nonatomic) CGFloat screenHeight;

    // Propiedades intrinsecas del Surface
    @property (retain, nonatomic) Surface *parent;
    @property (retain, nonatomic) NSMutableDictionary *children;

    @property (nonatomic, assign) CGValues margin;
    @property (nonatomic, assign) CGValues padding;

    @property (nonatomic) CGRect general_frame;
    @property (nonatomic, retain) UIViewController *vc;

    // Box y Scroll
    @property (nonatomic, retain)UIView *box;
    @property (strong,nonatomic) UIScrollView *scroll;

    // Grid
    @property (retain, nonatomic) NSString *general_grid;

    // Porpertys for advanced grids
    @property (nonatomic) int divs;
    @property (nonatomic) int separadores;
    @property (nonatomic) CGSize div_size;
    @property (nonatomic) int used_divs;
    @property (nonatomic) float div_width;
    @property (nonatomic) float div_height;
    @property (nonatomic) CGSize box_size;

    @property (nonatomic) int current_div;


    ////////////////////////////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////// Metodos /////////////////////////////////////////

    // Constructors & Constructores //
    - (void)start;
    - (void)startGrid;
    - (id)initFullSize:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL )adisplay params:(NSString *)aparams;
    - (id)initWithSizeWidth:(float)awidth height:(float)aheight controller:(UIViewController *)acontroller grid:(NSString *)agrid display:(BOOL)adisplay params:(NSMutableDictionary *)aparams;
    - (id)initWithView:(UIView *)aview;

    // Frame Values
    - (void)setMarginsleft:(float)aleft top:(float)atop right:(float)aright bottom:(float)abottom;
    - (void)setPaddingsleft:(float)aleft top:(float)atop right:(float)aright bottom:(float)abottom;
    - (void)setOrigins_x:(float)ax y:(float)ay;
    - (void)setSizes_width:(float)awidth height:(float)aheight;

    - (void)add:(NSString *)object width:(float)awidth heigth:(float)aheigth key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller;

    - (void)addCustom:(UIView *)aview key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller;

    - (void)addSurface:(Surface *)surface key:(NSString *)akey params:(NSMutableDictionary *)aparams controller:(UIViewController *)acontroller;
    // Scroll
    - (void)generateScroll;

    - (CGRect)frame:(float)awidth heigth:(float)aheigth;

    - (void)layout;

    - (void)updateScroll;

    - (void)update;

    ///////////////////////////////////////////////////////////////////////////////////////////////

    - (void)getScreenSize;
    - (void)present;
    - (UIView *)getObject:(NSString *)object;
    - (Surface *)getSurface:(NSString *)object;

    - (BOOL)checkItem:(NSString *)object;
    - (void)checkParams:(NSMutableDictionary *)params;
- (void)modifiedParams:(NSMutableDictionary *)params;
    - (void)checkCols:(NSString *)col;


@end
