//
//  Buscador.h
//  Surface
//
//  Created by Webchimp on 18/02/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"

@interface Buscador : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *data;
    NSMutableArray *companyData;
    NSDictionary *json;
    NSArray *js;
    
    NSMutableArray *muary_Interest_Main;
    NSMutableArray *muary_Interest_Sub;
    int int_TextFieldTag;
    //UITableView *tbl_Search;
}
@property (retain, nonatomic) IBOutlet MPGTextField *buscador;
@property (retain, nonatomic) UIButton *nameStatus;
@property (retain, nonatomic) UITableView *tbl_Search;
@property (retain, nonatomic) UITextField *tx1;
@end
