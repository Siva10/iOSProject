//
//  EventModule.m
//  test1team9
//
//  Created by student on 28/4/14.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import "EventModule.h"

@implementation EventModule

@synthesize eventArray;

-(id) init{
    self = [super init];
    eventArray = [[NSMutableArray alloc] initWithObjects:@"iss", nil];
    
    return self;
}

@end
