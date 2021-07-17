//
//  CustomError.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

struct CustomError: Error, Decodable {
    var message: String
}
