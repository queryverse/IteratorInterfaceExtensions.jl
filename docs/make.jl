using Documenter, IteratorInterfaceExtensions

makedocs(
	modules = [IteratorInterfaceExtensions],
	sitename = "IteratorInterfaceExtensions.jl",
	format = Documenter.HTML(analytics = "UA-132838790-1"),
	warnonly = [:missing_docs],
	pages = [
        "Introduction" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/queryverse/IteratorInterfaceExtensions.jl.git"
)
