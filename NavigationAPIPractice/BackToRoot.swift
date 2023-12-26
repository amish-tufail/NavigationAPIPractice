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
        // Code for deep linking
        /*
         1. For this first we go to Info -> URL Schemes, there we give unique Identifier and give a URL Scheme.
         2. Then we write the below code based on our navigation
         3. Test it while running simulator using terminal
         4. xcrun simctl openurl booted navStack://Pakistan -> This is how we use deep linking using terminal, first part is our URL scheme, second part is our first navigated link and so on.
         5. We create normal usesable link like: navStack://Pakistan/Islamabad -> this will route to last navigation
         6. NOTE: if we have spaces in name like United States then -> navStack://United%20States -> %20 indicates spaces
         
         */
        .onOpenURL(perform: { url in // This gives us the url
            guard let scheme = url.scheme, scheme == "navStack" else { return } // First we match our url.scheme with the url scheme name we provided
            print(scheme)
            guard let host = url.host else { return } // Then we check host, which is basically the first navigated link ( First View from where Navigation linking starts)
            if let foundCountry = countires.first(where: { $0.name == host }) { // Host in our case is Country
                print(foundCountry) // Ensuring check
                router.reset()
                router.path.append(foundCountry) // reset and add into router
                if url.pathComponents.count == 2 { // if more than one component then we do this
                    let city = url.lastPathComponent // getting the last component similar to how we got host
                    if let foundCity = foundCountry.cities.first(where: { $0 == city }) { // Again Check
                        print(foundCity)
                        router.path.append(foundCity) // Added to router
                    }
                }
            }
        })
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
