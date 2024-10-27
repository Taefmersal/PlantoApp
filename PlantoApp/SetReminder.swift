import SwiftUI

struct SetReminder: View {
    @ObservedObject var reminderModel: PlantReminderModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @Binding var navigateToTodayReminder: Bool
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var waterAmount: String = "20-50 ml"
    var existingReminder: PlantReminder? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        HStack {
                            Text("Plant Name")
                                .foregroundColor(.white)
                            TextField("Enter plant name", text: $plantName)
                                .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                                .padding(.trailing)
                                .frame(height: 36)
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Section {
                        PickerRow(icon: "paperplane", title: "Room", selection: $selectedRoom, options: ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]).accentColor(.gray)
                        PickerRow(icon: "sun.max", title: "Light", selection: $selectedLight, options: ["Full sun", "Partial sun", "Low light"]).accentColor(.gray)
                    }
                    
                    Section {
                        PickerRow(icon: "drop", title: "Watering Days", selection: $selectedWateringDays, options: ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]).accentColor(.gray)
                        PickerRow(icon: "drop", title: "Water", selection: $waterAmount, options: ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]).accentColor(.gray)
                    }
                }
                .navigationTitle("Set Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            saveReminder()
                        }
                        .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToTodayReminder) {
                    TodayReminder(reminderModel: reminderModel)
                }
                .navigationBarBackButtonHidden(true)
                .background(Color.black.ignoresSafeArea())
            }
        }
    }

    private func saveReminder() {
            let newReminder = PlantReminder(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: waterAmount)
            
            reminderModel.addReminder(newReminder)
            resetFields()
            navigateToTodayReminder = true
        }
        
        private func resetFields() {
            plantName = ""
            selectedRoom = "Bedroom"
            selectedLight = "Full sun"
            selectedWateringDays = "Every day"
            waterAmount = "20-50 ml"
        }
    

    
    private func deleteReminder() {
        if let existing = existingReminder {
            if let index = reminderModel.reminders.firstIndex(where: { $0.id == existing.id }) {
                reminderModel.reminders.remove(at: index)
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
}



#Preview {
    SetReminder(reminderModel: PlantReminderModel(), isPresented: .constant(true), navigateToTodayReminder: .constant(false)) // Dummy binding for preview
}

