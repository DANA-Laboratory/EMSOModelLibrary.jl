module EMLbatch_dist
	using DanaTypes
	using DotPlusInheritance
	require("EMSOModelLibrary/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("batch_dist/Diff_Dist.jl")
end