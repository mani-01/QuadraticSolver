//
//  ContentView.swift
//  quadratic solver
//
//  Created by Mani on 29/07/2020.
//  Copyright © 2020 Mani. All rights reserved.
//

import SwiftUI

struct QuadraticContentView: View {
    @State var showingDetail = false
    
    @State var inputsString: [String] = ["", "", ""]
    
    @State private var showAnswerText: Bool = false
    @State private var answerTextContent = "enter values for a, b and c above"
    @State private var showHidden: Bool = false
    
    
    
    
    var rootType: Int {
        var inputs: [Double] = []
        for i in inputsString.enumerated() {
            inputs.append(Double(inputsString[i.offset]) ?? 0)
        }
        let descriminantAnswer = (inputs[1]*inputs[1]) - (4 * inputs[0] * inputs[2])
        
        if inputs[0] == 0 {
            let typeOfRoot = 5 /// not a quadratic
            return typeOfRoot
        }
        else {
            switch (descriminantAnswer == 0, descriminantAnswer > 0, descriminantAnswer < 0) {
            case (true, false, false):
                let typeOfRoot = 1
                return typeOfRoot  /// only 1 root
            case (false, true, false):
                let typeOfRoot = 2
                return typeOfRoot  /// 2 real roots
            case (false, false, true):
                let typeOfRoot = 3
                return typeOfRoot  /// 2 complex roots
            default:
                let typeOfRoot = 4
                return typeOfRoot
            }
            
        }
        
    }
    
    
    
    
    
    
    var xValuesArray: [Double] {
        
        let A = Double(inputA) ?? 0
        let B = Double(inputB) ?? 0
        let C = Double(inputC) ?? 0
        
        if A == 0 && B == 0 && C == 0{
            let x1ans:Double = 0
            let x2ans:Double = 0
            let xArray = [x1ans, x2ans]
            return xArray
        } else{
            let x1ans = Double (( (0 - B) + sqrt((B * B)-(4 * A * C)))/(2 * A))
            let x2ans = Double (( (0 - B) - sqrt((B * B)-(4 * A * C)))/(2 * A))
            let xArray = [x1ans, x2ans]
            return xArray
        }
    }
    var validInputCheck:  Bool  {
        let inputADoubleValid = Double(inputA) ?? 25168341025168
        let inputBDoubleValid = Double(inputB) ?? 25168341025168
        let inputCDoubleValid = Double(inputC) ?? 25168341025168
        
        if inputADoubleValid == 25168341025168 || inputBDoubleValid == 25168341025168 || inputCDoubleValid == 25168341025168 {
            let inputIsValid = false
            return inputIsValid
        } else {
            let inputIsValid = true
            return inputIsValid
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Enter your a, b, and c values:")
                        .fontWeight(.medium)
                        .padding(.top, 10)
                    Spacer()
                }
                .padding(.horizontal)
                Group {
                    TextField("a", text: $inputA)
                    TextField("b", text: $inputB)
                    TextField("c", text: $inputC)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .disableAutocorrection(true)
                .onTapGesture {
                    self.showAnswerText = false
                }
            }
            .keyboardType(.numbersAndPunctuation)
            .padding()
            VStack {
                Button(action: {
                    UIApplication.shared.endEditing()
                    self.showAnswerText = true
                }) {
                    button1SubView(button1Text: "Solve for x")                        .padding()
                        .padding(.bottom, 15.0)
                }
                
                if showAnswerText == true {
                    if validInputCheck == true {
                        if rootType == 1 {
                            showAnswerTextFormatting(color3: .black, string3: "1 root at x = \(xValuesArray[0])")
                        }
                        if rootType == 2 {
                            showAnswerTextFormatting(color3: .green, string3: "x1 = \(xValuesArray[0])")
                            showAnswerTextFormatting(color3: .green, string3: "x2 = \(xValuesArray[1])")
                        }
                        if rootType == 3 {
                            showAnswerTextFormatting(color3: .green, string3: "Roots are complex.")
                        }
                        if rootType == 4 {
                            showAnswerTextFormatting(color3: .red, string3: "Provide values for a, b, and c.")
                        }
                        if rootType == 5 {
                            showAnswerTextFormatting(color3: .red, string3: "Equation is not quadratic.")
                        }
                        
                    } else {
                        showAnswerTextFormatting(color3: .red, string3: "Invalid Inputs")
                    }
                    
                } else {
                    EmptyView()
                }
                
                Spacer()
                if showHidden == true{
                    text5Formatting(text5: "x1 ~ \(xValuesArray[0])")
                    text5Formatting(text5: "x2 ~ \(xValuesArray[1])")
                    
                    VStack {
                        HStack {
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                text5Formatting(text5: "Disciminant Type \(rootType)")
                                Image(systemName: "info.circle")
                                    .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .sheet(isPresented: $showingDetail) {
                                DisciminantDetailView()
                            }
                        }
                    }
                    .padding(.vertical, 30)
                } else{
                    EmptyView()
                }
                Button(action: {
                    self.showHidden.toggle()
                }) { if showHidden == false {
                    button2SubView(
                        button2Text: "Show Hidden Variables",
                        opacity2: 1,
                        bacgroundOpacity2: 0.3
                    )} else {
                        button2SubView(
                            button2Text: "Hide Variables",
                            opacity2: 0.9,
                            bacgroundOpacity2: 0.9
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text("Quadratic Solver"), displayMode: .inline)
    }
}

struct CubicContentView: View {
    
    @State var showingDetail = false
    @State var inputA: String = ""
    @State private var inputB: String = ""
    @State private var inputC:String = ""
    @State private var inputD:String = ""
    @State private var showAnswerText: Bool = false
    @State private var answerTextContent = "enter values for a, b, c, and d above"
    @State private var showHidden: Bool = false
    
    var rootType: Int {
        let inputADouble = Double(inputA) ?? 0
        let inputBDouble = Double(inputB) ?? 0
        let inputCDouble = Double(inputC) ?? 0
        let inputDDouble = Double(inputD) ?? 0
        let descriminantAnswer = (inputBDouble*inputBDouble) - (4 * inputADouble * (inputCDouble+inputDDouble))
        
        if inputADouble == 0{
            let typeOfRoot = 5 /// not a quadratic
            return typeOfRoot
        } else {
            if descriminantAnswer == 0 {
                let typeOfRoot = 1 /// only 1 root
                return typeOfRoot
            } else if descriminantAnswer > 0  {
                let typeOfRoot = 2 /// 2 real roots
                return typeOfRoot
            } else if descriminantAnswer < 0 {
                let typeOfRoot = 3 /// 2 complex roots
                return typeOfRoot
            } else{
                let typeOfRoot = 4 /// no answer provided
                return typeOfRoot
            }
        }
    }
    var xValuesArray: [Double] {
        
        let A = Double(inputA) ?? 0
        let B = Double(inputB) ?? 0
        let C = Double(inputC) ?? 0
        
        if A == 0 && B == 0 && C == 0{
            let x1ans:Double = 0
            let x2ans:Double = 0
            let xArray = [x1ans, x2ans]
            return xArray
        } else{
            let x1ans = Double (( (0 - B) + sqrt((B * B)-(4 * A * C)))/(2 * A))
            let x2ans = Double (( (0 - B) - sqrt((B * B)-(4 * A * C)))/(2 * A))
            let xArray = [x1ans, x2ans]
            return xArray
        }
    }
    var validInputCheck:  Bool  {
        let inputADoubleValid = Double(inputA) ?? 25168341025168
        let inputBDoubleValid = Double(inputB) ?? 25168341025168
        let inputCDoubleValid = Double(inputC) ?? 25168341025168
        
        if inputADoubleValid == 25168341025168 || inputBDoubleValid == 25168341025168 || inputCDoubleValid == 25168341025168 {
            let inputIsValid = false
            return inputIsValid
        } else {
            let inputIsValid = true
            return inputIsValid
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Enter your a, b, c, and d values:")
                        .fontWeight(.medium)
                        .padding(.top, 10)
                    Spacer()
                }
                .padding(.horizontal)
                Group {
                    TextField("a", text: $inputA)
                    TextField("b", text: $inputB)
                    TextField("c", text: $inputC)
                    TextField("d", text: $inputD)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .disableAutocorrection(true)
                .onTapGesture {
                    self.showAnswerText = false
                }
            }
            .keyboardType(.numbersAndPunctuation)
            .padding()
            VStack {
                Button(action: {
                    UIApplication.shared.endEditing()
                    self.showAnswerText = true
                }) {
                    button1SubView(button1Text: "Solve for x")                        .padding()
                        .padding(.bottom, 15.0)
                }
                
                if showAnswerText == true {
                    if validInputCheck == true {
                        if rootType == 1 {
                            showAnswerTextFormatting(color3: .black, string3: "1 root at x = \(xValuesArray[0])")
                        }
                        if rootType == 2 {
                            showAnswerTextFormatting(color3: .green, string3: "x1 = \(xValuesArray[0])")
                            showAnswerTextFormatting(color3: .green, string3: "x2 = \(xValuesArray[1])")
                        }
                        if rootType == 3 {
                            showAnswerTextFormatting(color3: .green, string3: "Roots are complex.")
                        }
                        if rootType == 4 {
                            showAnswerTextFormatting(color3: .red, string3: "Provide values for a, b, c, and d.")
                        }
                        if rootType == 5 {
                            showAnswerTextFormatting(color3: .red, string3: "Equation is not cubic.")
                        }
                        
                    } else {
                        showAnswerTextFormatting(color3: .red, string3: "Invalid Inputs")
                    }
                    
                } else {
                    EmptyView()
                }
                
                Spacer()
                if showHidden == true{
                    text5Formatting(text5: "x1 ~ \(xValuesArray[0])")
                    text5Formatting(text5: "x2 ~ \(xValuesArray[1])")
                    
                    VStack {
                        HStack {
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                text5Formatting(text5: "Disciminant Type \(rootType)")
                                Image(systemName: "info.circle")
                                    .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .sheet(isPresented: $showingDetail) {
                                DisciminantDetailView()
                            }
                        }
                    }
                    .padding(.vertical, 30)
                } else{
                    EmptyView()
                }
                Button(action: {
                    self.showHidden.toggle()
                }) { if showHidden == false {
                    button2SubView(
                        button2Text: "Show Hidden Variables",
                        opacity2: 1,
                        bacgroundOpacity2: 0.3
                    )} else {
                        button2SubView(
                            button2Text: "Hide Variables",
                            opacity2: 0.9,
                            bacgroundOpacity2: 0.9
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text("Cubic Solver"), displayMode: .inline)
    }
}

struct DisciminantDetailView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Discriminant Types:")
                .font(.title)
                .fontWeight(.heavy)
                .padding()
                .padding()
            
            
            Text("""
                1 = One Root,
                2 = Two Real Roots,
                3 = Two Complex Roots,
                4 = No Input Values,
                5 = Equation Not Quadratic
            """) .fontWeight(.bold)
            
            Spacer()
        }
    }
}
struct InitialSelectionView: View {
    
    @State private var mainTitle = "x Solver"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            VStack {
                Text("\(mainTitle)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                    .padding(.top)
                Spacer()
                Image("graphsPic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                Spacer()
                Spacer()
                VStack (spacing: 10) {
                    NavigationLink(
                        destination: QuadraticContentView(), label: {
                            button1SubView(button1Text: "Quadratic")
                        })
                    NavigationLink(
                        destination: CubicContentView(), label: {
                            button1SubView(button1Text: "Cubic")
                        })
                }
                .frame(height: 20)
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            .padding()
            .navigationBarTitle(Text("\(mainTitle)"), displayMode: .automatic)
            .navigationBarHidden(true)
        }
        .background(colorScheme == .dark ? Color.gray : Color.white)
    }
}


struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        InitialSelectionView()
    }
}
struct quadratic_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticContentView()
        
    }
}
//struct cubic_Previews: PreviewProvider {
//    static var previews: some View {
//        CubicContentView()
//
//    }
//}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisciminantDetailView()
//    }
//}


///Dissmiss Keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

private func endEditing() {
    UIApplication.shared.endEditing()
}///

struct button1SubView: View {
    var button1Text: String
    var body: some View {
        Text("\(button1Text)")
            .fontWeight(.heavy)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .accentColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    
    
}
struct button2SubView: View {
    
    var button2Text: String
    var opacity2: Double
    var bacgroundOpacity2: Double
    
    var body: some View {
        Text("\(button2Text)")
            .fontWeight(.heavy)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .accentColor(Color.white.opacity(Double(opacity2)))
            .background(Color.gray.opacity(Double(bacgroundOpacity2)))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding()
    }
}
struct showAnswerTextFormatting: View {
    
    var color3: Color
    var string3: String
    
    
    var body: some View {
        Text(string3)
            .fontWeight(.bold)
            .foregroundColor(color3)
    }
    
}
struct text5Formatting: View {
    var text5: String
    var body: some View {
        Text("\(text5)")
            .fontWeight(.bold)
            .cornerRadius(20)
    }
    
}


