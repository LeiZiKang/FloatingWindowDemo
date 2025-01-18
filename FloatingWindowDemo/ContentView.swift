//
//  ContentView.swift
//  FloatingWindowDemo
//
//  Created by Lei Levi on 19/1/2025.
//

import SwiftUI
import UIKit
import ZKFloatingWindow

struct ContentView: View {
    @State private var showFloatingWindow = false
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink("SecondView") {
                    SecondView()
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // Test whether click events can be transmitted normally
                print("click screen")
            })
            .floatingWindow(show: $showFloatingWindow) {
                FloatView(viewModel: viewModel)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onAppear {
            showFloatingWindow = true
        }
    }
}

struct FloatView: View {
    var viewModel: ViewModel
    let screen: (width: CGFloat, height: CGFloat) = (UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    var body: some View {
        HStack {
            
            Text("count: \(viewModel.count)")
                .font(.title2)
                .bold()
                .foregroundStyle(.orange)
                .padding()
            
            Spacer()
            
            Button {
                viewModel.count += 1
                print("count times: \(viewModel.count)")
            } label: {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                    .overlay(content: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    })
                    .padding()
            }
        }
        .frame(width: screen.width)
    }
}

struct SecondView: View {
    var body: some View {
        Text("SecontView")
    }
}

@Observable
class ViewModel {
    var count = 0
}

#Preview {
    RootView {
        ContentView()
    }
}
