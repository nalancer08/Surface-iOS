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
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) CGSize size;
@property (nonatomic) float single;
@property (nonatomic) int parts;
@property (nonatomic) int counter;
@property (nonatomic) float second;
@property (nonatomic) float seconds;
@property (retain, nonatomic) NSString *recicle;
@property (retain, nonatomic) NSTimer *time;

-(void)loadImageWithName:(NSString *)name;
-(void)setWidthSprite:(float)single;
-(void)setTimer:(float)second;
-(void)run:(BOOL)recicle;
-(void)display;

@end
