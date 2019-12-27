//
//  DetailCountryViewController.m
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DetailCountryViewController.h"

NSString *const URL_FOR_COUNTRY_INFO = @"https://restcountries.eu/rest/v2/alpha/%@";

NSString *countryKey = @"name";
NSString *capitalKey = @"capital";
NSString *regionKey = @"region";
NSString *populationKey = @"population";
NSString *areaKey = @"area";
NSString *currenciesKey = @"currencies";
NSString *languagesKey = @"languages";

@implementation DetailCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    [self.navigationItem setTitle:self.country.name];
    
    [self loadDataFromAPI];
    [self loadFlag];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchReguest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:countryTableName inManagedObjectContext:_managedObjectContext];
    [fetchReguest setEntity:entityDescription];
    [fetchReguest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchReguest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shortName == %@", self.country.shortName];
    [fetchReguest setPredicate:predicate];
    
    NSFetchedResultsController * fetchedResultController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReguest
                                        managedObjectContext:_managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    fetchedResultController.delegate = self;
    self.fetchedResultsController = fetchedResultController;
    
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return fetchedResultController;
}

#pragma mark - Action methods

- (IBAction)returnToHome:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Private methods

-(void)loadDataFromAPI {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:URL_FOR_COUNTRY_INFO, self.country.shortName]];
    NSURLSession *session = [NSURLSession sharedSession];
    Country *country = [self.fetchedResultsController.fetchedObjects firstObject];
    if (country.detailInfo == nil) {
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *capital = [json objectForKey:capitalKey];
                NSString *region = [json objectForKey:regionKey];
                NSInteger population = [[json objectForKey:populationKey] integerValue];
                NSInteger area = [[json objectForKey:areaKey] integerValue];
                NSString *currencies = [self.currenciesNameLabel text];
                NSMutableString *currenciesValue = [[NSMutableString alloc] initWithString:@""];
                for (NSDictionary *dictCurrency in [json objectForKey:currenciesKey]) {
                    [currenciesValue appendFormat:@"%@, ", [dictCurrency objectForKey:@"name"]];
                }
                [currenciesValue deleteCharactersInRange:NSMakeRange([currenciesValue length] - 2, 2)];
                currencies = [currencies stringByAppendingString:[currenciesValue copy]];
                NSString *languages = [self.languagesNameLabel text];
                NSMutableString *languagesValue = [[NSMutableString alloc] initWithString:@""];
                for (NSDictionary *dictLanguage in [json objectForKey:languagesKey]) {
                    [languagesValue appendFormat:@"%@, ", [dictLanguage objectForKey:@"name"]];
                }
                [languagesValue deleteCharactersInRange:NSMakeRange([languagesValue length] - 2, 2)];
                languages = [languages stringByAppendingString:[languagesValue copy]];
                CountryDetail *countryDetail = (CountryDetail *)[DataManager newCountryDetailWithCapital:capital region:region population:population area:area currencies:currenciesValue languages:languagesValue];
                country.detailInfo = countryDetail;
                [self.managedObjectContext save:nil];
                [self updateViewInterface];
            });
        }];
        [task resume];
    } else {
        [self updateViewInterface];
    }
}

- (void)updateViewInterface {
    [self.countryNameLabel setText:[self.countryNameLabel.text stringByAppendingString:self.country.name]];
    [self.capitalNameLabel setText:[self.capitalNameLabel.text stringByAppendingString:self.country.detailInfo.capital]];
    [self.regionNameLabel setText:[self.regionNameLabel.text stringByAppendingString:self.country.detailInfo.region]];
    [self.populationLabel setText:[self.populationLabel.text stringByAppendingString:[NSString stringWithFormat:@"%d people", self.country.detailInfo.population]]];
    [self.areaLabel setText:[self.areaLabel.text stringByAppendingString:[NSString stringWithFormat:@"%d km2", self.country.detailInfo.area]]];
    [self.currenciesNameLabel setText:[self.currenciesNameLabel.text stringByAppendingString: self.country.detailInfo.currencies]];
    [self.languagesNameLabel setText:[self.languagesNameLabel.text stringByAppendingString: self.country.detailInfo.languages]];
}

- (void)loadFlag {
    [self.flagImage setImage:[UIImage imageWithData:[DataManager getFlag:self.country]]];
}

@end
