//
//  Paywall.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 24/12/2023.
//

import SwiftUI
import RevenueCat

struct Paywall: View {
    
    @Binding var isPaywallPresented: Bool
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var currentOffering: Offering?
    
    @State private var isPurchasing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("MyCaffeine Premium")
                .bold()
                .font(Font.largeTitle)
            Text("Unlock premium for more advanced features.")
            
            Spacer()
            
            VStack(spacing: 40) {
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("Placeholder")
                }
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("Placeholder")
                }
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("Placeholder")
                }
            }
            
            Spacer()
            
//            if(currentOffering != nil) {
//                ForEach(currentOffering!.availablePackages) { pkg in
//                    Button {
//                        Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
//                            isPurchasing = true
//                            
//                            if customerInfo?.entitlements["premium"]?.isActive == true {
//                                // Unlock that great "pro" content
//                                self.isPurchasing = false
//                                userViewModel.isSubscriptionActive = true
//                                isPaywallPresented = false
//                            }
//                        }
//                    } label: {
//                        ZStack {
//                            Rectangle()
//                                .frame(height: 50)
//                                .foregroundStyle(.blue)
//                                .clipShape(.capsule)
//                            Text("\(pkg.storeProduct.subscriptionPeriod!.periodTitle) \(pkg.storeProduct.localizedPriceString)")
//                                .foregroundStyle(.white)
//                        }
//                    }
//                }
//            }
            /// - The paywall view list displaying each package
            if(currentOffering != nil) {
                List {
                    Section(header: Text("\nMyCaffeine Premium"), footer: Text(Self.footerText)) {
                        ForEach(currentOffering!.availablePackages ?? []) { package in
                            PackageCellView(package: package) { (package) in
                                
                                /// - Set 'isPurchasing' state to `true`
                                isPurchasing = true
                                
                                /// - Purchase a package
                                do {
                                    let result = try await Purchases.shared.purchase(package: package)
                                    
                                    /// - Set 'isPurchasing' state to `false`
                                    self.isPurchasing = false
                                    
                                    if !result.userCancelled {
                                        self.isPaywallPresented = false
                                    }
                                } catch {
                                    self.isPurchasing = false
//                                    self.error = error as NSError
//                                    self.displayError = true
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("✨ MyCaffeine Premium")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
            }
            
            
            Spacer()
            
            /// - Display an overlay during a purchase
            Rectangle()
                .foregroundColor(Color.black)
                .opacity(isPurchasing ? 0.5: 0.0)
                .edgesIgnoringSafeArea(.all)
        }
        .padding(50)
        .onAppear() {
            Purchases.shared.getOfferings { offerings, error in
                if let offer = offerings?.current, error == nil {
                    currentOffering = offer
                }
            }
        }
//        .alert(
//            isPresented: self.$displayError,
//            error: self.error,
//            actions: { _ in
//                Button(role: .cancel,
//                       action: { self.displayError = false },
//                       label: { Text("OK") })
//            },
//            message: { Text($0.recoverySuggestion ?? "Please try again") }
//        )
    }
    private static let footerText = "Don't forget to add your subscription terms and conditions. Read more about this here: https://www.revenuecat.com/blog/schedule-2-section-3-8-b"
}
//
//#Preview {
//    Paywall()
//}

/* The cell view for each package */
private struct PackageCellView: View {

    let package: Package
    let onSelection: (Package) async -> Void
    
    var body: some View {
        Button {
            Task {
                await self.onSelection(self.package)
            }
        } label: {
            self.buttonLabel
        }
        .buttonStyle(.plain)
    }

    private var buttonLabel: some View {
        HStack {
            VStack {
                HStack {
                    Text(package.storeProduct.localizedTitle)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                }
                HStack {
                    Text(package.terms)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding([.top, .bottom], 8.0)
            
            Spacer()
            
            Text(package.localizedPriceString)
                .font(.title3)
                .bold()
        }
        .contentShape(Rectangle()) // Make the whole cell tappable
    }

}

extension NSError: LocalizedError {

    public var errorDescription: String? {
        return self.localizedDescription
    }

}
