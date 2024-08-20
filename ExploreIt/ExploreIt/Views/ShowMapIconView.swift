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
            return  Text("🏨")
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
        case "entertainment":
            return Text("🍿")
        case "sport":
            return Text("🏃‍♂️")
        case "leisure":
            return Text("📖")
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
        case "service":
            return Text("🚚")
        case "natural":
            return Text("🌲")
        case "national_park":
            return Text("🏞️")
        case "heritage":
            return Text("🏠")
        case "camping":
            return Text("🏕️")
        case "amenity":
            return Text("🚽")
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
        case "public_transport":
            return Text("🚃")
        case "railway":
            return Text("🚊")
        case "airport":
            return Text("✈️")
        case "highway":
            return Text("🛣️")
        case "parking":
            return Text("🅿️")
        case "man_made":
            return Text("👷‍♂️")
        case "religion":
            return Text("⛪️")
        case "administrative":
            return Text("👨‍💼")
        case "political":
            return Text("🏩")
        case "internet_access":
            return Text("🛜")
        case "wheelchair":
            return Text("♿️")
        case "access":
            return Text("✅")
        case "access_limited":
            return Text("✔️")
        case "no_access":
            return Text("🚫")
        case "fee":
            return Text("🪙")
        case "no_fee":
            return Text("🆓")
        case "named":
            return Text("✉️")
        case "low_emission_zone":
            return Text("🚘")
        case "populated_place":
            return Text("🌆")
        case "postal_code":
            return Text("📮")
        case "adult":
            return Text("🍺")
        default:
            return Text("📍")
        }
    }
}

//#Preview {
//    ShowMapIconView()
//}
