//
//  FilterListOfCountriesTVController.h
//  ListCountries2
//
//  Created by admin on 26.12.2019.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BaseListOfCountriesTVController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterListOfCountriesTVController : BaseListOfCountriesTVController<UISearchBarDelegate>
{
    NSString *_searchText;
}

@property(nonatomic, strong)NSString *searchText;

- (IBAction)scrollTableViewToTop:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
