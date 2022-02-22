//
//  SliderCircle.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//
import SwiftUI

struct SliderCircle: View {
    
    enum Constants {
        static let frameDimension: CGFloat = 18
    }
    
    @Binding var xOffset: CGFloat
    var onChangeHandler: (_ newPointerLocation: CGFloat) -> Void
    
    var body: some View {
        Circle()
            .strokeBorder(Color.black)
            .background(Circle().foregroundColor(Color.white))
            .frame(width: Constants.frameDimension, height: Constants.frameDimension)
            .offset(x: xOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let newPointerLocation = value.location.x
                        onChangeHandler(newPointerLocation)
                    })
            )
    }
}

struct SliderCircle_Previews: PreviewProvider {
    static var previews: some View {
        SliderCircle(
            xOffset: Binding.constant(0),
            onChangeHandler: { newPointerLocation in
                print(newPointerLocation)
            }
        )
    }
}
