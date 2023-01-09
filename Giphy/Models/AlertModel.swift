//
//  AlertModel.swift
//  Giphy
//
//  Created by Anton Reynikov on 09.01.2023.
//

import Foundation


struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)
}