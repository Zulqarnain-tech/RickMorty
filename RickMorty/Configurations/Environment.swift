import Foundation

enum Environment: String {
    case dev = "dev"
    case staging = "staging"
    case prod = "prod"

    struct Constant {
        static let environmentKey = "ENVIRONMENT"
    }

    private static let defaultEnvironment = Environment.prod

    private static var currentEnvironmentString: String? {
        Bundle.main.object(forInfoDictionaryKey: Constant.environmentKey) as? String
    }

    static var current: Environment {
        guard let currentString = currentEnvironmentString else {
            return defaultEnvironment
        }

        switch currentString {
        case Environment.dev.rawValue:
            return .dev
        case Environment.staging.rawValue:
            return .staging
        case Environment.prod.rawValue:
            return .prod
        default:
            return defaultEnvironment
        }
    }

    static var isDev: Bool {
        return current == .dev
    }

    static var isStaging: Bool {
        return current == .staging
    }

    static var isProd: Bool {
        return current == .prod
    }
}
