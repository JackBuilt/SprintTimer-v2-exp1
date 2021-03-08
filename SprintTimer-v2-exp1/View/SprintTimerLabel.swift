//
//  SprintTimerLabel.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

struct SprintTimerLabel: View {
    
    private var name: String
    private var nameColor: Color
    private var value: String
    private var valueColor: Color
    private var altText: String
    private var altTextColor: Color
    private var colorSwatch: Color
    private var isSmallDisplay: Bool
    
    private var fontSize: Font {isSmallDisplay ? .callout : .title2 }
    private var altFontSize: Font {isSmallDisplay ? .footnote : .body }
    
    private var iconTrailing: String
    private var iconTrailingColor: Color
    
    init(name: String, value: String, altText: String = "",
         nameColor: Color = Color("SprintTimerLabelColor"),
         valueColor: Color = Color("SprintTimerLabelColor"),
         altTextColor: Color = Color("SprintTimerLabelColor"),
         colorSwatch: Color = Color.clear,
         iconTrailing: String = "",
         iconTrailingColor: Color = Color("SprintTimerLabelColor"),
         smallDisplay: Bool = false) {
        self.name = name
        self.value = value
        self.altText = altText
        self.nameColor = nameColor
        self.valueColor = valueColor
        self.altTextColor = altTextColor
        self.colorSwatch = colorSwatch
        self.isSmallDisplay = smallDisplay
        
        self.iconTrailing = iconTrailing
        self.iconTrailingColor = iconTrailingColor
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
            
            
            if self.iconTrailing != "" {
                Image(systemName: self.iconTrailing)
                    .font(.system(size: 26))
                    .foregroundColor(self.iconTrailingColor)
                    .frame(minWidth: 60, alignment: .trailing)
            }
            else {
                /// Value label
                Text("\(value)")
                    .font(.custom("Avenir", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(valueColor)
                    .frame(minWidth: 60, alignment: .trailing)
            }
        }
        .multilineTextAlignment(.center)
    }
}

//struct SprintTimerLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintTimerLabel()
//    }
//}
