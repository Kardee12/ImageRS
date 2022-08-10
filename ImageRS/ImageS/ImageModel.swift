//
//  ImageModel.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import Foundation
import SwiftUI

class ImageModel: ObservableObject{
    
    @Published var image: UIImage!
    @Published var showPicker: Bool = false
    @Published var source: Picker.Source = .library
    
    func showPPicker(){
        if source == .camera{
            if !Picker.checkPermission(){
                print("Cannot use camera")
                return
            }
        }
        
        showPicker = true
    }
}
