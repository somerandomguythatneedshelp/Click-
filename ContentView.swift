import SwiftUI

struct ContentView: View {
    @State var times = 0
    @State var timeRemaining = 0
    
    @State var IsStarted = false // not started by default that would be dumb
    @State var timeUp = false
    @State var showPlayAgain = false
    @State var timerActive = false
    @State var HasClickedPlayAgain = false
    @State var shouldShowPlayButtonAgain = false
    @State var DidPayAtleastOnce = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Time: \(timeRemaining)")
                    .font(.largeTitle)

            Text("Times clicked: \(times)")
            
            if (IsStarted == false) {
                Button("Start Timer") {
                    timerActive = true;
                    
                    if (timerActive) {
                        self.timeRemaining = 10
                    }
                       
                    IsStarted = !IsStarted
                    print("\(IsStarted)")
                }
            } else {
                Button("") {
                    self.times += 1
                    print("Times clicked: \(times)")  
                }
                .padding(.vertical, 100)
                .scaleEffect(8.5)
                .onReceive(timer) { _ in

                  if self.timeRemaining == 0 {
                      timeUp = true
                      timerActive = false;
                      showPlayAgain = false;
                      self.shouldShowPlayButtonAgain = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            showPlayAgain = true;
                            if !DidPayAtleastOnce {
                                showPlayAgain = true
                            }
                            HasClickedPlayAgain = false; // he didnt unclick it just make it appear again
                         }
                      
                  } else {
                    
                  }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.blue)
                .disabled(timeUp)
            }
            
            if timeUp && shouldShowPlayButtonAgain == true {
              Text("Final Score: \(times)")
            }
            
            if showPlayAgain && shouldShowPlayButtonAgain == true {
              Button("Play Again") {
                print("i hate python")
                  showPlayAgain = false;
                  IsStarted = false;
                  times = 0;
                  timerActive = false;
                  shouldShowPlayButtonAgain = false;
                  timeUp = false;
                  DidPayAtleastOnce = true;
              }
            }
        }
        .onReceive(timer) { _ in
             if self.timeRemaining > 0 {
               self.timeRemaining -= 1
             }
           }
        .padding()
    }
}

#Preview {
    ContentView()
}
