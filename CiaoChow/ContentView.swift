//
//  ContentView.swift
//  CiaoChow
//
//  Created by Tyler Torres on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    let offWhite = Color(red: 0.98, green: 0.98, blue: 0.96)
    
    var body: some View {
        TabView {
            WeeklyPlanView()
                .tabItem {
                    Label("Weekly Plan", systemImage: "calendar")
                }
            
            RecipeSwipeView()
                .tabItem {
                    Label("Vote", systemImage: "hand.thumbsup")
                }
            
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet")
                }
        }
        .accentColor(.blue)
        .background(offWhite)
    }
}

struct WeeklyPlanView: View {
    var body: some View {
        Text("Weekly Plan View")
    }
}

struct RecipeListView: View {
    var body: some View {
        Text("Recipe List View")
    }
}

#Preview {
    ContentView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.98, green: 0.98, blue: 0.96))
}



// IDEA: Have a row of days(current week) in the top of the screen that are actually a single button, and when tapped, the view expands down into the user where they can swipe, almost like a staging area, where as users swipe left or right it'll show the recipes that have been generated for that week
