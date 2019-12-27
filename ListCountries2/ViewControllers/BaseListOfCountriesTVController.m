//
//  BaseListOfCountriesTVController.m
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BaseListOfCountriesTVController.h"

@implementation BaseListOfCountriesTVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    //[DataManager clearCoreData];
    if ([[self.fetchedResultsController fetchedObjects] count] == 0) {
        [self fillingDataToLocalStore];
    }
    [self prepareViewInterface];
    [self.tableView reloadData];
}

- (NSString *)segueToDetail {
    return @"SegueFromListOfContriesToDetailCountry";
}

#pragma mark - Private methods

- (void)prepareViewInterface {
    [self.tableView setSectionIndexColor:[UIColor grayColor]];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(Country *)country withIndex:(NSInteger)row {
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = country.shortName;
    [cell.textLabel setTextColor:[self chooseColorAtIndex:row + 1]];
    [cell.detailTextLabel setTextColor:[self chooseColorAtIndex:row + 1]];
    [cell setBackgroundColor:[self chooseColorAtIndex:row]];
    [DataManager loadFlagToCell:cell country:country];
}

- (UIColor *)chooseColorAtIndex:(NSInteger)index {
    return index % 2 == 0 ? [[Configuration sharedManager] primatyColor] : [[Configuration sharedManager] secondaryColor];
}

- (void)fillingDataToLocalStore {
    NSString *lastLetter = nil;
    Section *section = nil;
    for (NSString * countryCode in [NSLocale ISOCountryCodes]) {
        if (![[NSArray arrayWithObjects:@"AC", @"CP", @"DG", @"EA", @"TA", nil] containsObject:countryCode]) {
            if (![lastLetter isEqualToString:[countryCode substringToIndex:1]]) {
                lastLetter = [countryCode substringToIndex:1];
                section = [DataManager newSectionWithName:lastLetter];
            }
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
            NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"unknown_flag"]);
            Country *country = [DataManager newCountryWithName:countryName shortName:countryCode flag:data];
            country.section = section;
        }
    }
    [self.managedObjectContext save:nil];
}

- (Country *)selectCountryByNSIndexPath:(NSIndexPath *)indexPath {
    Section *section = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.section];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    Country *country = [[[section.countries allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]] objectAtIndex:indexPath.row];
    return country;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchReguest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:sectionTableName inManagedObjectContext:_managedObjectContext];
    [fetchReguest setEntity:entityDescription];
    [fetchReguest setFetchBatchSize:20];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchReguest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController * fetchedResultController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReguest
                                        managedObjectContext:_managedObjectContext
                                          sectionNameKeyPath:@"name"
                                                   cacheName:nil];
    fetchedResultController.delegate = self;
    self.fetchedResultsController = fetchedResultController;
    
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return fetchedResultController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [NSString stringWithFormat:@"%@(%li)", sectionInfo.indexTitle, [self.fetchedResultsController.fetchedObjects count]];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *letters = [[NSMutableArray alloc] init];
    for (Section *section in [self.fetchedResultsController fetchedObjects]) {
        [letters addObject:section.name];
    }
    return [letters copy];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Section *sectionItem = (Section *)[[self.fetchedResultsController fetchedObjects] objectAtIndex:section];
    return [sectionItem.countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];

    Country *country = [self selectCountryByNSIndexPath:indexPath];
    [self configureCell:cell withObject:country withIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: [self selectCountryByNSIndexPath:indexPath], @"country",  nil];
    [self performSegueWithIdentifier:[self segueToDetail] sender:dictionary];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [sectionHeader setBackgroundColor:[[Configuration sharedManager] mainColor]];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [text setTextAlignment:NSTextAlignmentCenter];
    [text setText:[self tableView:tableView titleForHeaderInSection:section]];
    [text setTextColor:[[Configuration sharedManager] secondaryColor]];
    [sectionHeader addSubview:text];
    return sectionHeader;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    sender = (NSDictionary *)sender;
    if ([[segue identifier] isEqualToString:[self segueToDetail]]) {
        DetailCountryViewController *detailConutryViewController = [segue destinationViewController];
        [detailConutryViewController setCountry:[sender objectForKey:@"country"]];
    }
}

@end
