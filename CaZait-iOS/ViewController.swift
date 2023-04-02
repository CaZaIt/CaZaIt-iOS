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
        Item(name: "메인화면", imageName: "1.circle"),
        Item(name: "지도", imageName: "2.circle"),
        Item(name: "마이페이지", imageName: "3.circle"),
        Item(name: "더보기", imageName: "4.circle")
    ]
}

// View
struct ContentView: View {
    @StateObject private var viewModel = TabViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(0..<4) { index in
                let item = viewModel.items[index]
                let view: AnyView = {
                    switch index {
                    case 0:
                        return AnyView(MainView())
                    case 1:
                        return AnyView(MapView())
                    case 2:
                        return AnyView(MyPageView())
                    case 3:
                        return AnyView(MoreView())
                    
                    default:
                        return AnyView(Text("아직 구현되지 않은 화면"))
                    }
                }()
                view
                    .tabItem {
                        Image(systemName: item.imageName)
                        Text(item.name)
                    }
                    .tag(index)
            }
        }
    }
}

