//
//  ServiceError.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//
import Foundation

public enum WebError<CustomError>: Error {
    case noInternetConnection
    case custom(CustomError)
    case unauthorized
    case other
}
