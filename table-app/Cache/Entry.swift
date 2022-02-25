//
//  Entry.swift
//  table-app
//
//  Created by Alexandr Kozorez on 23.02.2022.
//

import Foundation
import UIKit

final class Entry {
    let key: Key
    let value: Value
    let expirationDate: Date

    init(key: Key, value: Value, expirationDate: Date) {
        self.key = key
        self.value = value
        self.expirationDate = expirationDate
    }
}
