//
//  ContentView.swift
//  WeSplit
//
//  Created by Nicholas Gilbert on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheckAmount: Double {
        let checkAmount = Double(checkAmount)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var currencyType: FloatingPointFormatStyle<Double>.Currency {
        if #available(iOS 16, *) {
            return .currency(code: Locale.current.currency?.identifier ?? "USD")
        } else {
            return .currency(code: Locale.current.currencyCode ?? "USD")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                NavigationLink("Choose Tip Percentage") {
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                }
                    
                
                Section {
                    Text(totalPerPerson, format: currencyType)
                } header: {
                    Text("Amount Per Person")
                }
                
                Section {
                    if #available(iOS 16, *) {
                        Text(totalCheckAmount, format: currencyType)
                    } else {
                        // Fallback on earlier versions
                        Text(totalCheckAmount, format: currencyType)
                    }
                } header: {
                    Text("Total Check Amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
