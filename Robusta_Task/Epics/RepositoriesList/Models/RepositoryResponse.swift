//
//  RepositoryResponse.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

struct RepositoryResponse:  Codable {
 
    var id: Int?
    var name: String?
    var full_name: String?
    var descriptionString: String?
    var teams_url:String?
    var branches_url:String?
    var issues_url:String?
    var commits_url:String?
    var url: String?
    var owner: owner?
    
    
    enum CodingKeys: String, CodingKey {
        case descriptionString = "description"
        case name
        case full_name
        case teams_url
        case branches_url
        case issues_url
        case commits_url
        case url
        case owner
    }
}

struct owner: Codable {
    var avatar_url: String?
    var type:String?
    
    enum CodingKeys: String, CodingKey {
        case avatar_url
        case type
    }
}
