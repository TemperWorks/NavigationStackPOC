import UIKit
import Combine

/// The app's primary navigator, responsible for handling the initial startup and selected deeplinks.
public class AppNavigator: Navigator {
	
	/// The app's environment, containing any useful instances for side-effects.
	public var environment: Environment = AppEnvironment.Current
	
	/// The app's main window.
	public var window: UIWindow
	/// The app's onboarding flow, if any.
	public var onboarding: OnboardingFlow?
	/// The apps shifts navigator.
	public var shiftNavigator: ShiftsNavigator?
	/// the apps' profile screen.
	public var profile: ProfileViewModel?
	
	private var cancellables: Set<AnyCancellable> = []
	
	
	public init(window: UIWindow) {
		self.window = window
		super.init(SplashViewController())
		
		environment.session
			.receive(on: DispatchQueue.main)
			.sink { session in
				self.showFirstScreen(session)
		}.store(in: &cancellables)
	}
	
	/// Determines what the first screen for the user should be.
	///
	/// Usually, this just checks whether the user has an active session and shows either the main app or a sign up/in flow based on that.
	func showFirstScreen(_ session: Session?) {
		if session != nil {
			simulateLogIn()
			shiftNavigator = ShiftsNavigator()
			profile = ProfileViewModel()
			let tabBarController = UITabBarController()
			tabBarController.viewControllers = [shiftNavigator?.rootViewController, profile?.viewController()].compactMap({$0})
			self.rootViewController = tabBarController
			
		} else {
			simulateLogout()
			let navigationController = UINavigationController()
			let onboarding = OnboardingFlow(navigationController)
			self.onboarding = onboarding
			self.rootViewController = navigationController
			
			onboarding.start()
			
			shiftNavigator = nil
			profile = nil
		}
		window.rootViewController = rootViewController
	}
	
}
