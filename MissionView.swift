//
//  MissionView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 14/06/2022.
//

import SwiftUI

struct MissionView: View {
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

                    Text(launchText)

                    VStack(alignment: .leading) {
                        CustomDivider()

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        CustomDivider()

                        // Although this relates to the scroll view, it needs
                        // to have the same padding as the rest of our text.
                        // So, the best place for this is inside the VStack,
                        // directly after the previous custom divider.
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)

                    // Scroll views work best when they take full advantage of
                    // the available scren space, which means they should
                    // scroll edge to edge.
                    // If we put this inside our VStack above it would have the
                    // same padding as the rest of our text, which means it
                    // would scroll strangely - the crew would get clipped as
                    // it hits the leading edge of our VStack, which looks odd.
                    CrewView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    var launchText: String {
        if let launchDate = mission.launchDate {
            return "Launched on \(launchDate.formatted(date: .long, time: .omitted))"
        } else {
            return "Not launched"
        }
    }

    func isCommander(_ role: String) -> Bool {
        switch role {
        case "Commander", "Command Pilot":
            return true
        default:
            return false
        }
    }
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
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
