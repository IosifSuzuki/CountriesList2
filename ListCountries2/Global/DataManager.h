//
//  DataManager.h
//  ListCountries2
//
//  Created by admin on 25.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AppDelegate.h"
#import "Configuration.h"

#import "Section+CoreDataClass.h"
#import "Country+CoreDataClass.h"
#import "CountryDetail+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property(atomic, strong)NSManagedObjectContext *managedObjectContext;

+ (DataManager *)sharedManager;
+ (Section *)newSectionWithName:(NSString *)name;
+ (Country *)newCountryWithName:(NSString *)name shortName:(NSString *)shortName flag:(NSData *)flag;
+ (CountryDetail *)newCountryDetailWithCapital:(NSString *)capital region:(NSString *)region population:(NSInteger)population area:(NSInteger)area currencies:(NSString *)cureencies languages:(NSString *)languages;
+ (void)clearCoreData;
+ (void)loadFlagToCell:(UITableViewCell *)cell country:(Country *)country;
+ (NSData *)getFlag:(Country *)country;

@end

NS_ASSUME_NONNULL_END
