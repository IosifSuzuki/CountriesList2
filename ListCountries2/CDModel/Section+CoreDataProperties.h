//
//  Section+CoreDataProperties.h
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "Section+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Section (CoreDataProperties)

+ (NSFetchRequest<Section *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Country *> *countries;

@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addCountriesObject:(Country *)value;
- (void)removeCountriesObject:(Country *)value;
- (void)addCountries:(NSSet<Country *> *)values;
- (void)removeCountries:(NSSet<Country *> *)values;

@end

NS_ASSUME_NONNULL_END
