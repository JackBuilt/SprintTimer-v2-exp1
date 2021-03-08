//
//  TimerButton.swift
//  AdvancedTimerExample
//
//  Created by Jack Smith on 2/11/21.
//

import SwiftUI

struct TimerButton: View {
    let label: String
    var buttonColor: gradientColors
    var buttonWidth: CGFloat = 150
    var disabled: Bool = false
    
    var body: some View {
        
        ZStack {
            Capsule()
                .fill(Color("ButtonBorderColor"))
                .frame(width: buttonWidth + 5, height: 55)
            Capsule()
                .fill(getGradientColor(buttonColor))
                .frame(width: buttonWidth, height: 50)
                .transition(.opacity)
            
            Text(label)
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.bold)
            
            if disabled {
                Capsule()
                    .fill(Color.black)
                    .frame(width: buttonWidth + 5, height: 55)
                    .opacity(0.5)
            }
        }
        
    }
    
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(label: "Start", buttonColor: .purple)
            .preferredColorScheme(.dark)
    }
}
