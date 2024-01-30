//
//  OneSignalWidgetBundle.swift
//  OneSignalWidget
//
//  Created by Matthew Tripodi on 1/29/24.
//

import WidgetKit
import SwiftUI

@main
struct OneSignalWidgetBundle: WidgetBundle {
    var body: some Widget {
        OneSignalWidget()
        OneSignalWidgetLiveActivity()
    }
}
