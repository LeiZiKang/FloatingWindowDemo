//
//  ContentView.swift
//  FloatingWindowDemo
//
//  Created by Lei Levi on 19/1/2025.
//

import SwiftUI
import ZKFloatingWindow

struct ContentView: View {
    @State private var showFloatingWindow = false
    @State private var viewModel = HitViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink("SecondView") {
                    SecondView()
                }
            }
            .padding()
            .contentShape(Rectangle())
        }
        .onTapGesture(perform: {
            print("click screen")
        })
        .floatingWindow(show: $showFloatingWindow) {
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
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
            }

        }
        .onAppear {
            showFloatingWindow = true
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("SecontView")
    }
}

@Observable
class HitViewModel {
    var count = 0
}

public struct RoundRectangleButton: View {
    let label: String
    let color: Color
    public init (label: String, color: Color) {
        self.label = label
        self.color = color
    }
    public var body: some View {
        Text(label)
            .font(.system(size: 14, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(5)
    }
}
#Preview {
    RootView {
        ContentView()
    }
}
