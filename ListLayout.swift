//
//  ListLayout.swift
//  Moonshot2
//
//  Created by Waihon Yew on 18/06/2022.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding()
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                    }
                }
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        ListLayout(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
