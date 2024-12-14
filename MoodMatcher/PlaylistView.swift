import SwiftUI

struct PlaylistView: View {
    let mood: String
    @State private var tracks: [PlaylistTrackItem] = []
    @State private var isLoading = true
    @State private var error: Error?
    
    private let spotifyService = SpotifyService()
    
    private func getPlaylistId(for mood: String) -> String {
        switch mood.lowercased() {
        case "happy":
            return "0okKcRyYEwq8guFxzAPtlB"
        case "sad":
            return "1Ij305qPshwfgopZxZTdTJ"
        case "acoustic":
            return "11N6EYV5RERoqR09iLB89N"
        case "relaxed":
            return "15XrGyVQCg2kIgu9uKoReH"
        case "pumped":
            return "2MCO7EgCDWiaus5n2xwj58"
        case "love":
            return "5WFA7TWB1DOHRsKEdkNtWJ"
        default:
            return ""
        }
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else {
                List(tracks) { item in
                    HStack(spacing: 15) {
                        // Album artwork
                        if let imageUrl = item.track.album.images.first?.url {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(4)
                        }
                        
                        // Track info
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.track.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(item.track.artists.map { $0.name }.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.black)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.black)
            }
        }
        .navigationTitle("\(mood) Playlist")
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark)
        .toolbarBackground(.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar) 
        .background(Color.black.ignoresSafeArea())
        .task {
            do {
                let playlistId = getPlaylistId(for: mood)
                tracks = try await spotifyService.fetchPlaylistTracks(playlistId: playlistId)
                isLoading = false
            } catch {
                self.error = error
                print("Error fetching tracks: \(error)")
                isLoading = false
            }
        }
    }
}


#Preview {
    NavigationView {
        PlaylistView(mood: "Acoustic")
            .preferredColorScheme(.dark)
    }
}
