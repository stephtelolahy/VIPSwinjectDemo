//
//  DashboardInteractor.swift
//  SwinjectDemo
//
//  Created by Hugues Telolahy on 11/03/2023.
//

import Combine

protocol DashboardInteractoring {
    func onSelect(item: DashboardItem)
}

protocol DashboardPresentering {
    func presentItems(_ items: [DashboardItem])
}

class DashboardInteractor: DashboardInteractoring {
    
    private let presenter: DashboardPresentering
    private let service: DashboardServicing
    var router: DashboardRouting?
    private var cancellables = Set<AnyCancellable>()


    init(presenter: DashboardPresentering, service: DashboardServicing) {
        self.presenter = presenter
        self.service = service
        observeDashboard()
    }
    
    private func observeDashboard() {
        service.dashboardItems.sink { [weak self] items in
            self?.presenter.presentItems(items)
        }
        .store(in: &cancellables)
    }

    func onSelect(item: DashboardItem) {
        router?.toItemDetail(item)
    }
}
