//
//  picker.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import Foundation
import UIKit
import SwiftUI


enum Picker{
    enum Source: String{
        case library, camera
    }
    
    static func checkPermission() -> Bool{
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            return true
        }
        return false
        
    }
    
}
