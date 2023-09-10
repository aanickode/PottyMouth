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
    let realm = try! Realm()

    var body: some View {
        VStack{
            Text("Frequency Counter")
            
            ForEach(0...words.count, id: \.self) {idx in
                if (idx != words.count) {
                    HStack(spacing: 10){
                        Text(words[idx])
                        Text("\(frequencies[idx])")
                    }
                }
            }
        }
        .onAppear(){
            self.loadFreq()
        }
    }
    
    func loadFreq() {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            words = user.freqMap.keys
            frequencies = user.freqMap.values
        }
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
