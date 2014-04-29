//
//  SignupViewController.h
//  test1team9
//
//  Created by student on 29/4/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController<UITextFieldDelegate>{
    UITextField *name;
    UITextField *emailID;
    UITextField *password;
    UITextField *phone;
}

@property (strong,nonatomic) IBOutlet UITextField *name;
@property (strong,nonatomic) IBOutlet UITextField *emailID;
@property (strong,nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) IBOutlet UITextField *phone;

-(IBAction)signup:(id)sender;
-(void)printMessage:(NSString *) email;
@end
