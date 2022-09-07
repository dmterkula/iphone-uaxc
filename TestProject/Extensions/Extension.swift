//
//  Extension.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI

//struct Extension: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

//extension Array {
// 
//    func anySatisfy(condition: Bool) -> Bool {
//        
//        ForEach(self) { elem in
//            if
//        }
//        
//    }
//    
//}

//struct Extension_Previews: PreviewProvider {
//    static var previews: some View {
//        Extension()
//    }
//}


