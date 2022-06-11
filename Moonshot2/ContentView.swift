//
//  ContentView.swift
//  Moonshot2
//
//  Created by Waihon Yew on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello, world!")
                .padding()
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
