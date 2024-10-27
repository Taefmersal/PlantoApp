import SwiftUI

struct ContentView: View {
    @StateObject private var reminderModel = PlantReminderModel()
    @State private var modalIsPresented = false
    @State private var navigateToTodayReminder = false

    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Text("My Plants 🌱")
                        .bold()
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
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
                        
                        SetReminder(reminderModel: reminderModel, isPresented: $modalIsPresented, navigateToTodayReminder: $navigateToTodayReminder)
                        
                        
                        
                    }
                    
                }
                .padding(22)
                .padding(.bottom, 140)
                
            }
        } .navigationBarHidden(true)
    }
        
}

#Preview {
    ContentView()
}
