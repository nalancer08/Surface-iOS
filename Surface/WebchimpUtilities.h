//
//  WebchimpUtilities.h
//  Surface
//
//  Created by Webchimp on 09/03/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebchimpUtilities : UIView <UIAlertViewDelegate>

+ (void)alerts:(UIViewController *)controller Title:(NSString *)title Message:(NSString *)message Style:(NSString *)style;

+ (UIColor *)htmlColor:(NSString *)hex;

@end
