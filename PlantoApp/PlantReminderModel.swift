import Foundation
import Combine

class PlantReminderModel: ObservableObject {
    @Published var reminders: [PlantReminder] = [] // Array to hold reminders

    // Method to add a new reminder
    func addReminder(_ reminder: PlantReminder) {
        reminders.append(reminder) // Append the new reminder to the array
    }
}
