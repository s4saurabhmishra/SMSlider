//
//  PriceInputField.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//
import SwiftUI
import Combine

struct PriceInputField: View {
    
    enum Constants {
        static let paddingSmall: CGFloat = 5
        static let frameWidth: CGFloat = 60
    }
    
    @Binding var currencySymbol: String
    @State var placeholderString: String
    @Binding var inputString: String
    @Binding var pointerValue: Int
    var updatePointerValueHandler: (_ value: String) -> Void
    
    var body: some View {
        HStack{
            Text(currencySymbol)
            
            TextField(placeholderString, text: $inputString)
                .keyboardType(.numberPad)
                .padding(.leading, Constants.paddingSmall)
                .frame(width: Constants.frameWidth)
                .background(Color.white)
                .onReceive(Just(inputString)) { value in
                    if let n = NumberFormatter().number(from: value), Int(truncating: n) != pointerValue {
                        updatePointerValueHandler(value)
                    }
                }
        }
    }
}

struct PriceInputField_Previews: PreviewProvider {
    static var previews: some View {
        PriceInputField(
            currencySymbol: Binding.constant("€"),
            placeholderString: "0",
            inputString: Binding.constant("0"),
            pointerValue: Binding.constant(0),
            updatePointerValueHandler: { value in
                print(value)
            }
        )
    }
}
