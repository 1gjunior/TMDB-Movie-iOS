//
//  App+Injection.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 31/08/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph

        register {
            APIManager() as APIManagerService
        }

        // MARK: - Repositories

        register { PhotoRepository(apiManager: resolve()) as PhotoRepositoryProtocol }

        // MARK: - ViewModels

        register { PhotoViewModel() }
    }
}
