//
//  LoginViewController.h
//  test1team9
//
//  Created by student on 4/29/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLSessionDataDelegate>{
    UITextField *emailID;
    UITextField *password;
    NSString *memberID;
    NSString *lastName;
    NSString *firstName;
    NSString *phone;
    NSString *email;
    NSString *pwd;

    NSString *databasePath;
    sqlite3 *memberDB;
    sqlite3_stmt *insertStatement;
    sqlite3_stmt *selectStatement;

}
- (IBAction)loginAction:(id)sender;
@property (strong,nonatomic) IBOutlet UITextField *emailID;
@property (strong,nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) NSMutableData *buffer;

-(IBAction)gotoSignup:(id)sender;

//-(void)printMessage:(NSString *) email;
//-(IBAction)createMember;
//-(IBAction)findMember;

@end
