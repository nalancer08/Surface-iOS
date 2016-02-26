//
//  Launch.h
//  Surface
//
//  Created by Webchimp on 29/01/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Surface.h"

@interface Launch : UIViewController {
    NSMutableArray *data;
    NSMutableArray *companyData;
    NSDictionary *json;
    NSArray *js;
}

@property (weak, nonatomic) NSUserDefaults *data1;

@end
