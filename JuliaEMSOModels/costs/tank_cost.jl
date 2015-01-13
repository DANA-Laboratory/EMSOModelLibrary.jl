module EMLtank_cost
	using DanaTypes
	using TypeInheritance
	require("EMSOModelLibrary.jl/JuliaEMSOModels/stage_separators/tank.jl")
	using EMLtank
	using EMLtypes
	using EMLstreams
	include("tank_cost/tank_cost.jl")
end