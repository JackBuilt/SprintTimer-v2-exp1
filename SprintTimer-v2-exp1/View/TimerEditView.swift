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
enum ActiveAlert: Identifiable {
    case alertDelete, alertSave
    
    var id: Int {
        hashValue
    }
}


struct TimerEditView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.editMode) private var editMode: Binding<EditMode>?
    
    @ObservedObject var timerDataController: SprintTimerDataController = SprintTimerDataController()
    @ObservedObject var sprintTimer: SprintTimer
    
    @State private var showItemView: ActiveSheet?
    @State private var showAlert: ActiveAlert?
    @State private var selectedItem: SprintTimerItem = SprintTimerItem()
    @State private var isChanged: Bool = false
    private var isNew: Bool
    
    private let rollback: SprintTimer

    init(_ sprintTimer: SprintTimer, newTimer: Bool = false)
    {
        self.sprintTimer = sprintTimer
        self.isNew = newTimer
        
        self.rollback = sprintTimer.copy()
    }
    
    
    var body: some View {
        
        VStack {
            
            Section {
                VStack {
                    HStack {
                        Text("Timer Name")
                            .font(.title2)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.trailing, 5)
                        Spacer()
                        TextField("Name", text: $sprintTimer.name)
                            .onChange(of: sprintTimer.name) { newValue in
                                self.isChanged = true
                                //print("Name changed!")
                            }
                            .padding(.leading, 5)
                            .padding(3)
                            .background(Color("TextFieldBG"))
                            .cornerRadius(5.0)
                            .padding(3)
                            .font(.title2)
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    HStack {
                        Text("Total Time")
                            .font(.title2)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.trailing, 35)
                        
                        Text("\(formatSecondsToTimeString(self.sprintTimer.totalTime()))")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.trailing, 30)
                }
            }
            
            Section {
                List {
                    Section(header: Text("Edit to change order or delete").padding(.leading, 20)) {
                        ForEach(sprintTimer.items) { item in
                            Button(action: {
                                /// go to edit item view.
                                self.selectedItem = item
                                self.showItemView = .editItem
                            }, label: {
                                SprintTimerLabel(name: TimerType.displayName(item.type),
                                                 value: formatSecondsToTimeString(item.duration),
                                                 colorSwatch: getEventColor(item.type))
                            })
                        }
                        .onDelete(perform: onDelete)
                        .onMove(perform: onMove)
                    }
                    .textCase(nil) /// This will stop the default upper case.
                }
                .listStyle(InsetGroupedListStyle())
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
                        if self.selectedItem.type != .none {
                            /// Cheese. For some reason the 1st call is always an empty object.
                            /// This causes EditItemView to lock onto the zero duration.
                            /// Everything is fine after the first call...
                            /// Also this gets called 3 times. Maybe due to the wheel array somehow?
                            EditItemView(self.selectedItem, self.$isChanged)
                        }
                    case .addItem:
                        AddItemView(self.sprintTimer, self.$isChanged)
                    }
                    /// To hide the sheet just set activeSheet = nil        (showItemView = nil)
                    /// Bonus: If you want your sheet to be fullscreen, then use the very same code,
                    /// but instead of .sheet write .fullScreenCover
                }
                .actionSheet(item: $showAlert) { alert in
                    switch alert {
                    case .alertDelete:
                        return alertDelete()
                    case .alertSave:
                        return alertSave()
                    }
                }
            }
            .padding(0)
            
            // BUTTONS
            /// Change this to a TabBar
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
                                self.showAlert = .alertDelete
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
                toggleEditMode()
            }) {
                Text("\(getEditModeLabel())")
            }
        )
    }
    
    private var BackButton: some View {
        return AnyView(
            Button(action: {
                if self.isChanged {
                    /// Show prompt to save.
                    //print("You should save before you leave...")
                    self.showAlert = .alertSave
                }
                else {
                    goBack()
                }
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
    
    
    private func alertDelete() -> ActionSheet {
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
    }
    
    private func alertSave() -> ActionSheet {
        ActionSheet(
            title: Text("Save Timer?"),
            message: Text("You have not saved your timer.\nExit anyway?"),
            buttons: [
                .cancel(),
                .destructive(Text("Exit"),
                             action: rollBack)
            ]
        )
    }
    
    
    private func rollBack() {
        /// Rollback sprintTimer.items to what we started with.
        sprintTimer.items = rollback.items
        goBack()
    }
    
    private func goBack() {
        withAnimation {
            viewRouter.currentPage = isNew ? .timerSelectView : .timerDetailView
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        sprintTimer.items.remove(atOffsets: offsets)
        isChanged = true
    }

    private func onMove(source: IndexSet, destination: Int) {
        sprintTimer.items.move(fromOffsets: source, toOffset: destination)
        isChanged = true
    }
    
    
    private func deleteTimer() {
        timerDataController.remove(timer: self.sprintTimer, true)
        isChanged = true
        withAnimation {
            viewRouter.currentPage = .timerSelectView
        }
    }
    
    private func saveTimerData() {
        /// Need to validate data before save.
        if valid() {
            timerDataController.replace(timer: sprintTimer)
            isChanged = false
            withAnimation {
                viewRouter.currentPage = .timerSelectView
            }
        }
        else {
            /// Display error message.
            print("Error...")
            //showValidationError = true
        }
    }
    
    private func valid() -> Bool {
        return true
    }
    
    
    // MARK: - EditMode functions
    /// Made these to simplify the calls.
    private func toggleEditMode() {
        self.editMode?.wrappedValue.toggle()
    }
    
    private func getEditModeLabel() -> String {
        return self.editMode?.wrappedValue.editLabel() ?? "Edit"
    }
}


// MARK: - Edit Mode extension

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
    
    func editLabel() -> String {
        return self == .active ? "Done" : "Edit"
    }
    /// This extension can be used like this.
    /// Add this to your view
    ///     @Environment(\.editMode) private var editMode: Binding<EditMode>?
    ///
    /// Then create a button in the toolbar to toggle between the 2 modes.
    ///    Button(action: {
    ///        self.editMode?.wrappedValue.toggle()
    ///    }) {
    ///        Text("\(self.editMode?.wrappedValue.editLabel() ?? "Edit")")
    ///    }
    
    /// Or you could add these funcs to your View to simplify the calls.
    
    ///    private func toggleEditMode() {
    ///        self.editMode?.wrappedValue.toggle()
    ///    }
    ///
    ///    private func getEditModeLabel() -> String {
    ///        return self.editMode?.wrappedValue.editLabel() ?? "Edit"
    ///    }
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
