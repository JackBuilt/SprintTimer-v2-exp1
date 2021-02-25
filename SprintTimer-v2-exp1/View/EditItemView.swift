//
//  EditItemView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

struct EditItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var item: SprintTimerItem
    
    @State private var timePicked: [Int] = []
    @Binding var isChanged: Bool
    
    init(_ item: SprintTimerItem, _ isChanged: Binding<Bool>) {
        self.item = item
        self._isChanged = isChanged
        self._timePicked = State(
            initialValue: convertTimerPickerArray(item.duration))
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
                    Text("Edit Interval Duration")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            }
            
            List {
                HStack {
                    Spacer()
                    Text("\(TimerType.displayName(item.type))")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                Section {
                    HStack {
                        Spacer()
                        MainPicker(pickerSelections: self.$timePicked)
                            .frame(width: 225, height: 100)
                        Spacer()
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        TimerButton(
                            label: "Save",
                            buttonColor: .green,
                            buttonWidth: 150)
                            .onTapGesture {
                                item.duration = convertTimerPickerArray(timePicked)
                                self.isChanged = true
                                presentationMode.wrappedValue.dismiss()
                            }
                        Spacer()
                    }
                }
                .padding(20)
                
            }
            //.listStyle(InsetGroupedListStyle())
            
        }
        
    }
    
    
    func convertTimerPickerArray(_ array: [Int]) -> Int {
        /// This will convert the hours, minutes, seconds array to total seconds.
        var output: Int = 0
        /// Hours
        output += array[0]*3600
        /// Minutes
        output += array[1]*60
        /// Seconds
        output += array[2]
        return output
    }
    
    func convertTimerPickerArray(_ seconds: Int) -> [Int] {
        /// This will convert total seconds to an hours, minutes, seconds aray.
        let array: [Int] = [seconds/3600, seconds/60%60, seconds%60]
        return array
    }
    
}

//struct EditItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditItemView(SprintTimerItem(), <#Binding<Bool>#>)
//    }
//}
