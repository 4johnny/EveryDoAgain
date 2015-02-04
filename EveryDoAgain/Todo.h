//
//  Todo.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-04.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * descriptionText;
@property (nonatomic, retain) NSString * titleText;
@property (nonatomic, retain) NSNumber * priorityNumber;
@property (nonatomic, retain) NSNumber * completed;

@end
