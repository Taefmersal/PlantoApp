import Foundation

struct PlantReminder: Identifiable {
    let id = UUID() // Unique identifier
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool = false // Added isChecked property
}

