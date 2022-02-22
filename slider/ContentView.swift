//
//  ContentView.swift
//  slider
//
//  Created by Mishra, Saurabh on 21/02/22.
//

import SwiftUI

struct ContentView: View {
    @State var isSheet = false
    var body: some View {
        VStack {
            Button {
                isSheet.toggle()
            } label: {
                Text("TAP ME")
            }

        }
        .sheet(isPresented: $isSheet) {
            PriceFilterView(
                viewModel: PriceFilterViewModel(priceLowerLimit: 0, priceUpperLimit: 500),
                currencySymbol: Binding.constant("€"))        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
