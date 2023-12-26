//
//  NavigationAPIPracticeApp.swift
//  NavigationAPIPractice
//
//  Created by Amish Tufail on 25/12/2023.
//

import SwiftUI

@main
struct NavigationAPIPracticeApp: App {
//    @State var router = Router()
    
    var body: some Scene {
        WindowGroup {
            FirstView()
//                .environment(router)
            // For this first we go to Info -> URL Schemes, there we give unique Identifier and give a URL Scheme
//                .onOpenURL(perform: { url in
//                    guard let scheme = url.scheme, scheme == "navStack" else { return }
//                    print(scheme)
//                    guard let host = url.host else { return } // Host in our case is Country
//                    if let foundCountry = countires.first(where: { $0.name == host }) {
//                        print(foundCountry)
//                        router.reset()
//                        router.path.append(foundCountry)
//                        if url.pathComponents.count == 2 {
//                            let city = url.lastPathComponent
//                            if let foundCity = foundCountry.cities.first(where: { $0 == city }) {
//                                print(foundCity)
//                                router.path.append(foundCity)
//                            }
//                        }
//                    }
//                })
        }
    }
}
