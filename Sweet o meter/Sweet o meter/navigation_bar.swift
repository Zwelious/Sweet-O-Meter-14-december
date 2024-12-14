//
//  navigation bar.swift
//  Sweet o meter
//
//  Created by MacBook Pro on 06/12/24.
//

import SwiftUI

struct navigation_bar: View {
    @State private var selectedTab: Int = 0 // Track the selected tab
    @EnvironmentObject var productData: ProductData
    
        var body: some View {
            VStack {
                Spacer()
                
                // Main content changes based on selectedTab
                Group {
                    switch selectedTab {
                    case 0:
                        ContentView() // Your home content
                    case 1:
                        InputPage() // Your input content
                    default:
                        Settings() // Your menu content
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Custom Navigation Bar
                HStack {
                    Button(action: {
                        selectedTab = 0 // Switch to Home tab
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(selectedTab == 0 ? .pink : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        selectedTab = 2 // Switch to Menu tab
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(selectedTab == 2 ? .pink : .gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.3), radius: 5)
                .padding(.horizontal)
                .frame(height: 80)
                .overlay(
                    // Floating Add Button
                    Button(action: { selectedTab = 1 }) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#ff66c4"))
                                .frame(width: 64, height: 64)
                                .shadow(color: .gray.opacity(0.3), radius: 6)
                            
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                        .padding(.bottom, 35) // Halfway touching the navbar
                        .padding(.leading, (UIScreen.main.bounds.width - 400) / 2) // Center horizontally
                    , alignment: .bottom
                )
            }
            .padding(.bottom, 20)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }

#Preview {
    let mockData = ProductData()
    return navigation_bar()
        .environmentObject(mockData)
}
