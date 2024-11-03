import SwiftUI

struct Schedule: View {
    
    @State private var selectedDayIndex = 0
    @State var appointments = [
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [Appointment(),Appointment(),Appointment(),Appointment(),Appointment()],
        [],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]
    ]

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()
    
    var body: some View {
        VStack {
            // Scrollable tab view at the top
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) { // Increased spacing between buttons
                    ForEach(0..<30) { index in
                        let date = Date().addingTimeInterval(TimeInterval(60*60*24*index))

                        Button(action: {
                            selectedDayIndex = index
                        }) {
                            Text(dateFormatter.string(from: date))
                                .padding(.horizontal, 20) // Increased horizontal padding
                                .padding(.vertical, 10) // Increased vertical padding
                                .background(selectedDayIndex == index ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            
            // DayView corresponding to the selected day
            DayView(appointments: appointments[selectedDayIndex]) // Pass your appointments array here
        }
    }
}



import Foundation

struct Algorithms {
    
    enum Weekdays: Int, CaseIterable {
        case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum Subjects: String, CaseIterable {
        case socialStudies, math, science, language, english
    }
    
    func getSchedule(studentWeeklyAllotment: [Subjects: Int], tutorWeeklyAllotment: [Subjects: Int], studentDailyFreeTimes: [Weekdays: [Bool]], tutorDailyFreeTimes: [Weekdays: [Bool]]) -> [[Appointment]] {
        
        var output : [[Appointment]] = [[]]
        
        
        for subject in Subjects.allCases{
            
            if let tutorAllotment = tutorWeeklyAllotment[subject] , let studentAllotment = studentWeeklyAllotment[subject]{
                
                var weeklyCount = 0
                var weekdays = Weekdays.allCases
                for i in 0...7{
                    
                    if(weeklyCount >= min(tutorAllotment,studentAllotment)){
                        break;
                    }
                    
                    if let studentFreeTimes = studentDailyFreeTimes[weekdays[i]] , let tutorFreeTimes = tutorDailyFreeTimes[weekdays[i]]{
                        
                        for i in 0...23{
                            if studentFreeTimes[i] && tutorFreeTimes[i]{
                                output[i].append(Appointment(name:subject.rawValue,startTime: Date()))
                                weeklyCount = weeklyCount + 1
                            }
                        }
                        
                        
                        
                    }
                }
                
                
            }
            
            
        }
        
        
        
      return output
    }
    
   
}


struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        Schedule()
    }
}


