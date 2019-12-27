//
//  FilterListOfCountriesTVController.m
//  ListCountries2
//
//  Created by admin on 26.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "FilterListOfCountriesTVController.h"

@interface BaseListOfCountriesTVController ()

- (void)prepareViewInterface;
- (UIColor *)chooseColorAtIndex:(NSInteger)index;

@end

@implementation FilterListOfCountriesTVController

@synthesize searchText = _searchText;

- (NSString *)segueToDetail {
    return @"SegueFromFilterListOfContriesToDetailCountry";
}

#pragma mark - Private methods

- (void)prepareViewInterface {
    [super prepareViewInterface];
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar setShowsCancelButton:NO];
    [searchBar setPlaceholder:@"Filter countries by country names"];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTextColor:[[Configuration sharedManager] secondaryColor]];
}

- (NSArray *)filterCountriesBySearchText:(NSArray *)countries {
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (Country *country in countries) {
        if ([_searchText isEqualToString:@""]) {
            [objects addObject:country];
        } else if (!([country.name rangeOfString:_searchText].location == NSNotFound)) {
            [objects addObject:country];
        }
    }
    return [objects copy];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(Country *)country withIndex:(NSInteger)row {
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = country.shortName;
    if (_searchText == nil) {
        _searchText = @"";
    }
    if ([country.name rangeOfString:[self searchText] options:NSCaseInsensitiveSearch].location != NSNotFound) {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    } else {
        [cell setBackgroundColor:[super chooseColorAtIndex:row]];
    }
    [cell.textLabel setTextColor:[super chooseColorAtIndex:row + 1]];
    [cell.detailTextLabel setTextColor:[super chooseColorAtIndex:row + 1]];
    [DataManager loadFlagToCell:cell country:country];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton: YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self setSearchText:searchText];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"countries.name CONTAINS[cd] %@", searchText];
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    if ([searchText isEqualToString:@""]) {
        [self.fetchedResultsController.fetchRequest setPredicate:nil];
    }
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)scrollTableViewToTop:(UIBarButtonItem *)sender {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", [[[self.fetchedResultsController sections] objectAtIndex:section] indexTitle]];
}

@end
