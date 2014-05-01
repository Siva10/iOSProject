//
//  SignupViewController.m
//  test1team9
//
//  Created by student on 29/4/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController


@synthesize firstName,lastName,emailID,phone,password,buffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [phone resignFirstResponder];
    [emailID resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}

-(IBAction)cancel:(id)sender{
    
    [self performSegueWithIdentifier:@"CancelSegue" sender:self];
    
}

-(IBAction)signup:(id)sender{
    [emailID resignFirstResponder];
    [password resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [phone resignFirstResponder];
    [self connectJasonWS];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    firstName.delegate=self;
    lastName.delegate=self;
    phone.delegate=self;
    emailID.delegate=self;
    password.delegate=self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)connectJasonWS{
    self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.10.2.157/Events/Events.asmx/SaveMember?FName=%@&LName=%@&Email=%@&Phone=%@&Password=%@",firstName.text,lastName.text,emailID.text,phone.text,password.text]]] resume];
    NSLog(@"111111");
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [buffer appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
        NSLog(@"Done with bytes %d", [buffer length]);
        
        [self processResponse:buffer];
        
    }
    else
        NSLog(@"Error %@",[error userInfo]);
    
}
-(void)processResponse:(NSMutableData *)data{
    NSError *e = nil;
    
    if (data!=nil) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"%@",dataString);
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0 error:&e];
        // NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        NSLog(@"22222");
        
        for (NSDictionary *item in results) {
            // Get the title for each photo
            memberID= [item objectForKey:@"MemberID"];
            NSLog(@"333333");
            //[self.eventList addObject:(title.length > 0 ? title : @"Untitled")];
        }
    } else {
        
    }
    
    //NSLog(@"process response %d",eventList.count);
    //[self.tableView reloadData];
    
    
    
    if (memberID!=nil) {
        /* sqlite3_bind_text(insertStatement,1,[memberID UTF8String],-1,SQLITE_TRANSIENT);
         sqlite3_bind_text(insertStatement,2,[emailID.text UTF8String],-1,SQLITE_TRANSIENT);
         sqlite3_bind_text(insertStatement,3,[password.text UTF8String],-1,SQLITE_TRANSIENT);
         sqlite3_step(insertStatement) ;
         sqlite3_reset(insertStatement);
         sqlite3_clear_bindings(insertStatement);*/
        [self printMessage:@"Member registered successfully"];
        
    }
    else{
        [self printMessage:@"Enter values for all fields"];
        
    }
    
}

-(void) printMessage:(NSString *) email{
    UIAlertView *alertPopUp=[[UIAlertView alloc] initWithTitle:@"Alert" message:email delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertPopUp show];
    NSLog(@"The message is %@",emailID.text);
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
