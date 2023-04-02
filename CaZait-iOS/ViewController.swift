//
//  ViewController.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import Foundation
import SwiftUI

// Model
struct Item {
    var name: String
    var imageName: String
}

// ViewModel
class TabViewModel: ObservableObject {
    @Published var selectedTab = 0
    @Published var items = [
        Item(name: "첫 번째", imageName: "1.circle"),
        Item(name: "두 번째", imageName: "2.circle"),
        Item(name: "세 번째", imageName: "3.circle"),
        Item(name: "네 번째", imageName: "4.circle")
    ]
}

// View
struct ContentView: View {
    @StateObject private var viewModel = TabViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(0..<viewModel.items.count) { index in
                let item = viewModel.items[index]
                
                VStack {
                    Image(systemName: item.imageName)
                        .font(.system(size: 40))
                    Text(item.name)
                }
                .tabItem {
                    Image(systemName: item.imageName)
                    Text(item.name)
                }
                .tag(index)
            }
        }
    }
}

