//
//  Extensions.swift
//  Meditation
//
//  Created by Alan on 7/4/22.
//

import Foundation

extension DateComponentsFormatter {
    static let abbreviated: DateComponentsFormatter = {
        print("Inititzaling datecompenentformatter abbreeivated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    static let positional: DateComponentsFormatter = {
        print("Inititzaling datecompenentformatter positional")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()

}
