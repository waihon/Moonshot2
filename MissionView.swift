//
//  MissionView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 14/06/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission

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

    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
