//
//  ConfigLoader.swift
//  ToDoList
//
//  Created by An Nguyen on 2023/02/20.
//

import Foundation

class ConfigLoader {
    static let ConfigName = "Config.plist"

    static func parseFile(named fileName: String = ConfigName) -> Configuration {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let fileData = FileManager.default.contents(atPath: filePath)
        else {
            fatalError("Config file '\(fileName)' not loadable!")
        }

        do {
            let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
            return config
        } catch {
            fatalError("Configuration not decodable from '\(fileName)': \(error)")
        }
    }
}

struct Configuration: Decodable {
    
    enum Environment: String {
        case development
        case staging
        case production
    }
    
    let config: String
    
    var environment: Environment {
        if let environment = Environment(rawValue: config) {
            return environment
        } else {
            assertionFailure("Invalid config: \(config)")
            return .production
        }
    }
    
}

let config = ConfigLoader.parseFile()
