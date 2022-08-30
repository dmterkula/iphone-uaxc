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

//struct Extension_Previews: PreviewProvider {
//    static var previews: some View {
//        Extension()
//    }
//}
