import UIKit

public protocol Screen {
	/// Creates a new view controller.
	func viewController() -> UIViewController
}
