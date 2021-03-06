//
//  SprintTimerLabel.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

struct SprintTimerLabel: View {
    
    private var name: String
    private var nameColor: Color = Color("SprintTimerLabelColor")
    private var value: String
    private var valueColor: Color = Color("SprintTimerLabelColor")
    private var altText: String = ""
    private var altTextColor: Color = Color("SprintTimerLabelColor")
    
    private var colorSwatch: Color = Color.clear
    private var isSmallDisplay: Bool = false
    private var fontSize: Font {isSmallDisplay ? .callout : .title2 }
    private var altFontSize: Font {isSmallDisplay ? .footnote : .body }
    
    
    init(name: String, value: String,
         nameColor: Color = Color("SprintTimerLabelColor"),
         valueColor: Color = Color("SprintTimerLabelColor"),
         colorSwatch: Color = Color.clear,
         smallDisplay: Bool = false) {
        self.name = name
        self.value = value
        self.nameColor = nameColor
        self.valueColor = valueColor
        self.colorSwatch = colorSwatch
        self.isSmallDisplay = smallDisplay
    }
    
    init(name: String, value: String, altText: String,
         nameColor: Color = Color("SprintTimerLabelColor"),
         valueColor: Color = Color("SprintTimerLabelColor"),
         altTextColor: Color = Color("SprintTimerLabelColor"),
         colorSwatch: Color = Color.clear,
         smallDisplay: Bool = false) {
        self.name = name
        self.value = value
        self.altText = altText
        self.nameColor = nameColor
        self.valueColor = valueColor
        self.altTextColor = altTextColor
        self.colorSwatch = colorSwatch
        self.isSmallDisplay = smallDisplay
    }
    
    
    var body: some View {
        HStack(alignment: .center) {
            /// Color swatch
            if colorSwatch != Color.clear {
                Rectangle()
                    .fill(colorSwatch)
                    .frame(width: 7, height: 25)
                    .padding(.trailing, 5)
            }
            /// Primary label
            Text("\(name)")
                .font(fontSize)
                .foregroundColor(nameColor)
            
            Spacer()
            /// Secondaty label
            if altText != "" {
                Text(" \(altText)")
                    .font(altFontSize)
                    .foregroundColor(altTextColor)
                    //.background(Color(.gray))   // Comment
            }
            
            /// Value label
            Text("\(value)")
                .font(.custom("Avenir", size: 20))
                .fontWeight(.bold)
                .foregroundColor(valueColor)
                .frame(minWidth: 60, alignment: .trailing)
                //.background(Color(.gray))   // Comment
        }
        .multilineTextAlignment(.center)
    }
}

//struct SprintTimerLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintTimerLabel()
//    }
//}
