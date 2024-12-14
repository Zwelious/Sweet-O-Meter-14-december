import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var productData: ProductData
    
    var totalSugarIntake: Double {
        productData.products.reduce(0) { total, product in
            total + product.sugarWeight
        }
    }
    
    var remainingSugar: Double {
        sugarGoal - totalSugarIntake
    }
    
    var formattedSugarIntake: String {
        String(format: "%.2f", totalSugarIntake)
    }
    
    var formattedSugar: String {
        String(format: "%.2f", remainingSugar)
    }
    

    @State private var todayEntries: [String] = []
    @State private var sugarGoal: Double = 50.0
    @State private var selectedFood: String = "Apple"
    
    
    // Weekly data for graph
    @State private var weeklyIntake: [Int] = [15, 20, 25, 10, 110, 45, 30]
    let maxHeight: CGFloat = 100 // Set the max height for the bar

    let dayLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        
            ZStack {
                VStack {
                    // Fixed Header with Title
                    ZStack {
                        Image("Logo Header")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 100)
                            .padding(.top, 40)
                    }
                    
                    // ScrollView for the rest of the content
                    ScrollView {
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Daily Tracker")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(hex: "#ff66c4"))
                                    HStack {
                                        Text("\(formattedSugarIntake) g")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundColor(totalSugarIntake > sugarGoal ? Color.red : Color(hex: "#ff66c4"))
                                        
                                        Spacer()
                                        
                                        Text("Left: \(formattedSugar) g")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                                    
                                    // Progress Bar inside the same container frame
                                    ZStack(alignment: .leading) {
                                        // Background of the progress bar (gray)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(height: 8)
                                            .frame(width: 340)
                                        
                                        // Foreground progress bar (colored) set to 50% width
                                        RoundedRectangle(cornerRadius: 4)
                                            .frame(width: min(totalSugarIntake / sugarGoal * 340, 340))
                                            .foregroundColor(totalSugarIntake > sugarGoal ? Color.red : Color(hex: "#ff66c4"))
                                    }
                                    .cornerRadius(4)
                                    .padding(.top, 10)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                            }
                            .padding(.horizontal)
                            
                            // Weekly Intake Bar Chart
                            VStack(alignment: .leading, spacing: 10) {
                                // Header for Weekly Intake
                                HStack {
                                    Text("Weekly Intake")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(hex: "#ff66c4"))
                                    Spacer() // Keeps text flexible to fit with overall layout
                                }
                                
                                // Bar Chart Section
                                ZStack {
                                    // Bar Chart
                                    HStack(spacing: 12) {
                                        ForEach(weeklyIntake.indices, id: \.self) { index in
                                            VStack {
                                                ZStack(alignment: .bottom) {
                                                    // Background bar (always starts at 0, this is the 'baseline' for all bars)
                                                    RoundedRectangle(cornerRadius: 4)
                                                        .fill(Color.gray.opacity(0.2)) // The grey bar that fills up to maxHeight
                                                        .frame(height: maxHeight)
                                                    
                                                    // Calculate the scaled height for visual representation
                                                    let scaledBarHeight = CGFloat(weeklyIntake[index]) * 1.5
                                                    
                                                    // Base bar (pink), capped at maxHeight (to show the intake)
                                                    RoundedRectangle(cornerRadius: 4)
                                                        .fill(Color(hex: "#ff66c4")) // Pink color for the base
                                                        .frame(height: min(scaledBarHeight, maxHeight)) // Capped at maxHeight
                                                }
                                                .frame(width: 30) // Set fixed width for each bar
                                                .padding(.bottom, 4) // Slight padding at the bottom for spacing
                                                
                                                // Day label
                                                Text(dayLabels[index])
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    
                                    // Maximum Indicator Line
                                    VStack {
                                        Spacer()
                                        
                                        Rectangle()
                                            .fill(Color.red)
                                            .frame(height: 2) // Thickness of the line
                                            .offset(y: -maxHeight) // Position at the top of the bar chart
//                                            .overlay(
//                                                Text("50 g")
//                                                    .font(.caption)
//                                                    .foregroundColor(Color.red)
//                                                    .offset(y: -8), alignment: .leading
//                                            )
                                    }
                                    .zIndex(1) // Ensures the red line is on top of all bars
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                            .padding(.horizontal)

                            
                            // Today Entries Section with Food Suggestions
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Today Entries")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "#ff66c4"))
                                
                                if productData.products.isEmpty {
                                    Text("No Entries")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                        .padding()
                                } else {
                                    List(productData.products) { entry in
                                        HStack {
                                            Text(entry.name)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Text(String(format: "%.2f g", entry.sugarWeight))
                                                .foregroundColor(.gray)

                                        }
                                    }
                                    .listStyle(PlainListStyle())
                                    .background(Color.white)
                                    .frame(height: 150)
                                }
                                    
                            }
                            .padding()
                            .frame(width: 370, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        
    }
    
    // Helper functions to add food and random entries
//    func addFoodEntry() {
//        let foodIntake = selectedFood == "Apple" ? 15 : selectedFood == "Banana" ? 25 : selectedFood == "Orange" ? 20 : 35
//        todayEntries.append("\(selectedFood) - \(foodIntake) g")
//        sugarIntake += foodIntake
//        remainingSugar = max(0, remainingSugar - foodIntake)
//    }
//    
//    func addRandomEntry() {
//        let randomIntake = Int.random(in: 10...30)
//        todayEntries.append("Random Food - \(randomIntake) g")
//        sugarIntake += randomIntake
//        remainingSugar = max(0, remainingSugar - randomIntake)
//    }
}

// Progress Bar view
struct ProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 8)
            Capsule()
                .fill(Color(hex: "#ff66c4"))
                .frame(width: CGFloat(progress) * UIScreen.main.bounds.width, height: 8)
        }
        .cornerRadius(4)
    }
}

// Custom Hex Color Support
extension Color {
    init(hex: String) {
        var hexString = hex
        if hex.hasPrefix("#") {
            hexString = String(hex.dropFirst()) // Remove the #
        }
        
        let scanner = Scanner(string: hexString)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    let mockData = ProductData()

    return ContentView()
        .environmentObject(mockData)
}
