//
//  ViewController.swift
//  SyncContact
//
//  Created by SANISH PAUL on 01/08/22.
//

import UIKit
import Contacts
class ViewController: UIViewController {
    let store = CNContactStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authorize = CNContactStore.authorizationStatus(for: .contacts)
        if authorize == .notDetermined{
            store.requestAccess(for: .contacts){ (chk, error) in
                if error == nil {
                    
                }
        }
        }else if authorize == .authorized {
            getContactList()
        }
    }
    func getContactList(){
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
        let contact = try!store.unifiedContacts(matching: predicate, keysToFetch: [CNContactBirthdayKey as CNKeyDescriptor,CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
        for con in contact{
            print("Full Name: \(con.givenName)\(con.familyName)")
            for ph in con.phoneNumbers{
                print("Phone No: \(ph.value.stringValue)")
            }
        }
    }
}
