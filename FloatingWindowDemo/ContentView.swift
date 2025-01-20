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
                
                Button("Change State") {
                    viewModel.state.toggle()
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // Test whether click events can be transmitted normally
                print("click screen")
            })
            .floatingWindow(show: $showFloatingWindow) {
                FloatView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .environment(\.viewModel, viewModel)
            }
        }
        .sheet(isPresented: $viewModel.show) {
            Text("Hello")
        }

        .onAppear {
            showFloatingWindow = true
        }
    }
}

struct FloatView: View {
    @Environment(\.viewModel) var viewModel: ViewModel
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
                    .fill(viewModel.compSatet ? .blue : .gray)
                    .frame(width: 80, height: 80)
                    .overlay(content: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    })
                    .padding()
            }
        }
        .frame(width: screen.width)
        HStack {
            Button("Open Sheet") {
                viewModel.show.toggle()
            }
            
        }
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
    var show = false
    var state = false
    var compSatet: Bool {
        state
    }
}

struct ViewModelEnvironmentKey: EnvironmentKey {
    static let defaultValue: ViewModel = .init()
}

extension EnvironmentValues {
    @Entry var viewModel: ViewModel = .init()
}
#Preview {
    RootView {
        ContentView()
    }
}
