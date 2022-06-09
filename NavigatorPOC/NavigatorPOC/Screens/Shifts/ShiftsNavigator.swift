import UIKit

public final class ShiftsNavigator: Navigator {
	
	var shiftOverview: ShiftOverviewViewModel?
	var jobDetail: JobDetailViewModel?
	var shiftApplicationSkills: ShiftApplicationSkillsViewModel?
	var shiftsApplicationVAT: ShiftApplicationVATViewModel?
	
	public init() {
		super.init(UIViewController()) // HACK: We want the view model's view controller in here, but we can't initialize it properly without a reference to self.
		let viewModel = ShiftOverviewViewModel(showJobHandler: showJob(id:))
		self.rootViewController = viewModel.viewController()
		shiftOverview = viewModel
	}
	
	func showJob(id: String) {
		let viewModel = JobDetailViewModel(jobId: id, startApplicationHandler: startApplication(id:))
		self.handle(navigation: .modal(viewModel, isEmbeddedInNavigation: true))
		self.jobDetail = viewModel
	}
	
	func startApplication(id: String) {
		let viewModel = ShiftApplicationSkillsViewModel(shiftId: id, applyHandler: handleVat(id:))
		self.handle(navigation: .push(viewModel))
		self.shiftApplicationSkills = viewModel
	}
	
	func handleVat(id: String) {
		let viewModel = ShiftApplicationVATViewModel(shiftId: id, applyHandler: finishApplication(id:))
		self.handle(navigation: .push(viewModel))
		self.shiftsApplicationVAT = viewModel
	}
	
	func finishApplication(id: String) {
		self.rootViewController.dismiss(animated: true)
	}
}
