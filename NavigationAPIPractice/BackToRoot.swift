//
//  BackToRoot.swift
//  NavigationAPIPractice
//
//  Created by Amish Tufail on 25/12/2023.
//

import SwiftUI
import Observation

// This is router, which would be used to pop back to root, it is added to environment for each access
@Observable class Router {
    var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
}

struct Country: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var cities: [String]
}

let countires: [Country] = [
    Country(name: "Pakistan", cities: ["Islamabad", "Haripur", "Lahore"]),
    Country(name: "Saudi Arabia", cities: ["Riyadh", "Dammam", "Jeddah"]),
    Country(name: "Finland", cities: ["Helsinki", "Tampra", "Vince"])
]

struct FirstView: View {
    @State var router = Router()
    
    var body: some View {
        // NavigationLink auto stores in the path
        NavigationStack(path: $router.path) {
            List {
                ForEach(countires) { country in
                    NavigationLink(value: country) {
                        Text(country.name)
                    }
                }
            }
            .navigationTitle("All Countries")
            .navigationDestination(for: Country.self) { country in
                SecondView(country: country)
            }
        }
        .environment(router)
    }
}

#Preview {
    FirstView()
//    SecondView(country: countires[0])
}

struct SecondView: View {
    let country: Country
    
    // In this view we dont need router
    
    var body: some View {
        VStack {
            List {
                Text(country.name)
                    .font(.largeTitle)
                    .bold()
                ForEach(country.cities, id: \.self) { city in
                    NavigationLink(value: city) {
                        Text(city)
                    }
                }
            }
        }
        .navigationTitle("All Cities")
        .navigationDestination(for: String.self) { city in
            ThirdView(city: city)
        }
    }
}

struct ThirdView: View {
    let city: String
    
    @Environment(Router.self) var router
    var body: some View {
        VStack {
            Text(city)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(40.0)
                .background(RoundedRectangle(cornerRadius: 18.0).fill(Color.orange.opacity(0.45)))
            Button {
                router.reset()
            } label: {
                Text("Back to Root")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 12.0))
        }
    }
}
