import Foundation

public struct AstronomyDTO: Identifiable, Equatable, Codable {
    public var id: String {
        "\(self.title)_\(date)"
    }

    public var date: String
    public var explanation: String
    public var mediaURL: URL
    public var imageHDURL: URL?
    public var title: String
    public var copyright: String?
    public var mediaType: MediaTypeDTO?

    enum CodingKeys: String, CodingKey {
        case date, explanation, title, copyright
        case mediaURL = "url"
        case imageHDURL = "hdurl"
        case mediaType = "media_type"
    }
}

public extension AstronomyDTO {
    enum MediaTypeDTO: String, Codable {
        case image
        case video
    }
}
