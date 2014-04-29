//
//  LoginViewController.h
//  test1team9
//
//  Created by student on 4/29/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong,nonatomic) IBOutlet UITextField *emailID;
@property (strong,nonatomic) IBOutlet UITextField *password;

-(IBAction)login:(id)sender;
-(IBAction)signup:(id)sender;
-(void)printMessage:(NSString *) name;

@end
