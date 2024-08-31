import Domain
import Foundation

public extension CharacterDataEntity {
    static var mock: Self {
        .init(
            info: .init(
                count: 826,
                pages: 42,
                next: "https://rickandmortyapi.com/api/character/?page=2",
                prev: nil
            ),
            results: [
                .init(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    type: "",
                    gender: "Male",
                    origin: .init(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/1"
                    ),
                    location: .init(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/20"
                    ),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    episode: [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2",
                    ],
                    url: "https://rickandmortyapi.com/api/character/1",
                    created: "2017-11-04T18:48:46.250Z"
                )
            ]
        )
    }
}

