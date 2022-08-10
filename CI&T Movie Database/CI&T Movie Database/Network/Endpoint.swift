//
//  Endpoint.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 09/08/22.
//

enum Endpoint {
    case castAndCrewFetch
    var urlString: String {
        switch self {
        case .castAndCrewFetch:
            return "https://api.themoviedb.org/3/movie/550/credits?api_key=a5a29cab08554d8a0b331b250a19170b"
        }
    }
}
