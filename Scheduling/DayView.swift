//
//  DayView.swift
//  alksdfj
//
//  Created by Rohan Annapragada (student LM) on 4/29/24.
//

import SwiftUI

struct DayView: View {
    @State var appointments: [Appointment]
    
    var body: some View {
        List {
            ForEach(appointments) { appointment in
                AppointmentView(appointment: appointment)
            }
            .onDelete(perform: deleteAppointment)
        }
    }
    
    func deleteAppointment(at offsets: IndexSet) {
        appointments.remove(atOffsets: offsets)
    }
}


struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(appointments: [Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),Appointment(),])
    }
}

