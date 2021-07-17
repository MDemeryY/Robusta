//
//  Path.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

struct Path {
    private var components: [String]
    
    var absolutePath: String {
        return "/" + components.joined(separator: "/")
    }
    
    init(_ path: String) {
        components = path.components(separatedBy: "/").filter({ !$0.isEmpty })
    }
    
    mutating func append(path: Path) {
        components += path.components
    }
    
    func appending(path: Path) -> Path {
        var copy = self
        copy.append(path: path)
        return copy
    }
}
