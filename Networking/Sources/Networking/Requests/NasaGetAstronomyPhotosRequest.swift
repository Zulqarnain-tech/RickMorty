import Foundation

public struct NasaGetAstronomyPhotosRequest: GetAPIRequest {
    public typealias ResponseType = [AstronomyDTO]

    private let fromDate: String
    private let toDate: String

    public init (fromDate: String, toDate: String) {
        self.fromDate = fromDate
        self.toDate = toDate
    }

    public var endpoint: String {
        ""
    }
    public var queryItems: [URLQueryItem] {
        guard let apiKey =  Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            return []
        }
        return [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "start_date", value: fromDate),
            URLQueryItem(name: "end_date", value: toDate)
        ]
    }
}
