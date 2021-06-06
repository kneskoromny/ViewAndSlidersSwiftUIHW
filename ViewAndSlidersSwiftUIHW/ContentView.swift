//
//  ContentView.swift
//  ViewAndSlidersSwiftUIHW
//
//  Created by Кирилл Нескоромный on 05.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                ColorRectangle(
                    redSliderValue: $redSliderValue,
                    greenSliderValue: $greenSliderValue,
                    blueSliderValue: $blueSliderValue)
                    
                ColorSlider(value: $redSliderValue, sliderColor: .red)
                ColorSlider(value: $greenSliderValue, sliderColor: .green)
                ColorSlider(value: $blueSliderValue, sliderColor: .blue)
                Spacer()
            }
            .padding(40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorRectangle: View {
    @Binding var redSliderValue: Double
    @Binding var greenSliderValue: Double
    @Binding var blueSliderValue: Double
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(
                Color(
                    .sRGB,
                    red: redSliderValue / 255,
                    green: greenSliderValue / 255,
                    blue: blueSliderValue / 255
                )
            )
            .frame(width: 400, height: 150)
            
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 5)
                        .frame(width: 400, height: 150))
    }
}

struct ColorSlider: View {
    
    @Binding var value: Double
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            HStack {
                SliderValueText(value: value)
            }
            .frame(width: 80, height: 40)
            
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(sliderColor)
           
            SliderValueTextField(value: $value)
        }
    }
}

struct SliderValueText: View {
    let value: Double
    
    var body: some View {
        Text("\(lround(value))").foregroundColor(.white)
            .font(.custom("Menlo", size: 20))
            .fontWeight(.black)
            .padding()
    }
}

struct SliderValueTextField: View {
    @State private var alertPresented = false
    @State private var isEditing = false
    @Binding var value: Double
    
    var body: some View {
       
        TextField(
            "",
            value: $value,
            formatter: NumberFormatter()) { isEditing in
            self.isEditing = isEditing
        } onCommit: {
            validate(value: value)
        }
        .frame(width: 80, height: 30)
        .font(.custom("Menlo", size: 20))
        .foregroundColor(.black)
        .background(Color.white)
        .textFieldStyle(RoundedBorderTextFieldStyle()).cornerRadius(10)
        .alert(isPresented: $alertPresented) {
            Alert(
                title: Text("Wrong Input"),
                message: Text("Please, check input data"),
                dismissButton: .default(Text("OK")))
        }
    }
    
    private func validate(value: Double) {
      
        if !(0...255).contains(value) {
            self.value = 0
            alertPresented = true
        }
    }
}


