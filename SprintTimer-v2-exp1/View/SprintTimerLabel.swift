//
//  SprintTimerLabel.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

struct SprintTimerLabel: View {
    
    var name: String
    var value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(name)")
                .font(.title2)
            
            Spacer()
            
            Text("\(value)")
                .font(.custom("Avenir", size: 20))
                .fontWeight(.bold)
                //.foregroundColor(valueColor)
        }
        .multilineTextAlignment(.center)
    }
}

//struct SprintTimerLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintTimerLabel()
//    }
//}
