//
//  Settings.swift
//  Sweet o meter
//
//  Created by MacBook Pro on 26/11/24.
//

import SwiftUI

struct Settings: View {
    
    @State private var isDarkMode = false
    @State private var isNotificationEnabled = false
    @State private var showHelpModal = false
    @State private var showAboutModal = false
    @State private var showNotificationAlert = false  // State for showing the alert

    var body: some View {
        GeometryReader { geometry in
            
            VStack{
                ZStack {
                    
                    Image("Logo Header") // Replace with your image name in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 100)
                        .padding(.top, 40)
                }
                VStack {
                    
                    // Settings Section
                    VStack(spacing: 16) {
                        Text("Settings")
                            .font(.title2)
                            .bold()
                            .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                            .padding(.top, 15)
                        
                        Divider()
                        
                        // Dark Mode Section with Icon
                        HStack {
                            Image(systemName: "moon.fill")  // Dark Mode Icon
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                            
                            Toggle("Dark Mode", isOn: $isDarkMode)
                                .toggleStyle(SwitchToggleStyle(tint: .pink))
                                .foregroundColor(isDarkMode ? .white : .black) // Change the toggle text color
                                .padding(.horizontal)
                                .padding(.leading, -15)
                        }
                        
                        Divider() // Line separator between Dark Mode and Notification
                        
                        // Notification Section with Icon
                        HStack {
                            Image(systemName: "bell.fill")  // Notification Icon
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                            
                            Toggle("Notification", isOn: $isNotificationEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: .pink))
                                .foregroundColor(isDarkMode ? .white : .black) // Change the toggle text color
                                .padding(.horizontal)
                                .padding(.leading, -15)
                                .onChange(of: isNotificationEnabled) { newValue in
                                    if newValue {
                                        showNotificationAlert = true  // Show the alert when notifications are turned on
                                    }
                                }
                        }
                        
                        Divider() // Line separator between Notification and Help
                        
                        // Help Section - Open Help Modal
                        Button(action: {
                            showHelpModal.toggle()  // Show the Help modal
                        }) {
                            HStack {
                                Image(systemName: "headphones")
                                    .foregroundColor(.gray)
                                Text("Help")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: $showHelpModal) {
                            HelpModalView(showHelpModal: $showHelpModal)  // Pass the binding to HelpModalView
                        }
                        
                        Divider() // Line separator between Help and About
                        
                        // About Section - Open About Modal
                        Button(action: {
                            showAboutModal.toggle()  // Show the About modal
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.gray)
                                Text("About")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: $showAboutModal) {
                            AboutModalView(showAboutModal: $showAboutModal)  // Pass the binding to AboutModalView
                        }
                        
                        Divider() // Line separator between About and Contact Us
                    }
                    .background(isDarkMode ? Color.black : Color.white) // Background color changes based on dark mode
                    .cornerRadius(12)
                    .padding([.leading, .trailing], geometry.size.width * 0.1) // Add proportional padding for larger screens
                    .padding(.top, 16)
                    
                    // Contact Us Section
                    VStack(spacing: 16) {
                        
                        Text("Contact Us")
                            .font(.title2)
                            .bold()
                            .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                            .padding(.top, 15)
                        
                        Divider()
                        
                        // Instagram link
                        Link(destination: URL(string: "https://www.instagram.com/sweetometer")!) {
                            HStack {
                                Image(systemName: "camera")
                                    .foregroundColor(.gray)
                                Text("@sweetometer")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        Divider() // Line separator between Contact Us entries
                        
                        // Email link
                        Link(destination: URL(string: "mailto:sweetometer@gmail.com")!) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                Text("sweetometer@gmail.com")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        Divider() // Line separator between Email and Website
                        
                        // Website link (sweet-o-meter)
                        Link(destination: URL(string: "https://www.sweet-o-meter.com")!) {
                            HStack {
                                Image(systemName: "link")
                                    .foregroundColor(.gray)
                                Text("sweet-o-meter")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        Divider() // Line separator between Website and Domain
                        
                        // Website link (sweetometer.com)
                        Link(destination: URL(string: "https://www.sweetometer.com")!) {
                            HStack {
                                Image(systemName: "globe")
                                    .foregroundColor(.gray)
                                Text("sweetometer.com")
                                    .foregroundColor(isDarkMode ? .white : .black) // Dynamic text color
                                Spacer()
                            }
                            .padding(.bottom, 15)
                            .padding(.horizontal)
                        }
                    }
                    .background(isDarkMode ? Color.black : Color.white) // Background color changes based on dark mode
                    .cornerRadius(12)
                    .padding([.leading, .trailing], geometry.size.width * 0.1) // Add proportional padding for larger screens
                    .padding(.top, 16)
                    
                    // Back Button
                    Button(action: {
                        // Add action for back button, for example, navigation or dismiss
                    }) {
                        Text("Back")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .padding([.leading, .trailing], geometry.size.width * 0.1) // Add proportional padding for the button
                    .padding(.top, 16)
                    .padding(.bottom, 32) // Optional: Add some space at the bottom for better visual balance
                    
                }
                .background(isDarkMode ? Color.black : Color(.systemGray6)) // Set the background color for the entire page
                .frame(maxHeight: .infinity) // Ensure the VStack fills the available space
                .preferredColorScheme(isDarkMode ? .dark : .light) // Toggle the color scheme based on the dark mode switch
                .alert(isPresented: $showNotificationAlert) { // Show alert when notifications are enabled
                    Alert(
                        title: Text("Notifications Enabled"),
                        message: Text("You have enabled notifications. You will now receive notifications."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

// Preview Provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .preferredColorScheme(.light) // Preview in light mode
    }
}
