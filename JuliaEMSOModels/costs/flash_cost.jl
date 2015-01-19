module EMLflash_cost
	using DanaTypes
	using DotPlusInheritance
	require("EMSOModelLibrary.jl/JuliaEMSOModels/stage_separators/flash.jl")
	using EMLflash
	using EMLtypes
	using EMLstreams
	include("flash_cost/flash_cost.jl")
end