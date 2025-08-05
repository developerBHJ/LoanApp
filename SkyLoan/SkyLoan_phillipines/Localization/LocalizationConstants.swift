//
//  LocalizationConstants.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import Foundation

enum LocalizationConstants {
    static let localizableFileName = "Localizable"
    static let homeFileName = "HomePage"
    static let profile = "Profile"
    static let order = "Order"
    static let product = "Product"


    @propertyWrapper
    struct Localized{
        private var value: String
        private let tableName: String
        
        var wrappedValue: String{
            get{
                value.localized(using: tableName)
            }
            set{
                value = newValue
            }
        }
        
        init(wrappedValue: String, tableName: String = LocalizationConstants.localizableFileName) {
            self.value = wrappedValue
            self.tableName = tableName
        }
    }
}
