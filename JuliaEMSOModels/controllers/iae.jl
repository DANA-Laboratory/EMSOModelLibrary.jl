module EMLiae
	using DanaTypes
	using DotPlusInheritance
	using Reexport
	@reexport using ...types.EMLtypes
	import EMLtypes.length
	include("iae/IAE.jl")
end