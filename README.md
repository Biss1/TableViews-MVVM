# TableViews-MVVM

A simple project showing the concept of MVVM with using table views for the view controllers.

- Every view controller has it's view model
- Every cell / header / footer or any other view also has it's view model
- Every cell view model has extension which tells what type of cell view it needs to use

In the 'base' folder are defined all the base classes and protocols for cells, headers, footers and their view models. Also base classes for view controller containing a generic view model. 

Also is implemented a sample app for showing a places in UITableView. The places are grouped in sections - can be grouped by category or country: 

Detailed explanation can be found in the following articles:
1. General overview: https://medium.com/@bbisera2/a-story-of-mvvm-with-uitableviews-part-1-78a682d7abb3
2. Using forms: https://medium.com/@bbisera2/mvvm-with-uitableviews-using-forms-part-2-928e3e296c20
