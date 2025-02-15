//
//  SettingsView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text(Constants.settTxt)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                VStack {
                    CustomButton2(
                        title: Constants.rateTxt,
                        destination: AnyView(RatingView())
                        )
                    CustomButton2(
                        title: Constants.shareTxt,
                        destination: AnyView(ShareAppView())
                    )
                    CustomButton2(
                        title: Constants.contactTxt,
                        destination: AnyView(ContactUsView())
                    )
                    CustomButton2(
                        title: Constants.restoreTxt,
                        destination: AnyView(RestorePurchasesView())
                    )
                    CustomButton2(
                        title: Constants.privacyTxt,
                        destination: AnyView(PrivacyPolicyView())
                    )
                    CustomButton2(
                        title: Constants.termOfUseTxt,
                        destination: AnyView(TermsOfUseView())
                    )
                }
                .padding()
                
                Spacer()
                
                // MARK: - Bottom Buttons
                ZStack {
                    HStack {
                        NavigationLink {
                            TranslatorPageView()
                        } label: {
                            Color.white
                                .frame(width: 64, height: 44)
                                .overlay {
                                    VStack {
                                        Image(Constants.msg2Img)
                                        Text(Constants.mainTitle)
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                        }
                        .padding(.trailing)
                        
                        Button {
                            
                        } label: {
                            Color.white
                                .frame(width: 64, height: 44)
                                .overlay {
                                    VStack {
                                        Image(Constants.groupImg)
                                        Text(Constants.clickerTxt)
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                        }
                        .padding(.leading)
                    }
                }
                .padding()
                .frame(width: 216, height: 82)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.bottom, 40)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppGradients.backgroundGradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.automatic)
            
        }
    }
}

#Preview {
    SettingsView()
}
