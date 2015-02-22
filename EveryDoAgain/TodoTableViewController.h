//
//  MasterViewController.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-03.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


#
# pragma mark - Interface
#

@interface TodoTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

#
# pragma mark Core Data Properties
#

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

