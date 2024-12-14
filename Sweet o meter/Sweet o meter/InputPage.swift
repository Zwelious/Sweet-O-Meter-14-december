import SwiftUI

struct InputPage: View {
    @State private var productName: String = ""
    @State private var sugarWeight: String = ""
    @State private var sugarWeightchoose: Double = 0.0
    let sugarRange: ClosedRange<Double> = 0.0...100.0
    let sugarStep: Double = 1.0
    @State private var isSliderActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @EnvironmentObject var productData: ProductData

    var body: some View {
        VStack {
            // Header
            ZStack {
                Image("Logo Header")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 100)
                    .padding(.top, 40)
            }
            
            Form {
                // Input Fields
                VStack {
                    Text("Add Entry")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // Product Name Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add Product Name")
                            .font(.headline)
                        TextField("Enter your product name", text: $productName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 20)
                    }
                    
                    Spacer()
                    
                    // Sugar Weight Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add Sugar Weight")
                            .font(.headline)
                        
                        Toggle("Use Slider", isOn: $isSliderActive)
                            .padding()
                        
                        if isSliderActive {
                            Slider(value: $sugarWeightchoose, in: sugarRange, step: sugarStep)
                                .padding()
                            Text("Selected sugar weight: \(String(format: "%.1f", sugarWeightchoose)) g")
                                .padding()
                        } else {
                            TextField("Enter your sugar weight", text: $sugarWeight)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .onChange(of: sugarWeight) { newValue in
                                    if let value = Double(newValue) {
                                        sugarWeightchoose = value
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                    
                    // Add Button
                    Button(action: {
                        if productName.isEmpty {
                            alertMessage = "Please input the product"
                            showAlert = true
                        } else {
                            let sugarValue = isSliderActive ? sugarWeightchoose : Double(sugarWeight) ?? 0.0
                            let newProduct = Product(name: productName, sugarWeight: sugarValue)
                            
                            productData.products.append(newProduct)
                            
                            alertMessage = "Yay, \(productName) succesfully added"
                            showAlert = true
                            
                            // Reset fields
                            productName = ""
                            sugarWeight = ""
                            sugarWeightchoose = 0.0
                            isSliderActive = false
                        }
                    }) {
                        Text("Input")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "FF66C4"))
                            .foregroundStyle(.white)
                            .cornerRadius(100)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                // Product List
               
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("Sweet O'Meter")
            .navigationBarTitleDisplayMode(.inline)
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    let mockData = ProductData() // Create an empty ProductData instance

    return InputPage()
        .environmentObject(mockData) // Provide the empty ProductData instance
}
