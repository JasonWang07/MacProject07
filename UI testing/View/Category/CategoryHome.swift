//
//  Home.swift
//  UI testing
//
//  Created by Jason Wang on 28/11/22.
//

import SwiftUI

struct CategoryHome: View {
    
//    @EnvironmentObject var sportData: SportData
    @ObservedObject var viewModel = CenterViewModel().self
    var sportCategories = SportLogic().self
    
    var body: some View {
        NavigationView{
        
        List{
            //Feature function will be added here
            VStack(alignment: .center, spacing:0){
                //Text
                Spacer(minLength: 60)
                Text("- Cross zone -")
                    .font(.title3)
                Spacer()
                viewModel.sports[0].image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 350, height: 200)
                    .cornerRadius(5)
            }
                
            
            ForEach(sportCategories.categories.keys.sorted(), id: \.self)
            {   key in CategoryRow(categoryName: key, items: sportCategories.categories[key]!)
            }
        }.ignoresSafeArea(edges: .top)
        }
    }
}

struct CategoryRow: View {
    
//    var viewModel: CenterViewModel
    var categoryName: String
    var items: [SportLogic.Sport]

    var body: some View{
        VStack(alignment: .leading){
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { item in
                        NavigationLink {
                            EventPartnerHome()  //因為他自己self初始了
                        } label: {
                            CategoryItem(sport: item)
                        }
                    }
                }
            }
        }
    }
}

struct CategoryItem: View {
    
    var sport: SportLogic.Sport
    
    var body: some View {
        VStack(alignment: .leading) {
            //navigation link here to direct it to eventpartnerhome
            sport.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(sport.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
    
}




struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        let game = CenterViewModel()
        let logic = SportLogic()
        
        CategoryHome(viewModel: game, sportCategories: logic)
    }
}
