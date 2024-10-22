import SwiftUI

class PlantReminderModel: ObservableObject {
    // Define any properties for the reminder state here
}

struct ContentView: View {
    @StateObject private var reminderModel = PlantReminderModel()
    @State private var modalIsPresented = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Text("My Plants 🌱")
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)

                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)

                ZStack {
                    Image("cycle")
                        .resizable()
                        .frame(width: 219, height: 227)
                    Image("planto")
                        .resizable()
                        .frame(width: 164, height: 200)
                        .padding(50)
                }

                Text("Start your plant journey!")
                    .font(.title)
                    .bold()
                    .padding(-10)
                    .foregroundColor(.white)

                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    modalIsPresented = true
                }) {
                    Text("Set Plant Reminder")
                        .foregroundColor(.black)
                        .font(.headline)
                        .bold()
                        .frame(width: 280, height: 20)
                        .padding()
                        .background(Color(red: 0.16, green: 0.88, blue: 0.66))
                        .cornerRadius(10)
                }
                .sheet(isPresented: $modalIsPresented) {
                    SetReminder(reminderModel: reminderModel)
                }
            }
            .padding(22)
            .padding(.bottom, 140)
        }
    }
}

#Preview {
    ContentView()
}

