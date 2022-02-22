//
//  PriceFilterView.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//
import SwiftUI

struct PriceFilterView: View {
    
    enum Constants {
        static let rotationAngle: CGFloat = 180
        static let paddingSmall: CGFloat = 10
        static let paddingLarge: CGFloat = 20
        static let cornerRadius: CGFloat = 15
    }
    
    @ObservedObject var viewModel: PriceFilterViewModel
    @State private var collapsed: Bool = true
    @Binding var currencySymbol: String
    
    @State private var currentHeight = CGFloat(150)
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                VStack{
                    ZStack{
                        Color.white
                        priceFilterLabel
                    }
                    .onTapGesture {
                        self.collapsed.toggle()
                    }
                    if !collapsed {
                        priceFilterCollapsible
                    }
                }
                .onRotate { _ in
                    DispatchQueue.main.async {
                        self.viewModel.configureSlider(width: geometry.size.width)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: .zero, leading: Constants.paddingSmall, bottom: .zero, trailing: Constants.paddingSmall))
                .background(GeometryReader { gp -> Color in
                    DispatchQueue.main.async {
                        self.currentHeight = gp.size.height
                    }
                    return Color.clear
                })
                .onAppear {
                    self.viewModel.configureSlider(width: geometry.size.width)
                }
            }
        }
        .frame(height: currentHeight)
    }
    
    private var priceFilterLabel: some View {
        HStack{
            viewModel.isPriceFilterActivated ? Text(NSLocalizedString("Price", comment: "").uppercased()).bold() : Text(NSLocalizedString("Price", comment: "").uppercased())
            
            SwiftUI.Spacer()
            
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(collapsed ? .zero : Constants.rotationAngle))
        }
    }
    
    private var priceFilterCollapsible: some View {
        ZStack{
            Color(.systemGray6)
            VStack{
                priceInputsBar
            
                RangeSlider(
                    leftPointer: $viewModel.leftPointer,
                    rightPointer: $viewModel.rightPointer,
                    onLeftPointerChangeHandler: { newPointerLocation in
                        viewModel.updateLeftPointer(to: newPointerLocation)
                    },
                    onRightPointerChangeHandler: { newPointerLocation in
                        viewModel.updateRightPointer(to: newPointerLocation)
                    }
                )
            }
        }
        .cornerRadius(Constants.cornerRadius)
    }
    
    private var priceInputsBar: some View {
        HStack(spacing: Constants.paddingLarge){
            SwiftUI.Spacer()
            
            PriceInputField(
                currencySymbol: $currencySymbol,
                placeholderString: Int(viewModel.priceLowerLimit).description,
                inputString: $viewModel.leftPointerCurrencyString,
                pointerValue: $viewModel.leftPointerCurrencyValue,
                updatePointerValueHandler: { value in
                    viewModel.updateLeftPointerCurrencyValue(to: value)
                }
            )
            
            Text("-")
            
            PriceInputField(
                currencySymbol: $currencySymbol,
                placeholderString: Int(viewModel.priceUpperLimit).description,
                inputString: $viewModel.rightPointerCurrencyString,
                pointerValue: $viewModel.rightPointerCurrencyValue,
                updatePointerValueHandler: { value in
                    viewModel.updateRightPointerCurrencyValue(to: value)
                }
            )
            
            SwiftUI.Spacer()
        }
        .padding(EdgeInsets(top: Constants.paddingLarge, leading: .zero, bottom: Constants.paddingSmall, trailing: .zero))
    }
}

struct PriceFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PriceFilterView(
            viewModel: PriceFilterViewModel(priceLowerLimit: 0, priceUpperLimit: 500),
            currencySymbol: Binding.constant("€"))
    }
}
