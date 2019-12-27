//
//  DetailCountryViewController.h
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataManager.h"
#import "Configuration.h"

@class Country;

NS_ASSUME_NONNULL_BEGIN

@interface DetailCountryViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, strong)Country *country;

@property (weak, nonatomic) IBOutlet UIImageView *flagImage;

@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *currenciesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *languagesNameLabel;

- (IBAction)returnToHome:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
