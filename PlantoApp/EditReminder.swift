
import SwiftUI

struct EditReminder: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PlantReminderModel
    @State var reminder: PlantReminder

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        HStack {
                            Text("Plant Name")
                                .foregroundColor(.white)
                            TextField("Enter plant name", text: $reminder.name)
                                .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                                .padding(.trailing)
                                .frame(height: 36)
                        }
                        .padding(.vertical, 4)
                    }

                    Section {
                        PickerRow(icon: "paperplane", title: "Room", selection: $reminder.room, options: ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"])
                        PickerRow(icon: "sun.max", title: "Light", selection: $reminder.light, options: ["Full sun", "Partial sun", "Low light"])
                    }

                    Section {
                        PickerRow(icon: "drop", title: "Watering Days", selection: $reminder.wateringDays, options: ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"])
                        PickerRow(icon: "drop", title: "Water Amount", selection: $reminder.waterAmount, options: ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"])
                    }

                    Button(action: {
                        deleteReminder()
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle("Edit Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        .navigationBarBackButtonHidden(true)
                        .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            saveChanges()
                        }
                        .navigationBarBackButtonHidden(true)
                        .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                }
            }
            .background(Color.black.ignoresSafeArea())
        }
    }

    private func saveChanges() {
        if let index = viewModel.reminders.firstIndex(where: { $0.id == reminder.id }) {
            viewModel.reminders[index] = reminder
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func deleteReminder() {
        if let index = viewModel.reminders.firstIndex(where: { $0.id == reminder.id }) {
            viewModel.reminders.remove(at: index)
        }
        presentationMode.wrappedValue.dismiss()
    }
}


