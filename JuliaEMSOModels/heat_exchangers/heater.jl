module EMLheater
	using DanaTypes
	using DotPlusInheritance
	require("EMSOModelLibrary.jl/JuliaEMSOModels/streams.jl")
	using EMLstreams
	using EMLtypes
	include("heater/heater_basic.jl")
	include("heater/heater.jl")
	include("heater/cooler.jl")
end