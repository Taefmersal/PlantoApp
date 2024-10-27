import SwiftUI

struct TodayReminder: View {
    @ObservedObject var reminderModel: PlantReminderModel
    @State private var modalIsPresented = false
    @State private var navigateToTodayReminder = false // State for navigation

    private var allRemindersChecked: Bool {
        reminderModel.reminders.allSatisfy { $0.isChecked }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header Section
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 0.2)
                    .padding(.leading, 18.0)

                VStack {
                    // Add a spacer to push the "Today" text down
                    Spacer(minLength: 20)

                    // Display "Today" only if not all reminders are checked
                    if !allRemindersChecked {
                        Text("Today")
                            .padding(.leading, -180)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .padding(.bottom, -30)
                    }

                    if allRemindersChecked {
                        AllRemindersCompletedView()
                    } else {
                        reminderListView
                    }
                }
                .background(Color.black)

                Spacer()

                // New Reminder Button
                HStack {
                    Spacer()
                    Button(action: {
                        modalIsPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                        .padding(.trailing, 200)
                    }
                    Spacer()
                }
                .sheet(isPresented: $modalIsPresented) {
                    SetReminder(reminderModel: reminderModel, isPresented: $modalIsPresented, navigateToTodayReminder: $navigateToTodayReminder)
                }
            }
            .navigationTitle("My Plants 🌱")
            .background(Color.black.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }

    private var reminderListView: some View {
        List {
            ForEach(reminderModel.reminders) { reminder in
                PlantRow(reminder: reminder, viewModel: reminderModel)
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteReminder(reminder)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .listRowBackground(Color.black)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.black)
        .padding(.top, 20)
    }

    private func deleteReminder(_ reminder: PlantReminder) {
        if let index = reminderModel.reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminderModel.reminders.remove(at: index)
        }
    }
}

struct PlantRow: View {
    var reminder: PlantReminder
    @ObservedObject var viewModel: PlantReminderModel

    var body: some View {
        NavigationLink(destination: EditReminder(viewModel: viewModel, reminder: reminder)) {
            VStack(alignment: .leading) {
                // Existing content
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)

                    Text("in \(reminder.room)")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }

                HStack {
                    // Checkmark Button
                    Image(systemName: reminder.isChecked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(reminder.isChecked ? Color.green : Color.gray)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            // Toggle the checkmark
                            if let index = viewModel.reminders.firstIndex(where: { $0.id == reminder.id }) {
                                viewModel.reminders[index].isChecked.toggle()
                            }
                        }
                    
                    Text(reminder.name)
                        .font(.title3)
                        .foregroundColor(.white)
                }

                HStack {
                    HStack {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                        Text(reminder.light)
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                    }
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)

                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251/255))
                        Text(reminder.waterAmount)
                            .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251))
                    }
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                }

                Divider()
                    .background(Color.gray)
                    .frame(height: 1)
                    .padding(.horizontal, -20)
            }
            .padding(.bottom, 10)
            .listRowBackground(Color.black)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Placeholder for AllRemindersCompletedView
struct AllRemindersCompletedView: View {
    var body: some View {
        ZStack {
            Image("comp")
                .resizable()
                .frame(width: 219, height: 227)
                .position(x: 180, y: 188)

            Text("All Done!🎉")
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .position(x: 188, y: 350)

            Text("All Reminders Completed")
                .foregroundColor(.gray)
                .position(x: 188, y: 380)
        }
    }
}

struct TodayReminder_Previews: PreviewProvider {
    static var previews: some View {
        TodayReminder(reminderModel: PlantReminderModel())
    }
}

