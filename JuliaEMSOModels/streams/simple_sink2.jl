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
type simple_sink2
	simple_sink2()=begin
		new(
			stream(Dict{Symbol,Any}(
				:Brief=>"Inlet Stream",
				:PosX=>1,
				:PosY=>0.5308,
				:Protected=>true,
				:Symbol=>"_{in}"
			)),
			[:Inlet,]
		)
	end
	Inlet::stream
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export simple_sink2
function atributes(in::simple_sink2,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/Sink2"
	fields[:Brief]="Simple material stream sink"
	fields[:Info]="
	This model should be used for boundary streams when no additional
	information about the stream is desired.
	"
	drive!(fields,_)
	return fields
end
simple_sink2(_::Dict{Symbol,Any})=begin
	newModel=simple_sink2()
	newModel.attributes=atributes(newModel,_)
	newModel
end
