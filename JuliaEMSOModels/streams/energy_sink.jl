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
type energy_sink
	energy_sink()=begin
		new(
			power(Dict{Symbol,Any}(
				:Brief=>"Inlet energy stream",
				:PosX=>0,
				:PosY=>0.5308,
				:Symbol=>"_{in}"
			)),
			[:InletQ,]
		)
	end
	InletQ::power
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export energy_sink
function atributes(in::energy_sink,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/Sink"
	fields[:Brief]="Energy stream sink"
	drive!(fields,_)
	return fields
end
energy_sink(_::Dict{Symbol,Any})=begin
	newModel=energy_sink()
	newModel.attributes=atributes(newModel,_)
	newModel
end
