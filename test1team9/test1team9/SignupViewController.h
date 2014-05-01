//
//  SignupViewController.h
//  test1team9
//
//  Created by student on 29/4/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController<UITextFieldDelegate>{
    UITextField *firstName;
    UITextField *lastName;
    UITextField *emailID;
    UITextField *password;
    UITextField *phone;
    NSString *memberID;
}

@property (strong,nonatomic) IBOutlet UITextField *firstName;
@property (strong,nonatomic) IBOutlet UITextField *lastName;
@property (strong,nonatomic) IBOutlet UITextField *emailID;
@property (strong,nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) NSMutableData *buffer;

-(IBAction)signup:(id)sender;
-(IBAction)cancel:(id)sender;
//-(void)printMessage:(NSString *) email;
@end
