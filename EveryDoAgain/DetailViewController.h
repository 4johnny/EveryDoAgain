//
//  DetailViewController.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-03.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"


#
# pragma mark - Interface
#

@interface DetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

#
# pragma mark Properties
#

@property (strong, nonatomic) Todo* todo;

#
# pragma mark Outlets
#

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *userPickerView;

@end

