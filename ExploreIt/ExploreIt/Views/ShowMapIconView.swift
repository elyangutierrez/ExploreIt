//
//  ShowMapIconView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/19/24.
//

import SwiftUI

struct ShowMapIconView: View {
    
    var catagory: String
    
    var body: some View {
        switch catagory {
        case "accommodation":
            return Text("🏨")
        case "rental":
            return Text("🚗")
        case "hotel":
            return Text("🏩")
        case "catering":
            return Text("🍴")
        case "food":
            return Text("🍽️")
        case "activity":
            return Text("🏃")
        case "ski":
            return Text("⛷️")
        case "tourism":
            return Text("🚶")
        case "healthcare":
            return Text("🏥")
        case "education":
            return Text("✏️")
        case "childcare":
            return Text("🏫")
        case "natural":
            return Text("🌲")
        case "national_park":
            return Text("🏞️")
        case "camping":
            return Text("🏕️")
        case "beach":
            return Text("🏖️")
        case "pet":
            return Text("🐕")
        case "commercial":
            return Text("🏪")
        case "office":
            return Text("🏢")
        case "production":
            return Text("🏭")
        case "building":
            return Text("🏬")
        case "railway":
            return Text("🚊")
        case "airport":
            return Text("✈️")
        case "highway":
            return Text("🛣️")
        case "parking":
            return Text("🅿️")
        case "religion":
            return Text("⛪️")
        case "internet_access":
            return Text("🛜")
        case "wheelchair":
            return Text("♿️")
        case "adult":
            return Text("🍺")
        default:
            return Text("📍")
        }
    }
}

#Preview {
    ShowMapIconView(catagory: "no_fee")
}
