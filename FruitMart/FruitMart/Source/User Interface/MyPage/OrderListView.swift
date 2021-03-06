//
//  OrderListView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/22.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var store: Store
    
    
    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders
            } else {
                orderList
            }
        }
        .animation(.default, value: store.orders.isEmpty)
        .navigationBarTitle("주문 목록")
        .navigationBarItems(trailing: editButton)
    }
    
    var editButton: some View {
        !store.orders.isEmpty
            ? AnyView(EditButton())
            : AnyView(EmptyView())
        
    }
    
    
    var emptyOrders: some View {
        VStack(spacing: 25) {
            Image("box")
                .renderingMode(.template)
                .foregroundColor(Color.gray.opacity(0.4))
            
            Text("주문 내역이 없습니다.")
                .font(.headline).fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    
    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }.onDelete(perform: store.deleteOrder(at:))
                .onMove(perform: store.moveOrder(from:to:))
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
