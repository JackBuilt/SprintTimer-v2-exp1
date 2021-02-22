//
//  TimerEditView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case addItem, editItem
    
    var id: Int {
        hashValue
    }
}


struct TimerEditView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var timerDataController: SprintTimerDataController = SprintTimerDataController()
    @ObservedObject var sprintTimer: SprintTimer
    
    //@State private var selectedItem: SprintTimerItem = SprintTimerItem()
    @Environment(\.editMode) private var editMode: Binding<EditMode>?
    @State private var showItemView: ActiveSheet?
    @State private var showDeleteAlert: Bool = false
    private var isNew: Bool
    
    
    
    init(_ sprintTimer: SprintTimer, newTimer: Bool = false)
    {
        self.sprintTimer = sprintTimer
        self.isNew = newTimer
    }
    
    
    
    var body: some View {
        
        VStack {
            
            /// TIMER TITLE
            HStack {
                Spacer()
                Text("\(sprintTimer.name)")
                    .font(.title2)
                    .foregroundColor(.orange)
                    .padding(10)
                Spacer()
            }
            
            
            /// ITEMS ARRAY LIST
            List {
                ForEach(sprintTimer.items) { item in
                    Button(action: {
                        /// go to edit item view.
                        showItemView = .editItem
                    }, label: {
                        getTimerItemLabel(timer: item)
                    })
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    ///EditButton()  /// EditButton() by default cancels reorder of list when done.
                    EditButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    AddButton
                }
            }
            .navigationBarTitle(viewRouter.newTimer ? "New Timer" : "Edit Timer",
                                displayMode: .inline)
            .onDisappear(perform: {
                /// Reset the isNew flag in viewRouter. This works but maybe there is a better way?
                viewRouter.newTimer = false
            })
            .sheet(item: $showItemView) { item in
                switch item {
                case .editItem:
                    EditItemView()
                case .addItem:
                    AddItemView()
                }
                    //.onDisappear(perform: updateItemsList)
            }
            /// Action sheet: DELETE ALERT
            .actionSheet(isPresented: $showDeleteAlert, content: {
                ActionSheet(
                    title: Text("Delete Timer?"),
                    message: Text("Are you sure you want to delete this timer?"),
                    buttons: [
                        .cancel(),
                        //.default(Text("Action")),
                        .destructive(Text("Delete"),
                                     action: deleteTimer)
                    ]
                )
            })
            
            
            /// BUTTONS
            Section {
                HStack {
                    /// Delete timer
                    Spacer()
                    TimerButton(
                        label: "Delete",
                        buttonColor: .red,
                        buttonWidth: 150,
                        disabled: isNew)
                        .onTapGesture {
                            if !isNew {
                                self.showDeleteAlert = true
                            }
                        }
                    Spacer()
                    /// Save timer
                    TimerButton(
                        label: "Save",
                        buttonColor: .green,
                        buttonWidth: 150)
                        .onTapGesture {
                            saveTimerData()
                        }
                    Spacer()
                }
            }
            .padding(20)
        }
        
    }
    
    
    private var EditButton: some View {
        return AnyView(
            Button(action: {
                self.editMode?.wrappedValue.toggle()
            }) {
                Text(self.editMode?.wrappedValue == .active ? "Done" : "Edit")
            }
        )
    }
    
    private var BackButton: some View {
        return AnyView(
            Button(action: {
                viewRouter.currentPage = isNew ? .timerSelectView : .timerDetailView
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.backward.square.fill")
                }
            }
        )
    }
    
    private var AddButton: some View {
        return AnyView(
            Button(action: {
                showItemView = .addItem
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "plus.square.fill")
                }
            }
        )
    }
    
    
//    private func onAdd() {
//        let test = SprintTimerItem()
//        test.type = .fastPace
//        test.duration = 180
//        sprintTimer.items.append(test)
//    }
    
    private func onDelete(offsets: IndexSet) {
        sprintTimer.items.remove(atOffsets: offsets)
    }

    private func onMove(source: IndexSet, destination: Int) {
        sprintTimer.items.move(fromOffsets: source, toOffset: destination)
    }
    
    
    private func deleteTimer() {
        timerDataController.remove(timer: self.sprintTimer, true)
        viewRouter.currentPage = .timerSelectView
    }
    
    private func saveTimerData() {
        /// Need to validate data before save.
        if valid() {
            
//            /// Adding fake data for testing.
//            sprintTimer.name = "Blarg Timer Test"
//
//            let item1 = SprintTimerItem()
//            item1.type = .warmup
//            item1.duration = 600
//            sprintTimer.items.append(item1)
//
//            let item2 = SprintTimerItem()
//            item2.type = .mediumPace
//            item2.duration = 900
//            sprintTimer.items.append(item2)
//
//            let item3 = SprintTimerItem()
//            item3.type = .cooldown
//            item3.duration = 300
//            sprintTimer.items.append(item3)
//            /// END
            
            timerDataController.replace(timer: sprintTimer)
            viewRouter.currentPage = .timerSelectView // .timerDetailView
        }
        else {
            /// Display error message.
            print("Error...")
            //showValidationError = true
        }
    }
    
    func valid() -> Bool {
        return true
    }
    
}


extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}


struct TimerEditView_Previews: PreviewProvider {
    static func timer() -> SprintTimer {
        let t = SprintTimer()
        t.name = "Blarg Timer"
        return t
    }
    static var previews: some View {
        TimerEditView(timer())
    }
}
