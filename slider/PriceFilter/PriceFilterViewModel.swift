//
//  PriceFilterViewModel.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//
import Foundation
import SwiftUI

class PriceFilterViewModel: ObservableObject {
    
    enum Constants {
        static let widthOffset: CGFloat = 76
    }
    
    let priceLowerLimit: CGFloat
    let priceUpperLimit: CGFloat
    private var totalWidth: CGFloat = UIScreen.main.bounds.width - Constants.widthOffset
    
    @Published var isPriceFilterActivated: Bool = false
    
    @Published var leftPointer: CGFloat
    @Published var rightPointer: CGFloat
    
    @Published var leftPointerCurrencyString: String
    @Published var leftPointerCurrencyValue: Int
    
    @Published var rightPointerCurrencyString: String
    @Published var rightPointerCurrencyValue: Int
    
    init(
        priceLowerLimit: CGFloat,
        priceUpperLimit: CGFloat
    ) {
        self.priceLowerLimit = priceLowerLimit
        self.priceUpperLimit = priceUpperLimit
        
        self.leftPointer = .zero
        self.rightPointer = totalWidth
        
        self.leftPointerCurrencyString = Int(priceLowerLimit).description
        self.leftPointerCurrencyValue = Int(priceLowerLimit)
        
        self.rightPointerCurrencyString = Int(priceUpperLimit).description
        self.rightPointerCurrencyValue = Int(priceUpperLimit)
    }
    
    func configureSlider(width: CGFloat) {
        totalWidth = width - Constants.widthOffset
        
        moveLeftPointer(to: valueToPointer(leftPointerCurrencyValue))
        moveRightPointer(to: valueToPointer(rightPointerCurrencyValue))
    }
    
    private func activatePriceFilter() {
        if !isPriceFilterActivated {
            isPriceFilterActivated = true
        }
    }
    
    private func moveLeftPointer(to position: CGFloat) {
        leftPointer = position
    }
    
    private func moveRightPointer(to position: CGFloat) {
        rightPointer = position
    }
    
    func updateLeftPointer(to position: CGFloat) {
        if position >= 0 && position <= rightPointer {
            moveLeftPointer(to: position)
            changeLeftPointerCurrency(to: pointerToValue(position))
            activatePriceFilter()
        }
    }
    
    func updateRightPointer(to position: CGFloat) {
        if position >= leftPointer && position <= totalWidth {
            moveRightPointer(to: position)
            changeRightPointerCurrency(to: pointerToValue(position))
            activatePriceFilter()
        }
    }
    
    private func changeLeftPointerCurrency(to value: Int) {
        leftPointerCurrencyString = value.description
        leftPointerCurrencyValue = value
    }
    
    private func changeRightPointerCurrency(to value: Int) {
        rightPointerCurrencyString = value.description
        rightPointerCurrencyValue = value
    }
    
    func updateLeftPointerCurrencyValue(to value: String) {
        guard let n = NumberFormatter().number(from: value) else {
            return
        }
        
        let numericalValue: Int = Int(truncating: n)
        
        if numericalValue >= Int(priceLowerLimit) && numericalValue <= Int(rightPointerCurrencyValue) {
            changeLeftPointerCurrency(to: numericalValue)
            moveLeftPointer(to: valueToPointer(numericalValue))
            activatePriceFilter()
        }
    }
    
    func updateRightPointerCurrencyValue(to value: String) {
        guard let n = NumberFormatter().number(from: value) else {
            return
        }
        
        let numericalValue: Int = Int(truncating: n)
        
        if numericalValue >= Int(leftPointerCurrencyValue) && numericalValue <= Int(priceUpperLimit) {
            changeRightPointerCurrency(to: numericalValue)
            moveRightPointer(to: valueToPointer(numericalValue))
            activatePriceFilter()
        }
    }
    
    private func valueToPointer(_ value: Int) -> CGFloat {
        return totalWidth * (CGFloat(value) - priceLowerLimit) / (priceUpperLimit - priceLowerLimit)
    }
    
    private func pointerToValue(_ pointer: CGFloat) -> Int {
        return Int(((priceUpperLimit - priceLowerLimit) * pointer / totalWidth) + priceLowerLimit)
    }
}
