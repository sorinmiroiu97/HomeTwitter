//
//  ViewModelInitiable.swift
//  HomeTwitter
//
//  Created by Sorin Miroiu on 21.08.2021.
//

import Foundation
import Combine

protocol ViewModelInitiable: AnyObject {
    
    associatedtype ModelObject
    
    var webservice: NetworkInitiable { get }
    var cancelables: Set<AnyCancellable> { get }
    
    init(webservice: NetworkInitiable, with model: ModelObject)
}

// Use case

/*final class TestViewModel: ObservableObject, ViewModelInitiable {
    
    typealias ModelObject = String //This will be your viewModel's object if it has one to be initialised with; if there isn't an object that a certain view model shall use for initialisation just assing the 'Never' data type to the model object typealias
    
    let webservice: WebserviceProtocol
    
    // Uncomment one of the two below; read the comments to see which one to use when
    //let modelObject: ModelObject? //if the ModelObject is of type Never use this
    //@Published var modelObject: ModelObject? //if the ModelObject is not of type Never use this approach and mark it with the @Published wrapper
    
    private(set) var cancelables = Set<AnyCancellable>()
    
    //place here your @Published variables and mark them as private; also do not create Published properties using the wrappedValue initialiser
    
    required init(webservice: WebserviceProtocol = TraceableWebservice(),
                  with model: ModelObject? = nil) {
        self.webservice = webservice
        self.modelObject = model
    }
 
    //... business logic here ...
}*/

