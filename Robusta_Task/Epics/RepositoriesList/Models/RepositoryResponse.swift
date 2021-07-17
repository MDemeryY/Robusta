//
//  RepositoryResponse.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import Foundation

struct RepositoryResponse: Decodable {
    var id: Int
    var name: String
    var full_name: String
//    var description: String
    var teams_url:String
    var branches_url:String
    var issues_url:String
    var commits_url:String

    var url: String
    var owner: owner

}

struct owner: Decodable {
    var avatar_url: String
}
