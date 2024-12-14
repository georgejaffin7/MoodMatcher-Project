import Foundation

class SpotifyService {
    private let accessToken = "BQCL5pKpkn7p-dQSNwH08SL4HsDBCtkUVerISiS45b7okMRXFaH35h5HlPgxmkanUCcQo0nSe9oDUyiSBb8Dm40NI5GNOj9GZ0JU73FQvtEUGy3YX6U"
    
    func fetchPlaylists(forMood mood: String) async throws -> [SpotifyPlaylist] {
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=mood:\(mood)&type=playlist") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PlaylistResponse.self, from: data)
        return response.playlists.items
    }
    
    func fetchPlaylistTracks(playlistId: String) async throws -> [PlaylistTrackItem] {
        guard let url = URL(string: "https://api.spotify.com/v1/playlists/\(playlistId)/tracks") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(TrackResponse.self, from: data)
        return response.items
    }
}
