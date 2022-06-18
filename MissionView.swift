//
//  MissionView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 14/06/2022.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                // If we've added some JSON data to our project that points
                // to missing data in our app, we've made a fundamental
                // mistake - it's not the kind of thing we should try to
                // write error handling for at runtime, because it should
                // never be allowed to happen in the first place.
                // So, this is a great example of where fatalError() is
                // useful: if we can't find an astronaut using their ID,
                // we should exit immediately and complain loudly.
                fatalError("Missiong \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geomery in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geomery.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
