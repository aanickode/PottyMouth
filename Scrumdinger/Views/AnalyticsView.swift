//
//  AnalyticsView.swift
//  Scrumdinger
//
//  Created by Akash Anickode on 9/10/23.
//

import SwiftUI
import RealmSwift



struct AnalyticsView: View {
    @State var words: [String] = []
    @State var frequencies: [Int] = []
    @State var tuples: [(freq:Int, wrds:String)] = []
    @State private var word = ""
    @State private var incorrectInfo = 0
    @State private var totalCount = 0.0
    private var frequency: TimeInterval { 1.0 / 60.0 }
    let realm = try! Realm()

    var body: some View {
        VStack{
            Text("Try to keep your daily profanity use below 50 words!").font(.system(size:12))
            ProgressView(value: totalCount, total: 50.0).padding()
            TextField("Add or delete words", text: $word)
                .padding()
                .frame(width: 300, height: 50)
                .border(.black)
                .foregroundColor(.black)
                .cornerRadius(10)
                .border(.red, width: CGFloat(incorrectInfo))
            HStack{
                Button("Add"){
                    addWord(word: word)
                }
                .foregroundColor(.black)
                .frame(width: 100, height: 25)
                .background(Color.blue)
                .cornerRadius(10)
                Button("Delete"){
                    deleteWord(word: word)
                }
                .foregroundColor(.black)
                .frame(width: 100, height: 25)
                .background(Color.blue)
                .cornerRadius(10)
            }
            Text("Frequency Counter")
            
            ForEach(0...tuples.count, id: \.self) {idx in
                if (idx != tuples.count) {
                    HStack(spacing: 10){
                        Text(tuples[idx].wrds)
                        Text("\(tuples[idx].freq)")
                    }
                }
            }
        }
        .onAppear(){
            self.loadFreq()
            self.startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            loadFreq()
        }
    }
    
    func loadFreq() {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            tuples = []
            for key in user.freqMap.keys {
                if let num = user.freqMap[key] {
                    tuples.append((num, key))
                }
            }
            totalCount = Double(min(user.totalScore, 50))
        }
        tuples.sort(by: {$0.freq > $1.freq})
    }
    
    func addWord(word : String) {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            if user.profanitySet.contains(word.lowercased()) {
                incorrectInfo = 2
            } else {
                incorrectInfo = 0
                try! realm.write {
                    user.profanitySet.append(word.lowercased())
                    user.freqMap[word.lowercased()] = 0
                }
            }
        }
        self.loadFreq()
    }
    
    func deleteWord(word : String) {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            if user.profanitySet.contains(word.lowercased()) {
                incorrectInfo = 0
                var profanityCopy : [String] = []
                for profanity in user.profanitySet {
                    if profanity != word.lowercased() {
                        profanityCopy.append(profanity)
                    }
                }
                try! realm.write {
                    user.profanitySet.removeAll()
                    for copy in profanityCopy {
                        user.profanitySet.append(copy)
                    }
                    user.freqMap[word.lowercased()] = nil
                    user.totalScore = 0
                    for key in user.freqMap.keys {
                        user.totalScore = user.totalScore + (user.freqMap[key] ?? 0)
                    }
                    print(user.freqMap)
                }
            } else {
                incorrectInfo = 2
            }
        }
        self.loadFreq()
    }

}

struct ListRow: View {
    var body: some View{
        HStack{
            Text("Person1")
            Spacer()
            Text("Bad Word")
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
