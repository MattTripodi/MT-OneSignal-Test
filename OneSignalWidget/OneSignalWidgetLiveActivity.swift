//
//  OneSignalWidgetLiveActivity.swift
//  OneSignalWidget
//
//  Created by Matthew Tripodi on 1/29/24.
//

// Referenced the OneSignal Sample Project to setup Live Activity

import ActivityKit
import WidgetKit
import SwiftUI

struct OneSignalWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var homeScore: Int
        var awayScore: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    var homeTeam: String
    var awayTeam: String
    var fifaLogo: String
    var sponsorLogo: String
}

struct OneSignalWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OneSignalWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            Text("\(context.state.homeScore)")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                            Text("\(context.attributes.homeTeam)")
                                .font(.caption)
                                .fontWeight(.black)
                        }
                     
                        Spacer()
                        
                        Divider()
                            .background(.white)
                            .frame(width: 35)
                        
                        
                        Spacer()
                        
                        VStack {
                            Text("\(context.state.awayScore)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("\(context.attributes.awayTeam)")
                                .font(.caption)
                                .fontWeight(.black)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(hex: "#04123B"))
                    .foregroundColor(.white)
                    
                    HStack {
                        Image("fifa_logo") // Replace with your actual image asset name
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding([.leading], 20)
                            .padding([.top, .bottom], 2)
                            .frame(width: 15, height: 20, alignment: .topLeading)
                            .background(.clear)
                            .padding(EdgeInsets())
                        
                        
                        Spacer()
                        
                        Image("cocacola_logo") // Replace with your actual image asset name
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding([.trailing], 20)
                            .padding([.top, .bottom], 2)
                            .frame(width: 15, height: 20, alignment: .topTrailing)
                            .background(.clear)
                            .padding(EdgeInsets())
                    }
                    .padding(.bottom)
                    .background(Color.white)
                }
            }
            
            
        } dynamicIsland: { context in
            DynamicIsland {

                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .center) {
                        Text("\(context.state.homeScore)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("\(context.attributes.homeTeam)")
                            .font(.caption)
                    }
                    .padding()
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Text("\(context.state.awayScore)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("\(context.attributes.awayTeam)")
                            .font(.caption)
                    }.padding()
                }
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        Divider()
                    }
                }
            } compactLeading: {
                Text("\(context.state.homeScore) to \(context.state.awayScore)")
                    .padding()
            } compactTrailing: {
                Text("\(context.attributes.awayTeam)")
                    .padding()
            } minimal: {
                Text("Mini")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // Skip the hash sign if present
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

extension OneSignalWidgetAttributes {
    fileprivate static var preview: OneSignalWidgetAttributes {
        OneSignalWidgetAttributes(name: "Italy vs. Germany", homeTeam: "Italy", awayTeam: "Germany", fifaLogo: "fifa_logo", sponsorLogo: "cocacola_logo")
    }
}

extension OneSignalWidgetAttributes.ContentState {
    fileprivate static var smiley: OneSignalWidgetAttributes.ContentState {
        OneSignalWidgetAttributes.ContentState(homeScore: 7, awayScore: 1)
     }
    
}

#Preview("Expanded Dynamic Island", as: ActivityPreviewViewKind.dynamicIsland(.expanded), using: OneSignalWidgetAttributes.preview) {
   OneSignalWidgetLiveActivity()
} contentStates: {
    OneSignalWidgetAttributes.ContentState.smiley
}
