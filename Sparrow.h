//
//  Sparrow.h
//  Surface
//
//  Created by Webchimp on 10/02/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Sparrow : UIView

@property (retain, nonatomic) UIImage *img;
@property (nonatomic) CGSize size_sprite;
@property (nonatomic) CGSize size_image;

@property (nonatomic) int sprite;
@property (nonatomic) float offset_x;

//@property (nonatomic) float width;
//@property (nonatomic) float height;
//@property (nonatomic) CGSize size;

@property (nonatomic) float single;

@property (nonatomic) int parts_x;
@property (nonatomic) int parts_y;

@property (nonatomic) int counter;
@property (nonatomic) float second;
@property (nonatomic) float seconds;
@property (nonatomic) BOOL recicle;
@property (retain, nonatomic) NSTimer *time;

@property (retain, nonatomic) UIImageView *image;
@property (retain, nonatomic) UIViewController *parent;

@property (nonatomic) SEL function;

-(void)loadImageWithName:(NSString *)name In:(UIViewController *)controller;
-(void)setWidthSprite:(float)width Height:(float)height;
-(void)setTimer:(float)second withRepeat:(BOOL)repeat;
-(void)run;
-(void)display;
-(void)initImage;
-(void)end:(SEL)func fromObject:(id)object;
-(void)endAnimation:(SEL)func fromObject:(id)object;

@end
