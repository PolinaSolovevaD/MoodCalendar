//
//  ContentView.swift
//  MoodApp
//
//  Created by Polya Soloveva on 15/10/23.
//

import SwiftUI

struct ContentView: View {
    
    let days = ["Sun", "Mon","Tue", "Wed", "Thu", "Fri", "Set"]
    @State var selectedMonth = 0 // !
    
    var body: some View {
        VStack(spacing: 40) {
            
            //MONTH SELECTION
            HStack{
                Spacer()
                
                Button {
                    print("less")
                } label: {
                    Image(systemName: "lessthan")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 22)
                }
                
                Spacer()
                
                Text("October 2023")
                    .font(.title)
                
                Spacer()
                
                Button {
                    print("great")
                } label: {
                    Image(systemName: "greaterthan")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 22)
                }
                
                Spacer()
            }
            
            // WEEK
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                ForEach(fatchDates()) { value in
                    ZStack{
                        if value.day != -1 {
                            Text("\(value.day)")
                        } else {
                            Text("")
                        }
                    }
                    .frame(width: 32, height: 32)
                    
                }
            }
            
        }
        
                    
            }
    func fatchDates() -> [CalendareDate]{
        let calendar = Calendar.current
        let currentMonth = fatchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({CalendareDate(day: calendar.component(.day, from: $0), date: $0)})
        
        let firstDaysOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDaysOfWeek - 1 {
            dates.insert(CalendareDate(day: -1, date: Date()), at: 0)
        }
        
        return dates
        
    }
    
    func fatchSelectedMonth() -> Date {
        let calendar = Calendar.current
        
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
                                
    }
        }

struct CalendareDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
    
}


#Preview {
    ContentView()
}

extension Date {
    func datesOfMonth() -> [Date]{
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
}
