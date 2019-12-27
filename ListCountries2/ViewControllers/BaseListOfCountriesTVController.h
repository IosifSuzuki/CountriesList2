//
//  BaseListOfCountriesTVController.h
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Configuration.h"
#import "DataManager.h"

#import "DetailCountryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseListOfCountriesTVController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSString * segueToDetail;

@end

NS_ASSUME_NONNULL_END
