//
//  CrewView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 18/06/2022.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)  // aready in proportion
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .strokeBorder(isCommander(crewMember.role) ? .blue : .yellow, lineWidth: 3)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(isCommander(crewMember.role) ? .blue : .yellow)

                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
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

struct CrewView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let mission = missions.first(where: { $0.id == 11 }) // Apollo 11
    static let crew: [CrewMember] = mission!.crew.map { member in
        if let astronaut = astronauts[member.name] {
            return CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Missing \(member.name)")
        }
    }

    static var previews: some View {
        CrewView(crew: crew)
            .preferredColorScheme(.dark)
    }
}
