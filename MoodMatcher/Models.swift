import Foundation

struct Mood: Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let icon: String
}

struct SpotifyPlaylist: Codable, Identifiable {
    let id: String
    let name: String
    let images: [SpotifyImage]
    let owner: SpotifyUser
    let tracks: SpotifyTracks
}

struct SpotifyImage: Codable {
    let url: String
    let height: Int?
    let width: Int?
}

struct SpotifyUser: Codable {
    let display_name: String
}

struct SpotifyTracks: Codable {
    let total: Int
}

struct PlaylistResponse: Codable {
    let playlists: PlaylistItems
}

struct PlaylistItems: Codable {
    let items: [SpotifyPlaylist]
}

struct PlaylistTrackItem: Codable, Identifiable {
    let track: Track
    let added_at: String
    
    var id: String { track.id }
}

struct TrackResponse: Codable {
    let items: [PlaylistTrackItem]
}

struct Track: Codable {
    let id: String
    let name: String
    let album: Album
    let artists: [Artist]
    let duration_ms: Int
}

struct Album: Codable {
    let images: [SpotifyImage]
    let name: String
}

struct Artist: Codable {
    let name: String
}

