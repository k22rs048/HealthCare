//
//  ExerciseRecordView.swift
//  HealthCare
//
//  Created by Kimura on 2024/09/23.
//

import SwiftUI

import SwiftUI

struct ExerciseRecordView: View {
    @State private var selectedDate = Date() // 日付選択
    @State private var selectedExerciseType = "ランニング" // 運動の種類
    @State private var exerciseTime: String = "" // 運動時間（分）
    @State private var distanceOrCount: String = "" // 距離または回数
    @State private var caloriesBurned: Double = 0 // 消費カロリー
    @State private var exerciseRecords: [ExerciseRecord] = [] // 過去の運動記録

    // 運動の種類リスト
    let exerciseTypes = ["ランニング", "ウォーキング", "サイクリング"]

    var body: some View {
        NavigationView {
            VStack {
                // 日付選択
                DatePicker("日付を選択", selection: $selectedDate, displayedComponents: .date)
                    .padding()

                // 運動の種類選択
                Picker("運動の種類", selection: $selectedExerciseType) {
                    ForEach(exerciseTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // 運動時間入力
                HStack {
                    Text("運動時間 (分)")
                    TextField("時間", text: $exerciseTime)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // 距離/回数入力
                HStack {
                    Text(selectedExerciseType == "サイクリング" ? "距離 (km)" : "回数")
                    TextField(selectedExerciseType == "サイクリング" ? "距離" : "回数", text: $distanceOrCount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                // カロリー計算と表示
                Button("カロリーを計算") {
                    calculateCalories()
                }
                .padding()

                Text("消費カロリー: \(caloriesBurned, specifier: "%.2f") kcal")
                    .padding()

                // 記録保存ボタン
                Button("運動記録を保存") {
                    saveExerciseRecord()
                }
                .padding()

                // 運動記録のリスト表示
                List {
                    ForEach(exerciseRecords) { record in
                        VStack(alignment: .leading) {
                            Text(record.exerciseType)
                            Text("日付: \(record.date)")
                            Text("時間: \(record.time) 分")
                            Text("距離/回数: \(record.distanceOrCount)")
                            Text("カロリー: \(record.calories) kcal")
                        }
                    }
                }
            }
            .navigationTitle("運動記録")
        }
    }

    // カロリー計算のロジック（例: 時間と距離/回数に基づく）
    func calculateCalories() {
        // シンプルな計算式（適当な係数を設定）
        if let time = Double(exerciseTime), let distanceOrCount = Double(distanceOrCount) {
            caloriesBurned = time * distanceOrCount * 0.1 // 仮の係数
        }
    }

    // 記録保存の処理
    func saveExerciseRecord() {
        let newRecord = ExerciseRecord(
            id: UUID(),
            date: selectedDate,
            exerciseType: selectedExerciseType,
            time: exerciseTime,
            distanceOrCount: distanceOrCount,
            calories: caloriesBurned
        )
        exerciseRecords.append(newRecord)
    }
}

// モデル: 運動記録
struct ExerciseRecord: Identifiable {
    var id: UUID
    var date: Date
    var exerciseType: String
    var time: String
    var distanceOrCount: String
    var calories: Double
}


#Preview {
    ExerciseRecordView()
}
