//
//  Country+CoreDataProperties.h
//  ListCountries2
//
//  Created by admin on 27.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//
//

#import "Country+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *flag;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *shortName;
@property (nullable, nonatomic, retain) Section *section;
@property (nullable, nonatomic, retain) CountryDetail *detailInfo;

@end

NS_ASSUME_NONNULL_END
