//
//  DetailViewController.h
//  test1team9
//
//  Created by student on 28/4/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
