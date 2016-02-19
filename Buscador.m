//
//  Buscador.m
//  Surface
//
//  Created by Webchimp on 18/02/16.
//  Copyright © 2016 Erick. All rights reserved.
//

#import "Buscador.h"
#import "AFNetworking.h"

@interface Buscador ()

@end

@implementation Buscador

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithRed:0.718 green:0.976 blue:0.871 alpha:1];
    [self.view setAlpha:1];
    [UIView animateWithDuration:.65 delay:0 options:UIViewAnimationCurveEaseOut animations:^{ [self.view setAlpha:1]; }completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *la = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 200, 200)];
    la.backgroundColor = [UIColor redColor];
    [self.view addSubview:la];
    
    self.tx1 = [[UITextField alloc] init];
    self.tx1.frame = CGRectMake(30, 30, 240, 35);
    self.tx1.delegate = self;
    [self.view addSubview:self.tx1];
    
    self.tx1.layer.cornerRadius=4.0f;
    self.tx1.layer.masksToBounds=YES;
    self.tx1.layer.borderWidth= 1.0f;
    //self.tx1.layer.borderColor = [UIColor blueColor];
    
    self.tx1.borderStyle = UITextBorderStyleRoundedRect;
    self.tx1.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.tx1.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.tx1.backgroundColor=[UIColor clearColor];
    [self.tx1 setTextAlignment:NSTextAlignmentLeft];
    self.tx1.returnKeyType = UIReturnKeyDone;
    self.tx1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    

    muary_Interest_Main = [[NSMutableArray alloc]initWithObjects:@"Cricket",@"Dancing",@"Painting",@"Swiming",@"guitar",@"movie",@"boxing",@"drum",@"hockey",@"chessing",@"gamming",
                           @"hunting",@"killing",@"shoping",@"jamm"@"zooming", @"dado", @"dedo", @"dinosaurio", @"delfin", @"dass", @"dorito", @"danonino", @"dam", @"dash", nil];
    muary_Interest_Sub = [[NSMutableArray alloc]init];
    
    
    _tbl_Search = [[UITableView alloc] initWithFrame:
                  CGRectMake(4, 200, 320, 120) style:UITableViewStylePlain];
    _tbl_Search.delegate = self;
    _tbl_Search.dataSource = self;
    _tbl_Search.scrollEnabled = YES;
    
    [_tbl_Search registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    [self.view addSubview:_tbl_Search];
    
    
    [_tbl_Search setHidden:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [muary_Interest_Sub count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        ;
    }
    cell.textLabel.text = [muary_Interest_Sub objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if(int_TextFieldTag == 1)
    {
        _tx1.text=[muary_Interest_Sub objectAtIndex:indexPath.row];
        
    }
    else if(int_TextFieldTag == 2)
    {
        _tx1.text=[muary_Interest_Sub objectAtIndex:indexPath.row];
    }
    else if(int_TextFieldTag == 3)
    {
        _tx1.text=[muary_Interest_Sub objectAtIndex:indexPath.row];
    }
    else if(int_TextFieldTag == 4)
    {
        _tx1.text=[muary_Interest_Sub objectAtIndex:indexPath.row];
    } 
    else 
    { 
        _tx1.text=[muary_Interest_Sub objectAtIndex:indexPath.row];
    } 
    
}
//////////////////


//*****************//
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%ld",(long)textField.tag);
    int_TextFieldTag = textField.tag;
    
    [self searchText:textField replacementString:@"Begin"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    _tbl_Search.hidden = TRUE;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _tbl_Search.hidden = TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self searchText:textField replacementString:string];
    return YES; 
}
//****************//


-(void) searchText:(UITextField *)textField replacementString:(NSString *)string
{
    
    if(int_TextFieldTag == 1)
    {
        _tbl_Search.frame = CGRectMake(4, 200, 320, 120);
        
    }
    else if(int_TextFieldTag == 2)
    {
        _tbl_Search.frame = CGRectMake(4, 248, 320, 120);
    }
    else if(int_TextFieldTag == 3)
    {
        _tbl_Search.frame = CGRectMake(4, 268, 320, 120);
    }
    else if(int_TextFieldTag == 4)
    {
        _tbl_Search.frame = CGRectMake(4, 268, 320, 120);
    }
    else
    {
        _tbl_Search.frame = CGRectMake(4, 268, 320, 120);
    }
    
    
    
    NSString *str_Search_String=[NSString stringWithFormat:@"%@",textField.text];
    if([string isEqualToString:@"Begin"])
        str_Search_String=[NSString stringWithFormat:@"%@",textField.text];
    else if([string isEqualToString:@""])
        str_Search_String = [str_Search_String substringToIndex:[str_Search_String length] - 1];
    else
        str_Search_String=[str_Search_String stringByAppendingString:string];
    
    muary_Interest_Sub=[[NSMutableArray alloc] init];
    if(str_Search_String.length>0)
    {
        NSInteger counter = 0;
        for(NSString *name in muary_Interest_Main)
        {
            NSRange r = [name rangeOfString:str_Search_String options:NSCaseInsensitiveSearch];
            if(r.length>0)
            {
                [muary_Interest_Sub addObject:name];
            }
            
            counter++;
            
        }
        
        if (muary_Interest_Sub.count > 0)
        {
            NSLog(@"%@",muary_Interest_Sub);
            _tbl_Search.hidden = FALSE;
            [self.tbl_Search reloadData];
        }
        else
        {
            _tbl_Search.hidden = TRUE;
        }
        
        
        
    }
    else
    {
        [_tbl_Search setHidden:TRUE];
        
    }
    
}

@end
