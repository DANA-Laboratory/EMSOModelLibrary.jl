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
#*--------------------------------------------------------------------
#* Author: Tiago Os��io
#* $Id$
#*-------------------------------------------------------------------
type ConstantSignal
	ConstantSignal()=begin
		new(
			control_signal(),
			control_signal(Dict{Symbol,Any}(
				:PosX=>1,
				:PosY=>0.5
			)),
			[
				:(OutSignal = Value),
			],
			[
				"",
			],
			[:Value,],
			[:OutSignal,]
		)
	end
	Value::control_signal
	OutSignal::control_signal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export ConstantSignal
function setEquationFlow(in::ConstantSignal)
	addEquation(1)
end
function atributes(in::ConstantSignal,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/ConstSignal"
	drive!(fields,_)
	return fields
end
ConstantSignal(_::Dict{Symbol,Any})=begin
	newModel=ConstantSignal()
	newModel.attributes=atributes(newModel,_)
	newModel
end
