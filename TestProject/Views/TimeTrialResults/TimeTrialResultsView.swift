//
//  SwiftUIView.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import SwiftUI

struct TimeTrialResultsView: View{
    @State var season = ""
    @State var scaleTo5k = false
    @State var timeTrialResultsDTOs: [TimeTrialResultsDTO]?
    
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time Trial Results")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                VStack (alignment: .leading) {
                    HStack {
                        Text("Season: ")
                            .foregroundColor(.white)
                            .font(.title2)
                        TextField("2022", text: $season)
                            .keyboardType(.default)
                            .foregroundColor(.white)
                            .placeholder(when: $season.wrappedValue.isEmpty) {
                                    Text("2022").foregroundColor(.white)
                            }
                            .opacity(0.75)
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    Button(action: {
                        self.scaleTo5k.toggle()
                        },label: {
                            if (self.$scaleTo5k.wrappedValue == true) {
                                Text("Scale to 5k: True")
                            } else {
                                Text("Scale to 5k: False")
                            }
                        }).foregroundColor(.white)
                        .font(.title2)
                }
                
                
                Spacer().frame(minHeight: 20, maxHeight: 30)
                
                
                Button("Get Results") {
                   
                    let dataService = DataService()
                    dataService.fetchTimeTrialResults(season: $season.wrappedValue, scaleTo5k: String($scaleTo5k.wrappedValue)) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                timeTrialResultsDTOs = response
                                case .failure(let error):
                                    print(error)
                            }
                        }
                    }
                    
                }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.title2)
                
                if (timeTrialResultsDTOs != nil && !timeTrialResultsDTOs!.isEmpty) {
                    List {
                        ForEach(timeTrialResultsDTOs!) { result in
                            TimeTrialDTOView(timeTrialDTO: result)
                        }
                    }.onTapGesture {
                        hideKeyboard()
                    }
                }
                
            }
        }

    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialResults()
//    }
//}
