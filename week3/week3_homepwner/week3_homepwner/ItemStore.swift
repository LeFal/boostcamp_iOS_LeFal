//
//  ItemStore.swift
//  week3_homepwner
//
//  Created by LEOFALCON on 2017. 7. 17..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    func removeItem(_ item : Item)  {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex : Int, toIndex : Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
}
