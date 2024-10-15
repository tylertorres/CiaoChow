//
//  AsyncViewTesting.swift
//  CiaoChow
//
//  Created by Tyler Torres on 10/14/24.
//

import SwiftUI
import AsyncAlgorithms

@MainActor
class AsyncViewModel: ObservableObject {
    
    @Published var redCounter: Int = 0
    @Published var blueCounter: Int = 0
    
    private var blueChannel = AsyncChannel<Int>()
    private var redChannel = AsyncChannel<Int>()
    
    init() {
        configureSubscriptions()
    }
    
    func incrementBlue() {
        Task {
            await blueChannel.send(blueCounter + 1)
        }
    }
    
    func incrementRed() {
        Task {
            await redChannel.send(redCounter + 1)
        }
    }
    
    private func configureSubscriptions() {
        Task { await handleRedButtonValues() }
        Task { await handleBlueButtonValues() }
    }
    
    private func handleRedButtonValues() async {
        for try await count in redChannel._throttle(for: .seconds(0.05), latest: true) {
            self.redCounter = count
        }
    }
    
    private func handleBlueButtonValues() async {
        for try await count in blueChannel._throttle(for: .seconds(0.05), latest: true) {
            self.blueCounter = count
        }
    }
    
}

struct AsyncView: View {
    
    @StateObject private var viewModel: AsyncViewModel = AsyncViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.blue.gradient)
                        .frame(width: 150, height: 150)
                    Text("\(viewModel.blueCounter)")
                        .foregroundStyle(.white)
                }
                Divider()
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.red.gradient)
                        .frame(width: 150, height: 150)
                    Text("\(viewModel.redCounter)")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            
            Spacer()
            
            HStack {
                
                Button {
                    viewModel.incrementRed()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(.red)
                        Text("Press For Red")
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .frame(width: 100, height: 100)
                
                Button {
                    viewModel.incrementBlue()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(.blue)
                        Text("Press For Blue")
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .frame(width: 100, height: 100)
                
                Button {
                    viewModel.incrementRed()
                    viewModel.incrementBlue()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(.purple)
                        Text("Press For Purple")
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .frame(width: 100, height: 100)
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AsyncView()
}
