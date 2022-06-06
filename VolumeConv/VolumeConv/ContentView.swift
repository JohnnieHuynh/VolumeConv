//
//  ContentView.swift
//  VolumeConv
//
//  Created by Johnny Huynh on 5/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNum = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    
    @FocusState private var amountIsFocused: Bool
    
    //Unit arrays
    let unitLegend = ["ML","L","C","PT","GAL"]
    
    //Convert
    var convertUnit: Double {
        //Get input unit
        print(inputUnit)
        
        //Determine Unit
        var unitMul = 0.0
        
        if (inputUnit == "ML") {
            unitMul = 1.0
        }else if (inputUnit == "L") {
            unitMul = 1000.0
        }else if (inputUnit == "C") {
            unitMul = 240.0
        }else if (inputUnit == "PT") {
            unitMul = 473.0
        }else if (inputUnit == "GAL") {
            unitMul = 3785.0
        }
        
        //Convert to ML
        let inputML: Double = inputNum * unitMul
        
        //Get output unit multiplier
        if (outputUnit == "ML") {
            unitMul = 1.0
        }else if (outputUnit == "L") {
            unitMul = 1000.0
        }else if (outputUnit == "C") {
            unitMul = 240.0
        }else if (outputUnit == "PT") {
            unitMul = 473.0
        }else if (outputUnit == "GAL") {
            unitMul = 3785.0
        }
        
        //Convert
        let finalUnit: Double = inputML / unitMul
        
        //Return coverted unit answer
        return finalUnit
    }
    
    var body: some View {
        NavigationView {
            Form {
                //Input Number to Conv Sec
                Section {
                    TextField("Amount", value: $inputNum, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Convert")
                }
                
                //Segmented Controller for input
                Section {
                    Picker("Starting Unit", selection: $inputUnit) {
                        ForEach(unitLegend, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                //Segmented Controller for output
                Section {
                    Picker("Resulting Unit", selection: $outputUnit) {
                        ForEach(unitLegend, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                //Display Converted Number
                Section {
                    Text(convertUnit, format: .number)
                } header: {
                    Text("Final Unit")
                }
            }
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
