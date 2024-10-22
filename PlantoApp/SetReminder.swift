import SwiftUI

struct SetReminder: View {
    @ObservedObject var reminderModel: PlantReminderModel
    @State private var plantName: String = "" // State variable for plant name

    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.12)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Set Plant Reminder")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)

                TextField("",text: $plantName,prompt:Text("Plant Name")
                    .foregroundColor(.white))
                .bold()
                                            .padding()
                                            .background(Color(red:0.1725,green:0.1725,blue:0.1804))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
            }
            .padding()
        }
    }
}

#Preview {
    SetReminder(reminderModel: PlantReminderModel())
}

