//
//  AppointmentView.swift
//  Final Project
//
//  Created by Rohan Annapragada (student LM) on 4/29/24.
//

import SwiftUI

struct AppointmentView: View {
    
    @State var appointment: Appointment
    var dateformatter: DateFormatter {
           let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "HH:mm";
        return dateFormatter
       }

    
    var body: some View {
        HStack{
            Text(appointment.name)
                .font(.system(size: 75))
                .bold()
                .padding(.leading,25)
            VStack{
                Text("Start: \(dateformatter.string(from: appointment.startTime))")
                    .padding(.all,10)
                    .font(.system(size: 25))
                Text("End: \(dateformatter.string(from: appointment.endTime))")
                    .padding(.all,10)
                    .font(.system(size: 25))

            }
        }
        
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView(appointment: Appointment())
    }
}


