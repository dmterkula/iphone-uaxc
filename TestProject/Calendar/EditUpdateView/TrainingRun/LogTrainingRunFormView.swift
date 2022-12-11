//
//  LogTrainingRunFormView.swift
//  UAXC
//
//  Created by David  Terkula on 12/1/22.
//

import SwiftUI

struct LogTrainingRunFormView: View {
    
    @ObservedObject var viewModel: RunnersTrainingRunFormViewModel
    @Environment(\.dismiss) var dismiss
    let dataService = DataService()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Log your run")
                .font(.title3)
                .padding(.top, 10)
                .padding(.bottom, 20)
            
            MilesPicker(miles: $viewModel.wholeMiles, fractionOfMiles: $viewModel.fractionMiles)
            
            TrainingRunTimePicker(minutes: $viewModel.minutes, seconds: $viewModel.seconds)
        
            HStack {
                Text("Avg. Pace Per Mi: ")
                Text(viewModel.calcAveragePace())
            }
            
            Button() {
                dataService.logTrainingRun(viewModel: viewModel) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                                print(response)
                            
                            case .failure(let error):
                                print(error)
                        }
                    }
                }
                dismiss()
            } label: {
                Text("Log it!")
            }
            
            Spacer()
        }
    }
}

//struct LogTrainingRunFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogTrainingRunFormView()
//    }
//}
