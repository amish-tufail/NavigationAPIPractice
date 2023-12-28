//
//  EnumNavigation.swift
//  NavigationAPIPractice
//
//  Created by Amish Tufail on 28/12/2023.
//

import SwiftUI

enum Topic: String, CaseIterable, Hashable, Identifiable, View {
    case topic1 = "topic1"
    case topic2 = "topic2"
    case topic3 = "topic3"
    case topic4 = "topic4"
    
    var id: String {
        self.rawValue
    }
    
    var body: some View {
        switch self {
        case .topic1:
            TopicOne(name: self)
        case .topic2:
            TopicTwo(name: self)
        case .topic3:
            TopicThree(name: self)
        case .topic4:
            TopicFour(name: self)
        }
    }
}

struct EnumNavigation: View {
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(Topic.allCases) { topic in
                    NavigationLink(topic.rawValue, value: topic)
                        .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Enum Navigation")
            .navigationDestination(for: Topic.self) { topic in
                
                // We can do this here as well, but method of doing would be different, here instead of self it would have beeen topic
                /*
                 switch self {
                 case .topic1:
                     TopicOne(name: self)
                 case .topic2:
                     TopicTwo(name: self)
                 case .topic3:
                     TopicThree(name: self)
                 case .topic4:
                     TopicFour(name: self)
                 }
                 */
                
//                Text(topic.rawValue)
//                TopicOne(name: topic)
                // or
                
                //
                //
                topic.body
                // or
                topic // this is same as topic.body, as it auto interprets that there is a body which is basically a view
                //
                //
            }
        }
    }
}


struct TopicOne: View {
    var name: Topic
    var body: some View {
        Text(name.rawValue)
    }
}

struct TopicTwo: View {
    var name: Topic
    var body: some View {
        Text(name.rawValue)
    }
}

struct TopicThree: View {
    var name: Topic
    var body: some View {
        Text(name.rawValue)
    }
}

struct TopicFour: View {
    var name: Topic
    var body: some View {
        Text(name.rawValue)
    }
}

#Preview {
    EnumNavigation()
}
