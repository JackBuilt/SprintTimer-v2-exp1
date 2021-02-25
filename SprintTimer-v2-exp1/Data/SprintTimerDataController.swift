//
//  SprintTimerDataController.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

class SprintTimerDataController: ObservableObject {
    
    @Published var sprintTimerArray: [SprintTimer] = [SprintTimer]()
    
    private let dataKey = "SprintTimerData"
    
    
    init() {
        sprintTimerArray = fetchData()
    }
    
    
    private func fetchData() -> [SprintTimer] {
        /// Deletes all data for the key "dataKey".
        //UserDefaults.standard.removeObject(forKey: dataKey)
        
        if let data = UserDefaults.standard.data(forKey: dataKey) {
            if let decoded = try? JSONDecoder().decode([SprintTimer].self, from: data) {
                return decoded
            }
        }

        return []
    }
    
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(self.sprintTimerArray) {
            UserDefaults.standard.set(encoded, forKey: dataKey)
        }
    }
    
    func save() {
        saveData()
    }
    
    func add(timer: SprintTimer) {
        sprintTimerArray.append(timer)
        saveData()
    }
    
    func replace(timer: SprintTimer) {
        remove(timer: timer)
        sprintTimerArray.append(timer)
        saveData()
    }
    
    func remove(at offsets: IndexSet) {
        sprintTimerArray.remove(atOffsets: offsets)
        saveData()
    }
    
    func remove(timer: SprintTimer, _ save: Bool = false) {
        self.sprintTimerArray.removeAll {
            $0.id == timer.id
        }
        if save {
            saveData()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.sprintTimerArray.move(fromOffsets: source, toOffset: destination)
        saveData()
    }
}
