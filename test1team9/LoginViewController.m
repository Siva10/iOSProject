//
//  LoginViewController.m
//  test1team9
//
//  Created by student on 4/29/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
@interface LoginViewController ()



@end

@implementation LoginViewController
@synthesize emailID,password,buffer;


/*
-(void) prepareStatement{
    NSString *sqlString;
    const char *sql_stmt;
    // Prepare insert SQL statement
    sqlString =[NSString stringWithFormat:@"Insert into Members(email,pwd) values (?,?,?)"];
    sql_stmt =[sqlString UTF8String];
    sqlite3_prepare_v2(memberDB, sql_stmt, -1, &insertStatement, NULL);
    NSLog(@"hhhhh");

    // Prepare select SQL statement
    sqlString =[NSString stringWithFormat:@"select email,pwd from  where memberID=?"];
    sql_stmt =[sqlString UTF8String];
    sqlite3_prepare_v2(memberDB, sql_stmt, -1, &selectStatement, NULL);
}



*/


-(IBAction)gotoSignup:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     SignupViewController *signVC = (SignupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"signVC"];
    [self presentViewController:signVC  animated:YES completion:nil];
    //[self performSegueWithIdentifier:@"SignupSegue" sender:nil];

}



-(void) printMessage:(NSString *) email{
    UIAlertView *alertPopUp=[[UIAlertView alloc] initWithTitle:@"Alert" message:email delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertPopUp show];
    NSLog(@"The message is %@",emailID.text);


}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    emailID.delegate=self;
    password.delegate=self;
   
    /*
    NSString *docsDir;
    docsDir =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath =[[NSString alloc ]initWithString:[docsDir stringByAppendingPathComponent:@"members.sqlite"]];
    const char *dbpath=[databasePath UTF8String];
    
    if(sqlite3_open(dbpath,&memberDB)==SQLITE_OK){
        const char *sql_stmt="CREATE TABLE IF NOT EXISTS MEMBERS (MEMBER ID INTEGER PRIMARY KEY AUTOINCREMENT,EMAILID TEXT,PASSWORD TEXT)";
        sqlite3_exec(memberDB, sql_stmt, NULL, NULL, NULL);
        NSLog(@"gggggg");
    }
    [self prepareStatement];
    */
     }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [emailID resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}

-(void) viewDidAppear{
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    email=[prefs stringForKey:@"email"];
    emailID.text=email;
   
    pwd=[prefs stringForKey:@"pwd"];
    password.text=pwd;

}

-(void)connectJasonWS{
      self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.10.2.157/Events/Events.asmx/Login?Email=%@&Password=%@",emailID.text,password.text]]] resume];
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
        [self performSegueWithIdentifier:@"LoginSuccessSegue" sender:self];
        
    }
    else{
        [self printMessage:@"Incorrect emailID or password"];
        
    }

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

- (IBAction)loginAction:(id)sender {
    [emailID resignFirstResponder];
    [password resignFirstResponder];
    email=emailID.text;
    pwd=password.text;
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    [prefs setObject:email forKey:@"email"];
    [prefs setObject:pwd forKey:@"pwd"];
    //BOOL result=TRUE;
    [self connectJasonWS];
}
@end
