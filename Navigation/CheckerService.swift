//
//  CheckerService.swift
//  Navigation
//
//  Created by Иван Могутов on 30.11.2022.
//

import Foundation

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, complition: @escaping (String) -> Void)
    func signUp(email: String, password: String, complition: @escaping (String) -> Void)
}
