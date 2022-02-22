//
//  RangeSlider.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//
import SwiftUI

struct RangeSlider: View {
    
    enum Constants {
        static let frameHeight: CGFloat = 2
        static let opacityValue: CGFloat = 0.5
        static let paddingSmall: CGFloat = 10
        static let paddingLarge: CGFloat = 20
        static let offsetValue: CGFloat = 18
    }
    
    @Binding var leftPointer: CGFloat
    @Binding var rightPointer: CGFloat
    var onLeftPointerChangeHandler: (_ newPointerLocation: CGFloat) -> Void
    var onRightPointerChangeHandler: (_ newPointerLocation: CGFloat) -> Void
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.black.opacity(Constants.opacityValue))
                    .frame(height: Constants.frameHeight)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: rightPointer - leftPointer, height: Constants.frameHeight)
                    .offset(x: leftPointer + Constants.paddingSmall)
                
                sliderCircles
            }
        }
        .padding(EdgeInsets(top: Constants.paddingSmall, leading: Constants.paddingSmall, bottom: Constants.paddingLarge, trailing: Constants.paddingSmall))
    }
    
    private var sliderCircles: some View {
        HStack(spacing: .zero){
            SliderCircle(
                xOffset: $leftPointer,
                onChangeHandler: { newPointerLocation in
                    self.onLeftPointerChangeHandler(newPointerLocation)
                }
            )
            
            SliderCircle(
                xOffset: $rightPointer,
                onChangeHandler: { newPointerLocation in
                    self.onRightPointerChangeHandler(newPointerLocation)
                }
            )
        }
    }
}

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RangeSlider(
            leftPointer: Binding.constant(0),
            rightPointer: Binding.constant(20),
            onLeftPointerChangeHandler: { newPointerLocation in
                print(newPointerLocation)
            },
            onRightPointerChangeHandler: { newPointerLocation in
                print(newPointerLocation)
            }
        )
    }
}
