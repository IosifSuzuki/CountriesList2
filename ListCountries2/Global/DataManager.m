//
//  DataManager.m
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DataManager.h"

NSString *URL_FOR_FLAG = @"https://www.countryflags.io/%@/flat/64.png";

@implementation DataManager

#pragma mark - Methods for CoreData

+ (DataManager *)sharedManager {
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        manager.managedObjectContext = delegate.persistentContainer.viewContext;
    });
    return manager;
}

+ (Section *)newSectionWithName:(NSString *)name {
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    Section *section =
        (Section *)[NSEntityDescription insertNewObjectForEntityForName:sectionTableName
                                                 inManagedObjectContext:managedObjectContext];
    section.name = name;
    return section;
}

+ (Country *)newCountryWithName:(NSString *)name shortName:(NSString *)shortName flag:(NSData *)flag {
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    Country *country =
        (Country *)[NSEntityDescription insertNewObjectForEntityForName:countryTableName
                                                 inManagedObjectContext:managedObjectContext];
    country.name = name;
    country.shortName = shortName;
    country.flag = flag;
    
    return country;
}

+ (CountryDetail *)newCountryDetailWithCapital:(NSString *)capital region:(NSString *)region population:(NSInteger)population area:(NSInteger)area currencies:(NSString *)cureencies languages:(NSString *)languages {
   NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    CountryDetail *countryDetail = (CountryDetail *)[NSEntityDescription insertNewObjectForEntityForName:countryDatailTableName inManagedObjectContext:managedObjectContext];
    countryDetail.capital = capital;
    countryDetail.region = region;
    countryDetail.population = (int32_t)population;
    countryDetail.area = (int32_t)area;
    countryDetail.currencies = cureencies;
    countryDetail.languages = languages;
    return countryDetail;
}

+ (void)clearCoreData {
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:sectionTableName inManagedObjectContext:managedObjectContext];
    NSFetchRequest *reguest = [[NSFetchRequest alloc] init];
    [reguest setEntity:entityDescription];
    NSArray *matchingObjects = [managedObjectContext executeFetchRequest:reguest error:nil];
    for (NSManagedObject *item in matchingObjects) {
        [managedObjectContext deleteObject:item];
    }
    [managedObjectContext save:nil];
}

#pragma mark - Methods work with network

+ (void)saveNSDataToCoreData:(NSData *)data countryCode:(NSString *)countryCode{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    NSEntityDescription *entityDescriptor = [NSEntityDescription entityForName:countryTableName inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchReguest = [[NSFetchRequest alloc] init];
    [fetchReguest setEntity:entityDescriptor];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shortName == %@", countryCode];
    [fetchReguest setPredicate:predicate];
    @synchronized (data) {
        ((Country *)[[managedObjectContext executeFetchRequest:fetchReguest error:nil] firstObject]).flag = data;
        [managedObjectContext save:nil];
    }
}

+ (void)loadFlagToCell:(UITableViewCell *)cell country:(Country *)country {
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSData *image = country.flag;
        if ([country.flag isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"unknown_flag"])]) {
            NSString *completeUrl = [NSString stringWithFormat:URL_FOR_FLAG, country.shortName];
            NSError *error = nil;
            image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:completeUrl] options:NSUncachedRead error:&error];
            if (error == nil) {
                [DataManager saveNSDataToCoreData:image countryCode:country.shortName];
            } else {
                image = country.flag;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:image];
            [cell setNeedsLayout];
        });
    });
}

+ (NSData *)getFlag:(Country *)country {
    NSString *completeUrl = [NSString stringWithFormat:URL_FOR_FLAG, country.shortName];
    NSData *image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:completeUrl] options:NSUncachedRead error:nil];
    return image;
}

@end
