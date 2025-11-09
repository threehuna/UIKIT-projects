//
//  CalendarManaging.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 07.11.2025.
//


import EventKit

protocol CalendarManaging { //HW4
    func create(eventModel: CalendarEventModel, completion: @escaping (Bool) -> Void)
    func createSync(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel {
    var title: String
    var startDate: Date
    var endDate: Date
    var note: String?
}
