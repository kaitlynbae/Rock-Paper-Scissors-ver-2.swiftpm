import SwiftUI

enum Choices:String, CaseIterable{
    case Scissors = "✂️", Paper = "📄", Rock = "🪨"
}

struct ContentView: View {
    
    @State var computerChoice = Choices.allCases.first!
    @State var gameOutcome = ""
    
    @State var wins = 0
    @State var round = 0 
    
    @State var showAlert = false
    @State var showComputerChoice = false
    
    var body: some View {
        
        GeometryReader { geo in 
            
            VStack {
                
             VStack {
                    if !showComputerChoice {
                        Text ("🤖")
                            .font(.system(size:100))
                    } else {
                        Text(computerChoice.rawValue)
                            .font(.system(size:100))
                    }
                } .frame(width: geo.size.width, height : geo.size.height/2)
               
                VStack {
                    Text ("Make Your Selection:")
                        .padding()
                    HStack(spacing:0){
                        HStack{
                            Spacer()
                            Text("Wins: \(wins)")
                            Spacer()
                            Text("Round: \(round)")
                            Spacer()
                        }
                        ForEach(Choices.allCases, id: \.self) {option in
                            Button(action:{
                              
                                round += 1 
                                
                                
                                let index = Int.random(in: 0...Choices.allCases.count-1) 
                                computerChoice = Choices.allCases[index]
                                showComputerChoice = true
                                
                               
                                checkWin(playerChoice:option)
                            }){
                                Text(option.rawValue)
                                    .font(.system(size: geo.size.width/CGFloat(Choices.allCases.count)))
                            }
                        }
                    }
                    
                }.frame(width: geo.size.width, height : geo.size.height/2)
            }
            
        }
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            
        }
    }
    func checkWin(playerChoice:Choices){
        showAlert = true
        switch playerChoice{ 
    
        
        case .Scissors:
            if computerChoice == .Scissors {
                gameOutcome = "Draw"
            } else if computerChoice == .Paper{
                gameOutcome = "Win"
                wins += 1
            } else {
                gameOutcome = "Lose"
            }
            
        case .Paper:
            if computerChoice == .Scissors {
                gameOutcome = "Lose"
            } else if computerChoice == .Paper{
                gameOutcome = "Draw"
            } else {
                gameOutcome = "Win"
                    wins += 1
            }
        case .Rock:
            if computerChoice == .Scissors {
                gameOutcome = "Win"
                    wins += 1
            } else if computerChoice == .Paper{
                gameOutcome = "Lose"
            } else {
                gameOutcome = "Draw"
            }
        }
    }
}

