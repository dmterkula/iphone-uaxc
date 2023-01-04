//
//  AchievementRow.swift
//  UAXC
//
//  Created by David  Terkula on 1/3/23.
//

import SwiftUI

struct AchievementRow: View {
    
    var achievement1: Achievement?
    var achievement2: Achievement?
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                VStack {
                    if (achievement1 != nil) {
                        Image(achievement1!.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150, maxHeight: 150)

                        Text(achievement1!.description)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                        Text(achievement1!.displayValueString())
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                    } else {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                VStack {
                    if (achievement2 != nil) {
                        Image(achievement2!.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150, maxHeight: 150)

                        Text(achievement2!.description)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                        Text(achievement2!.displayValueString())
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                    } else {
                       Rectangle()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
            }
            
            CustomDivider(color: GlobalFunctions.uaGreen(), height: 2)
            
        }
      
    }
}

struct UnMetAchievementRow: View {
    
    var achievement1: Achievement?
    var achievement2: Achievement?
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                VStack {
                    if (achievement1 != nil) {
                        Image(achievement1!.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .grayscale(0.9995)

                        Text(achievement1!.description)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                        Text(achievement1!.displayValueString())
                            .multilineTextAlignment(.center)
                    } else {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                VStack {
                    if (achievement2 != nil) {
                        Image(achievement2!.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .grayscale(0.9995)

                        Text(achievement2!.description)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                        Text(achievement2!.displayValueString())
                            .multilineTextAlignment(.center)
                    } else {
                        Rectangle()
                            .frame(maxWidth: 150, maxHeight: 150)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
            }
            
            CustomDivider(color: GlobalFunctions.uaGreen(), height: 2)
            
        }
      
    }
}

//
//struct AchievementRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AchievementRow()
//    }
//}
