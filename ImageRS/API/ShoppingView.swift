//
//  ShoppingView.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/10/22.
//

import SwiftUI

struct ShoppingView: View {
    var strNam: String
    var body: some View {
        Text(strNam.uppercased())
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(strNam: "laptop")
    }
}
