//
//  DetailViewController.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-03.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


#
# pragma mark - Interface
#

@interface DetailViewController : UIViewController

#
# pragma mark Properties
#

@property (strong, nonatomic) id detailItem;

#
# pragma mark Outlets
#

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

