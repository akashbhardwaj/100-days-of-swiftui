//
//  ContentView.swift
//  Convert
//
//  Created by Akash Bhardwaj on 2023-08-03.
//

import SwiftUI

struct ContentView: View {



    @State private var input: Double = 0.0
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .celsius
    @FocusState private var isInputFocused: Bool

    private var outputValue: Double {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        return inputMeasurement.converted(to: outputUnit).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                    TemperaturePicker(title: "Input Unit", inputUnit: $inputUnit)
                }
                Section {
                    TemperaturePicker(title: "Output Unit", inputUnit: $outputUnit)
                } header: {
                    Text ("Select output unit")
                }

                Section {
                    Text(outputValue, format: .number)
                } header: {
                    Text ("Output value")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
            .navigationTitle("Converter")
        }
    }
}
extension UnitTemperature {
    var title: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .kelvin:
            return "Kelvin"
        default:
            return "None"
        }
    }
}

struct TemperaturePicker: View {
    private let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    var title: String
    @Binding var inputUnit: UnitTemperature

    var body: some View {
        Picker(title, selection: $inputUnit) {
            ForEach(units, id: \.self) { unit in
                Text(unit.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
