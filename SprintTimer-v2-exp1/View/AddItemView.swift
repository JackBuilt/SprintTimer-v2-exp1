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
    @Binding var isChanged: Bool
    
    init(_ timer: SprintTimer, _ isChanged: Binding<Bool>) {
        self.sprintTimer = timer
        self._isChanged = isChanged

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
                    Text("Add Interval Type")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            }
            
            List {
                ForEach(items) { item in
                    /// Save
                    Button(action: {
                        sprintTimer.items.append(item)
                        self.isChanged = true
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

//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView(SprintTimer())
//    }
//}
