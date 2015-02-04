//
//  MasterViewController.m
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-03.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


#
# pragma mark - Interface
#


@interface MasterViewController ()

@end


#
# pragma mark - Implementation
#


@implementation MasterViewController


#
# pragma mark NSObject(UINibLoadingAdditions)
#


- (void)awakeFromNib {
	[super awakeFromNib];
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		
		self.clearsSelectionOnViewWillAppear = NO;
		self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
}


#
# pragma mark UIViewController
#


- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	
	// Dispose of any resources that can be recreated.
	
}


#
# pragma mark Segues
#


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
		
		// Inject Core Data Managed Object at selected row into Detail View Controller
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
		UINavigationController* detailNavigationController = segue.destinationViewController;
		DetailViewController *detailViewController = (DetailViewController *)detailNavigationController.topViewController;
		detailViewController.detailItem = managedObject;
		detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
		detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
	}
}


#pragma mark <UITableViewDataSource>


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return self.fetchedResultsController.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
	
	return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Return NO if you do not want the specified item to be editable.
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		NSManagedObjectContext *moc = self.fetchedResultsController.managedObjectContext;
		[moc deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		NSError *error = nil;
		if ([moc save:&error]) return;
			
		// TODO: Replace this with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, error.userInfo);
		abort();
	}
}


#
# pragma mark <NSFetchedResultsControllerDelegate>
#


- (NSFetchedResultsController *)fetchedResultsController {
	
	if (_fetchedResultsController) return _fetchedResultsController;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
	[fetchRequest setSortDescriptors:@[sortDescriptor]];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
	aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	NSError *error = nil;
	if ([self.fetchedResultsController performFetch:&error]) return _fetchedResultsController;
	
	// TODO: Replace this with code to handle the error appropriately.
	// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	NSLog(@"Unresolved error %@, %@", error, error.userInfo);
	abort();
	
	return _fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type {
	
	switch (type) {
			
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		default:
			return;
	}
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
	
	UITableView *tableView = self.tableView;
	
	switch (type) {
			
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	
	[self.tableView endUpdates];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 
	// In the simplest, most efficient, case, reload the table view.
	[self.tableView reloadData];
 }
 */


#
# pragma mark Action Handlers
#


- (void)insertNewObject:(id)sender {
	
	// Insert new Core Data Managed Object into Managed Object Context
	NSManagedObjectContext *moc = self.fetchedResultsController.managedObjectContext;
	NSEntityDescription *entity = self.fetchedResultsController.fetchRequest.entity;
	
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:entity.name inManagedObjectContext:moc];
	
	// If appropriate, configure the new managed object
	// Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template
	[newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
	
	// Save the context
	NSError *error = nil;
	if ([moc save:&error]) return;
	
	// TODO: Replace this with code to handle the error appropriately.
	// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	abort();
}


#
# pragma mark Helpers
#

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
}


@end
