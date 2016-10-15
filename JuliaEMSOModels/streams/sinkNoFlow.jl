#-------------------------------------------------------------------
#* EMSO Model Library (EML) Copyright (C) 2004 - 2007 ALSOC.
#*
#* This LIBRARY is free software; you can distribute it and/or modify
#* it under the therms of the ALSOC FREE LICENSE as available at
#* http://www.enq.ufrgs.br/alsoc.
#*
#* EMSO Copyright (C) 2004 - 2007 ALSOC, original code
#* from http://www.rps.eng.br Copyright (C) 2002-2004.
#* All rights reserved.
#*
#* EMSO is distributed under the therms of the ALSOC LICENSE as
#* available at http://www.enq.ufrgs.br/alsoc.
#*
#*--------------------------------------------------------------------
#* Model of basic streams
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt and Rafael de P. Soares
#* $Id$
#*---------------------------------------------------------------------
type sinkNoFlow
	sinkNoFlow()=begin
		new(
			stream(Dict{Symbol,Any}(
				:Brief=>"Inlet Stream",
				:PosX=>0,
				:PosY=>0.5308,
				:Protected=>true,
				:Symbol=>"_{in}"
			)),
			[
				:(Inlet.F = 0 * "kmol/h"),
			],
			[
				"Stream Molar Flow",
			],
			[:Inlet,]
		)
	end
	Inlet::stream 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export sinkNoFlow
function setEquationFlow(in::sinkNoFlow)
	addEquation(1)
end
function atributes(in::sinkNoFlow,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/SinkNoFlow"
	fields[:Brief]="Simple material stream sink"
	fields[:Info]="
	This model should be used for seal an outlet material stream port.
	"
	drive!(fields,_)
	return fields
end
sinkNoFlow(_::Dict{Symbol,Any})=begin
	newModel=sinkNoFlow()
	newModel.attributes=atributes(newModel,_)
	newModel
end
