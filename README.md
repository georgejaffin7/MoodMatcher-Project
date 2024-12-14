Mood Matcher App
Table of Contents
Overview
Product Spec
Wireframes
Schema
Overview

Description
-
Mood Matcher is an application that is designed to let users find music that match a particular mood they're feeling. A user can scroll through a list of preselected moods, like sad, happy, angry, etc to find new music that you could easily get into at that moment.

App Evaluation
[Evaluation of your app across the following attributes]

Category: Entertainment
Mobile: Yes
Story: The app lets users find new music through moods.
Market: Music lovers or anyone who frequently listens to music and wants to find new songs.
Habit: Daily use for some, occasional use for others
Scope: Narrow with the potential to be broadened
Product Spec
1. User Stories (Required and Optional)
Required Must-have Stories
- User can log in
- User can see a list of moods displayed
- User can see list of songs displayed
...
Optional Nice-to-have Stories

- User can refresh song list to get new songs
- User can filter by decade, genre, or artist
- User log in persists
- User can add songs to their playlist through Spotify/Apple Music
- 
2. Screen Archetypes

Login Screen

- User can login

Main Screen
- User can view the list of moods

Song Display Screen
- User can view the associated list of songs with the selected mood listed at the top

3. Navigation
Tab Navigation (Tab to Screen)
First tab - Main Screen
Potential Second tab - List of favorited songs
Potential Third tab - profile/logout

Flow Navigation (Screen to Screen)

**Login Screen**
Leads to **Main Screen**
**Main Screen**
Leads to **Song Display Screen**

Wireframes
![image](https://github.com/FAU-Fall2024-iOS-Mobile-App/final-project-georgejaffin7/blob/8c71e393c9b91a55dae2c94c77961c398545d915/Screenshot%202024-11-28%20at%202.08.29%E2%80%AFPM.png)


Schema
--
Models

1. Mood
| Property | Type | Description |
| id | UUID | Unique identifier for the mood (auto-generated) |
| name | String | Name of the mood (e.g., "Happy", "Sad")| 
| icon | String | SF Symbol name for the mood's icon |
2. Track
| Property | Type | Description |
| id | String | Spotify's unique identifier for the track |
| name | String | Name of the track |
| duration_ms | Int | Duration of track in milliseconds |
| artists | [Artist] | Array of artists associated with the track |
| album | Album | Album information for the track |
3. Album
| Property | Type | Description |
| name | String | Name of the album |
| images | [SpotifyImage] | Array of album artwork images |
4. Artist
| Property | Type | Description |
| name | String | Name of the artist |
username	String	unique id for the user post (default field)
password	String	user's password for login authentication

Networking
Spotify API Endpoints Used
1. Get Playlist Tracks
GET https://api.spotify.com/v1/playlists/{playlist_id}/tracks
- Headers:
Authorization: Bearer {access_token}
Used in: PlaylistView
Response: TrackResponse containing array of PlaylistTrackItem

Playlist IDs by Mood:
Happy: "0okKcRyYEwq8guFxzAPtlB"
Sad: "1Ij305qPshwfgopZxZTdTJ"
Acoustic: "11N6EYV5RERoqR09iLB89N"
Relaxed: "15XrGyVQCg2kIgu9uKoReH"
Pumped: "2MCO7EgCDWiaus5n2xwj58"
Love: "5WFA7TWB1DOHRsKEdkNtWJ"

Views/Screens
1. MoodGridView
Displays grid of available moods
No network requests
Navigation to PlaylistView
2. PlaylistView
Network Request: GET playlist tracks
Displays list of tracks for selected mood
Shows album artwork, track name, and artists
Authentication
Uses Spotify API access token for authentication
Token needs to be refreshed periodically
Current implementation uses static token

Network Request:
```
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
```
