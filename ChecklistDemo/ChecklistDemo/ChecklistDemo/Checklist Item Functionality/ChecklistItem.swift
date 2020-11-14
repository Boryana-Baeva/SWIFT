//
//  ChecklistItem.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import Foundation

class ChecklistItem {
    var itemName: String
    var isChecked: Bool
    
    init(_ itemName: String, isChecked: Bool) {
        self.itemName = itemName
        self.isChecked = isChecked
    }
}

extension ChecklistItem: Equatable {
    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        lhs.itemName == rhs.itemName &&
            lhs.isChecked == rhs.isChecked
    }
}
