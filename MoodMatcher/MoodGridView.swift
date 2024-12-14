import SwiftUI

struct MoodGridView: View {
    let moods: [Mood] = [
        Mood(name: "Happy", color: "yellow", icon: "sun.max.fill"),
        Mood(name: "Pumped", color: "red", icon: "flame.fill"),
        Mood(name: "Relaxed", color: "blue", icon: "wind"),
        Mood(name: "Sad", color: "purple", icon: "cloud.rain.fill"),
        Mood(name: "Love", color: "mint", icon: "heart"),
        Mood(name: "Acoustic", color: "brown", icon: "guitars.fill")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(moods) { mood in
                        NavigationLink(destination: PlaylistView(mood: mood.name)) {
                            MoodCard(mood: mood)
                        }
                    }
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Choose Your Mood")
            .navigationBarTitleDisplayMode(.inline) 
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Choose Your Mood")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .background(Color.black)
        }
    }
}

struct MoodCard: View {
    let mood: Mood
    
    var body: some View {
        VStack {
            Image(systemName: mood.icon)
                .font(.system(size: 40))
            Text(mood.name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .background(Color(mood.color))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

#Preview {
    MoodGridView()
}
