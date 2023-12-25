//
//  ContentView.swift
//  NavigationAPIPractice
//
//  Created by Amish Tufail on 25/12/2023.
//

import SwiftUI

struct ContentView: View {
//    @State var path: [Fruit] = [] // It has to be an array but this is restricted to one type
    @State var path = NavigationPath() // It takes all the type
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Text("String")
                    .font(.title)
                    .bold()
                ForEach(fruits) { fruit in
//                    NavigationLink {
//                        Text(fruit.name)
//                            .font(.largeTitle)
//                    } label: {
//                    }
                    NavigationLink(value: fruit.name) {
                        Text(fruit.name)
                    }
                    
                }
                Button {
                    let randomFruit = fruits.randomElement()!.name
                    path.append(randomFruit)
                } label: {
                    Text("String Path Button")
                }
                .foregroundStyle(.red)
                Text("Int")
                    .font(.title)
                    .bold()
                ForEach(fruits) { fruit in
                    NavigationLink(value: fruit.no) {
                        Text(fruit.name)
                    }
                    
                }
                Button {
                    let randomFruit = fruits.randomElement()!.no
                    path.append(randomFruit)
                } label: {
                    Text("Int Path Button")
                }
                .foregroundStyle(.red)
                Text("Fruit itself")
                    .font(.title)
                    .bold()
                ForEach(fruits) { fruit in
                    NavigationLink(value: fruit) {
                        Text(fruit.name)
                    }
                    
                }
                Button {
                    let randomFruit = fruits.randomElement()
                    path.append(randomFruit!)
                } label: {
                    Text("Fruit Path Button")
                }
                .foregroundStyle(.red)
                Text("Button")
                    .font(.title)
                    .bold()
                NavigationLink(value: fruits.randomElement()) {
                    Text("Random Fruit")
                        .bold()
                        .buttonStyle(.borderedProminent)
                }
                Text("Path")
                    .font(.title)
                    .bold()
                Button {
                    let randomFruit = fruits.randomElement()
                    path.append(randomFruit!)
                } label: {
                    Text("Path")
                        .bold()
                        .buttonStyle(.borderedProminent)
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: String.self) { name in
                Text(name)
            }
            .navigationDestination(for: Int.self) { count in
                Text("\(count)")
            }
            .navigationDestination(for: Fruit.self) { fruit in
                VStack {
                    Text(fruit.name)
                    Text("\(fruit.no)")
                }
                .padding(30.0)
                .background(
                    RoundedRectangle(cornerRadius: 18.0)
                        .foregroundStyle(.orange.opacity(0.45))
                )
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Fruit: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var no: Int
}

let fruits: [Fruit] = [
    Fruit(name: "Apple", no: 10),
    Fruit(name: "Banana", no: 3),
    Fruit(name: "Grapes", no: 13),
    Fruit(name: "Pineapple", no: 23),
    Fruit(name: "Stawberry", no: 7)
]
