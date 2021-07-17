//
//  CacheItem.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

final class CacheItem {
    var data: Data
    var aliveTill: Date?
    
    init(data: Data, aliveTill: Date?) {
        self.data = data
        self.aliveTill = aliveTill
    }
}
