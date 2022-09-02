
import Foundation

enum AppConfiguration: String {
    case peoples = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planet = "https://swapi.dev/api/planets/5"
}
struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .peoples:
            if let url = URL(string: configuration.rawValue) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        print("data - \(String(data: data, encoding: .utf8) ?? "")")
                    }
                    if let resonse1 = response as? HTTPURLResponse {
                        print("response -",resonse1.allHeaderFields, resonse1.statusCode)
                    }
                    print("error - \(error?.localizedDescription ?? ""), \(error.debugDescription)")
                }
                task.resume()
            }
            
        case .starships:
            if let url = URL(string: configuration.rawValue) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        print("data - \(String(data: data, encoding: .utf8) ?? "")")
                    }
                    if let resonse1 = response as? HTTPURLResponse {
                        print("response -",resonse1.allHeaderFields, resonse1.statusCode)
                    }
                    print("error - \(error?.localizedDescription ?? ""), \(error.debugDescription)")
                }
                task.resume()
            }
            
        case .planet:
            if let url = URL(string: configuration.rawValue) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        print("data - \(String(data: data, encoding: .utf8) ?? "")")
                    }
                    if let resonse1 = response as? HTTPURLResponse {
                        print("response -",resonse1.allHeaderFields, resonse1.statusCode)
                    }
                    print("error - \(error?.localizedDescription ?? ""), \(error.debugDescription)")
                }
                task.resume()
            }
        }
        
    }
}


