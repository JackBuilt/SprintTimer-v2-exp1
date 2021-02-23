//
//  AddItemView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var sprintTimer: SprintTimer
    
    private var items = [SprintTimerItem]()
    
    init(_ timer: SprintTimer) {
        self.sprintTimer = timer

        /// Loading static data from here for now.
        items.append(SprintTimerItem(.warmup, 0))
        items.append(SprintTimerItem(.easyPace, 0))
        items.append(SprintTimerItem(.mediumPace, 0))
        items.append(SprintTimerItem(.fastPace, 0))
        items.append(SprintTimerItem(.sprint, 0))
        items.append(SprintTimerItem(.cooldown, 0))
    }
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding(5)
                    })
                }
                HStack {
                    Text("Interval Selection")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            }
            
            List {
                ForEach(items) { item in
                    Button(action: {
                        sprintTimer.items.append(item)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("\(TimerType.displayName(item.type))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("SprintTimerLabelColor"))
                    })
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Section {
                
            }
        }

    }
    
    
    
//    func loadItemArray() -> [SprintTimerItem] {
//        /// Loading static data from here for now.
//        var items = [SprintTimerItem]()
//        items.append(SprintTimerItem(.warmup, 0))
//        items.append(SprintTimerItem(.easyPace, 0))
//        items.append(SprintTimerItem(.mediumPace, 0))
//        items.append(SprintTimerItem(.fastPace, 0))
//        items.append(SprintTimerItem(.sprint, 0))
//        items.append(SprintTimerItem(.cooldown, 0))
//        return items
//    }
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(SprintTimer())
    }
}
