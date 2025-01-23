//
//  SubscriberBootCamp.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 23/01/2025.
//

import SwiftUI
import Combine

class PubSubViewModel  : ObservableObject {
    
    @Published var count : Int = 0
    @Published var textFieldText: String = ""
    @Published var isTextValid = false
    @Published var showSubmitButton = false
    
    
    // declare a cancelable as timer, part1
    //var timer : Cancellable?
    
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        setupTimer()
        setupTextFieldPubliser()
        setupShowButtonPublisher()
    }
    
    func setupShowButtonPublisher(){
        $isTextValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else {return}
                if isValid && count > 10 {
                    self.showSubmitButton = true
                }else{
                    self.showSubmitButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func setupTextFieldPubliser(){
        $textFieldText
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            //.assign(to: \.isTextValid , on: self)
            // you can use either ".assign" or ".sink" operator
            .sink(receiveValue: { [weak self] isValid in
                guard let self = self else {return}
                self.isTextValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer(){
        //timer = Timer
        Timer
            .publish(every:1, on:.main, in: .common)
            .autoconnect()
            .sink { [weak self] value in
                guard let self = self else {return}
                self.count += 1
                
                if self.count == 5 {
                    //self.timer?.cancel()
                    
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
                    
                }
            }
            .store(in: &cancellables)
    }
}


struct SubscriberBootCamp: View {
    
    @StateObject var vm = PubSubViewModel()
    
    var body: some View {
        
        VStack(spacing:20){
            
            Text("\(vm.count)")
            .font(.title)
            
            TextField("input user email", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height:55)
                .frame(maxWidth:.infinity)
                .background(.gray).opacity(0.5)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay (alignment: .trailing) {
                    
                    Image(systemName:"xmark")
                        .frame(width:50, height: 50)
                        .foregroundColor(.red)
                        .padding(.trailing)
                        .opacity(
                            vm.textFieldText.count < 1 ? 0.0 :
                            vm.isTextValid ? 0.0 : 1.0
                        )
                    
                    Image(systemName:"checkmark")
                        .frame(width:50, height: 50)
                        .foregroundColor(.green)
                        .padding(.trailing)
                        .opacity(vm.isTextValid ? 1.0 : 0.0)
                }
                
            
            //Submit button
            
            Button {
                
            } label: {
                Text("Submit")
                    .frame(height:55)
                    .frame(maxWidth:.infinity)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showSubmitButton ? 1.0 : 0.5)
            }
            .disabled( !vm.showSubmitButton )

                
        }
        .padding(.horizontal)
    }
}

struct SubscriberBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootCamp()
    }
}
