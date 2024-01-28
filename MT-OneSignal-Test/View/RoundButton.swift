//
//  RoundButton.swift
//  MT-OneSignal-Test
//
//  Created by Matthew Tripodi on 1/28/24.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.8949897885, green: 0.2875944376, blue: 0.2848131657, alpha: 1)
    }
    
}
