//
//  ContentView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    // Since decode now returns any type that conforms to Codable,
    // we need to use a type annotation so Swift knows exactly
    // what astronauts will be.
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var showingGrid = true

    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(buttonText) {
                    showingGrid.toggle()
                }
            }
        }
    }

    var buttonText: String {
        showingGrid ? "List Layout" : "Grid Layout"
    }
}

struct HorizontalGridContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 50, maximum: 80))
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(1..<1001) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct VerticalGridContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(1..<1001) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodableContentView: View {
    @State private var showingAlert = false
    @State private var user = User(name: "",
        address: Address(street: "", city: ""))

    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avanue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                self.user = user
                showingAlert = true
            }
        }
        .alert("Decoded Data", isPresented: $showingAlert) {
            Button("Continue") { }
        } message: {
            Text("""
            Name: \(user.name)
            Street: \(user.address.street)
            City: \(user.address.city)
            """)
        }
    }
}

struct ListLinkContentView: View {
    var body: some View {
        NavigationView {
            List(1..<101) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct HorizontalStackContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0 + 1)")
                        .font(.title)
                }
            }
        }
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText: \(text)")
        self.text = text
    }
}

struct VerticalStackContentView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0 + 1)")
                        .font(.title)
                }
            }
        }
    }
}

struct GeometryContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.8, height: 150)
            }
            Text("An image that's 80% the width of the container, with a fixed height of 300.")

            GeometryReader { geo in
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.8)
            }
            Text("An image that's 80% the width of the container.")

            GeometryReader { geo in
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.8)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            Text("Add a second frame that makes it fill the full space of the container in order to center an image inside a GeometryReader.")
        }
    }
}

struct ImageContentView: View {
    static let imageModes = [
        " Image": "Too big for the available space",
        "frame": "Still appear to be its full size",
        "frame, clipped": "Full size but clipped to frame",
        "resizable, frame": "Rezied disproportionately",
        "resizable, scaledToFill, frame": "The view will have no empty parts even if that means some of our image lies outside the container",
        "resizable, scaledToFit, frame": "Entire image will fit inside the container even if that menas leaving some parts of the view empty",
        "GeometryReader, width, height": "An image that's 80% the width of the container, with a fixed height of 300",
        "GeomeryReader, width": "An image that's 80% the width of the container"
    ]
    @State private var imageMode = " Image"

    var body: some View {
        NavigationView {
            Form {
                Picker("Mode", selection: $imageMode) {
                    ForEach(Self.imageModes.sorted(by: <), id: \.key) { key, value in
                        Text(key)
                    }
                    .pickerStyle(.automatic)
                }

                switch imageMode {
                case "frame":
                    Image("Example")
                        .frame(width: 300, height: 300)
                case "frame, clipped":
                    Image("Example")
                        .frame(width: 300, height: 300)
                        .clipped()
                case "resizable, frame":
                    Image("Example")
                        .resizable()
                        .frame(width: 300, height: 300)
                case "resizable, scaledToFit, frame":
                    Image("Example")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                case "resizable, scaledToFill, frame":
                    Image("Example")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                case "GeometryReader, width, height":
                    GeometryReader { geo in
                        // geo is a GeometryProxy object. This lets us query
                        // the environment: how big is the container?
                        // What position is our view? Are there any safe area
                        // insets?
                        Image("Example")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.95, height: 300)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                case "GeometryReader, width":
                    GeometryReader { geo in
                        Image("Example")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.95)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                default:
                    Image("Example")
                }

                Text(Self.imageModes[imageMode]!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
