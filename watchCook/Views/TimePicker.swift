//
//  TimePicker.swift
//  watchCook
//
//  Created by jaeseong on 2022/02/18.
//

import Foundation
import SwiftUI
import UIKit

struct TimePickerView: UIViewRepresentable {
    let selection: Binding<TimeValue>
    let mins: [Int] = Array(0..<121)
    let secs: [Int] = Array(0..<60)

    //makeCoordinator()
    func makeCoordinator() -> TimePickerView.Coordinator {
        Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<TimePickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)

        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TimePickerView>) {}

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: TimePickerView

        //init(_:)
        init(_ pickerView: TimePickerView) {
            self.parent = pickerView
        }

        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }

        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return [parent.mins.count, parent.secs.count][component]
        }

        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return "\(parent.mins[row])분"
            } else {
                return "\(parent.secs[row])초"
            }
        }

        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let minIndex = pickerView.selectedRow(inComponent: 0)
            let secIndex = pickerView.selectedRow(inComponent: 1)

            self.parent.selection.wrappedValue = TimeValue(min: parent.mins[minIndex], sec: parent.secs[secIndex])
        }
    }
}

struct TimeValue {
    let min: Int
    let sec: Int
    
    public var seconds: Int32 {
        return Int32(min * 60 + sec)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(selection: .constant(TimeValue(min: 3, sec: 30)))
    }
}